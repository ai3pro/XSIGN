//
//  SourcesViewModel.swift
//  Feather
//
//  Created by samara on 30.04.2025.
//

import Foundation
import AltSourceKit
import SwiftUI
import NimbleJSON
import CoreData

// MARK: - Class
final class SourcesViewModel: ObservableObject {
    static let shared = SourcesViewModel()
    
    typealias RepositoryDataHandler = Result<ASRepository, Error>
    
    private let _dataService = NBFetchService()
    
    var isFinished = true
    @Published var sources: [AltSource: ASRepository] = [:]
    
    func fetchSources(_ sources: FetchedResults<AltSource>, refresh: Bool = false, batchSize: Int = 4) async {
        guard isFinished else { return }
        
        // Kiểm tra nếu dữ liệu đã có thì không load lại trừ khi refresh
        if !refresh, sources.allSatisfy({ self.sources[$0] != nil }) { return }
        
        isFinished = false
        defer { isFinished = true }
        
        await MainActor.run {
            self.sources = [:]
        }
        
        let sourcesArray = Array(sources)
        let context = PersistenceController.shared.container.viewContext
        
        for startIndex in stride(from: 0, to: sourcesArray.count, by: batchSize) {
            let endIndex = min(startIndex + batchSize, sourcesArray.count)
            let batch = sourcesArray[startIndex..<endIndex]
            
            // FIX LỖI: Chuyển đổi sang ID và URL để an toàn khi chạy đa luồng (Sendable)
            let batchData = batch.map { (id: $0.objectID, url: $0.sourceURL) }
            
            // Xử lý tải dữ liệu song song
            let batchResults = await withTaskGroup(of: (NSManagedObjectID, ASRepository?).self, returning: [NSManagedObjectID: ASRepository].self) { group in
                for item in batchData {
                    group.addTask {
                        guard let url = item.url else {
                            return (item.id, nil)
                        }
                        
                        // Giả lập fetch async an toàn
                        return await withCheckedContinuation { continuation in
                            self._dataService.fetch(from: url) { (result: RepositoryDataHandler) in
                                switch result {
                                case .success(let repo):
                                    continuation.resume(returning: (item.id, repo))
                                case .failure(_):
                                    continuation.resume(returning: (item.id, nil))
                                }
                            }
                        }
                    }
                }
                
                var results = [NSManagedObjectID: ASRepository]()
                for await (id, repo) in group {
                    if let repo {
                        results[id] = repo
                    }
                }
                return results
            }
            
            // Cập nhật giao diện trên Main Thread
            await MainActor.run {
                for (id, repo) in batchResults {
                    // Lấy lại object từ ID một cách an toàn
                    if let source = try? context.existingObject(with: id) as? AltSource {
                        self.sources[source] = repo
                    }
                }
            }
        }
    }
}
