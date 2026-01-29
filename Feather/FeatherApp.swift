import SwiftUI
import Nuke
import IDeviceSwift

@main
struct FeatherApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    // Khởi tạo các Manager quan trọng
    @StateObject var downloadManager = DownloadManager.shared
    @StateObject var optionsManager = OptionsManager.shared // <--- THÊM CÁI NÀY
    
    let storage = Storage.shared
    
    // Màu thương hiệu Xanh Navy
    let brandColor = Color(red: 0.0, green: 0.12, blue: 0.35)

    var body: some Scene {
        WindowGroup {
            RootView()
                // 1. CoreData (Dữ liệu app)
                .environment(\.managedObjectContext, storage.context)
                
                // 2. Download Manager (Quản lý tải xuống - Fix crash Library)
                .environmentObject(downloadManager)
                
                // 3. Options Manager (Quản lý cài đặt - FIX CRASH SETTING)
                .environmentObject(optionsManager)
                
                .accentColor(brandColor)
                .onOpenURL(perform: handleURL)
                .onAppear {
                    setupAppearance()
                }
        }
    }
    
    private func handleURL(_ url: URL) {
        if url.scheme == "xsign" {
             if let fullPath = url.validatedScheme(after: "/install/"),
               let downloadURL = URL(string: fullPath) {
                _ = DownloadManager.shared.startDownload(from: downloadURL)
            }
        } else {
            if url.pathExtension == "ipa" || url.pathExtension == "tipa" {
                 FR.handlePackageFile(url) { _ in }
            }
        }
    }
    
    func setupAppearance() {
        ImagePipeline.shared = ImagePipeline(configuration: .withDataCache)
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        let fileManager = FileManager.default
        let directories = [fileManager.archives, fileManager.certificates, fileManager.signed, fileManager.unsigned]
        for url in directories {
            try? fileManager.createDirectoryIfNeeded(at: url)
        }
        return true
    }
}
