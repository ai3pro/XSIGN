import SwiftUI

struct RootView: View {
    @State var currentTab: AppTab = .library
    
    init() {
        // Ẩn tab bar mặc định của hệ thống
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $currentTab) {
                NavigationView {
                    LibraryView()
                        .navigationTitle("Kho Ứng Dụng")
                }
                .tag(AppTab.library)
                
                NavigationView {
                    BuyCertView()
                }
                .tag(AppTab.buyCert)
                
                NavigationView {
                    SettingsView()
                }
                .tag(AppTab.settings)
            }
            
            // Thanh Tab Nổi
            CustomTabBar(currentTab: $currentTab)
                .padding(.bottom, 10)
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
}
