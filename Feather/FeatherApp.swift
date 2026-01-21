import SwiftUI
import Nuke

@main
struct FeatherApp: App {
    // Màu chủ đạo thương hiệu ThaiSon iOS (Xanh Navy đậm sang trọng)
    // Bạn có thể đổi thành màu khác, ví dụ .orange hoặc một mã hex cụ thể
    let brandColor: Color = Color(red: 0.0, green: 0.12, blue: 0.35) 
    
    init() {
        // Cấu hình giao diện chuẩn Apple khi khởi động
        setupAppearance()
    }
    
    var body: some Scene {
        WindowGroup {
            // SỬ DỤNG TABVIEW CHUẨN CỦA APPLE
            TabView {
                // Tab 1: Kho Ứng dụng
                NavigationView {
                    LibraryView() // Giữ lại logic thư viện cũ, nhưng đặt trong NavView
                        .navigationTitle("Kho Ứng Dụng")
                }
                .tabItem {
                    Label("Ứng dụng", systemImage: "square.grid.2x2.fill")
                }
                
                // Tab 2: VIP & Ký (Gộp lại cho gọn)
                NavigationView {
                    BuyCertView()
                }
                .tabItem {
                    Label("VIP & Ký", systemImage: "signature")
                }
                
                // Tab 3: Cài đặt & Thương hiệu
                NavigationView {
                    SettingsView()
                }
                .tabItem {
                    Label("Cài đặt", systemImage: "gear")
                }
            }
            .accentColor(brandColor) // Áp dụng màu thương hiệu lên toàn bộ icon, nút bấm
        }
    }
    
    func setupAppearance() {
        // Cấu hình Navigation Bar trong suốt kiểu hiện đại
        let navAppearance = UINavigationBarAppearance()
        navAppearance.configureWithTransparentBackground()
        navAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor(brandColor)]
        navAppearance.titleTextAttributes = [.foregroundColor: UIColor(brandColor)]
        
        UINavigationBar.appearance().standardAppearance = navAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navAppearance
        
        // Cấu hình Tab Bar trong suốt mờ (Translucent)
        let tabAppearance = UITabBarAppearance()
        tabAppearance.configureWithDefaultBackground()
        UITabBar.appearance().standardAppearance = tabAppearance
        UITabBar.appearance().scrollEdgeAppearance = tabAppearance
    }
}
