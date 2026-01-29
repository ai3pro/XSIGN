import SwiftUI

struct RootView: View {
    @State var currentTab: AppTab = .library
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            
            // 1. NỘI DUNG CHÍNH
            TabView(selection: $currentTab) {
                NavigationView {
                    LibraryView()
                        .navigationTitle("Kho Ứng Dụng")
                }
                .tag(AppTab.library)
                
                // Màn hình Nguồn iPA
                NavigationView {
                    SourcesView()
                        .navigationTitle("Nguồn iPA")
                }
                .tag(AppTab.sources) // Đảm bảo bạn đã thêm case sources vào AppTab
                
                NavigationView {
                    BuyCertView()
                }
                .tag(AppTab.buyCert)
                
                NavigationView {
                    SettingsView()
                }
                .tag(AppTab.settings)
            }
            // 👇 [QUAN TRỌNG] Dòng này đẩy nội dung lên để không bị Tabbar che mất 👇
            .safeAreaInset(edge: .bottom) {
                Color.clear.frame(height: 80)
            }
            
            // 2. THANH TAB NỔI
            CustomTabBar(currentTab: $currentTab)
                .padding(.bottom, 10)
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
}
