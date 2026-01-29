//
//  ExtendedTabbarView.swift
//  feather
//
//  Created by samara on 5/17/24.
//  Copyright (c) 2024 Samara M (khcrysalis)
//

import SwiftUI
import NukeUI

@available(iOS 18, *)
struct ExtendedTabbarView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @AppStorage("Feather.tabCustomization") var customization = TabViewCustomization()
    @StateObject var viewModel = SourcesViewModel.shared
    
    @State private var _isAddingPresenting = false
    
    // Logic tương thích ngược cho TabBar cũ
    var body: some View {
        TabView {
            // SỬA: Dùng Tab.allCases thay vì TabEnum.defaultTabs
            ForEach(Tab.allCases, id: \.self) { tab in
                Tab(tab.title, systemImage: tab.icon) {
                    view(for: tab)
                }
            }
            
            // Phần Sources cũ (có thể giữ lại nếu muốn hiển thị Sources trong tab bar cũ)
            /*
            TabSection("Sources") {
               // ... (Giữ nguyên logic cũ nếu cần, hoặc comment lại nếu không dùng)
            }
            */
        }
        .tabViewStyle(.sidebarAdaptable)
        .tabViewCustomization($customization)
    }
    
    // Helper để trả về View tương ứng cho Tab
    @ViewBuilder
    func view(for tab: Tab) -> some View {
        switch tab {
        case .library:
            LibraryView()
        case .buyCert:
            BuyCertView()
        case .settings:
            SettingsView()
        }
    }
    
    // ... (Giữ lại các helper khác nếu cần)
    var standardIcon: some View {
        Image(systemName: "app.dashed")
    }
}
