import SwiftUI
import Nuke
import IDeviceSwift

@main
struct FeatherApp: App {
    // 1. KHÔI PHỤC BỘ ĐỘNG CƠ CŨ (QUAN TRỌNG ĐỂ KHÔNG BỊ LỖI 65)
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject var downloadManager = DownloadManager.shared
    let storage = Storage.shared
    
    // 2. MÀU THƯƠNG HIỆU (Xanh Navy Sang Trọng)
    let brandColor: Color = Color(red: 0.0, green: 0.12, blue: 0.35)

    var body: some Scene {
        WindowGroup {
            // 3. GIAO DIỆN MỚI CHUẨN APPLE (TabView)
            TabView {
                // Tab 1: Kho Ứng dụng
                NavigationView {
                    LibraryView()
                        .navigationTitle("Kho Ứng Dụng")
                }
                .tabItem {
                    Label("Ứng dụng", systemImage: "square.grid.2x2.fill")
                }
                .environment(\.managedObjectContext, storage.context) // Phải có dòng này mới load được danh sách app
                
                // Tab 2: Mua VIP (Gộp Ký vào đây hoặc tách ra tùy bạn)
                NavigationView {
                    BuyCertView()
                }
                .tabItem {
                    Label("VIP & Ký", systemImage: "signature")
                }
                
                // Tab 3: Cài đặt
                NavigationView {
                    SettingsView()
                }
                .tabItem {
                    Label("Cài đặt", systemImage: "gear")
                }
            }
            .accentColor(brandColor) // Nhuộm màu toàn bộ App
            .onOpenURL(perform: handleURL)
            .onAppear {
                setupAppearance()
            }
        }
    }
    
    // XỬ LÝ LINK MỞ APP (Giữ lại để không bị lỗi logic)
    private func handleURL(_ url: URL) {
        if url.scheme == "xsign" {
             // Logic cài đặt từ web
             if let fullPath = url.validatedScheme(after: "/install/"),
               let downloadURL = URL(string: fullPath) {
                _ = DownloadManager.shared.startDownload(from: downloadURL)
            }
        } else {
            // Logic mở file .ipa trực tiếp
            if url.pathExtension == "ipa" || url.pathExtension == "tipa" {
                 FR.handlePackageFile(url) { _ in }
            }
        }
    }
    
    // CẤU HÌNH GIAO DIỆN TRONG SUỐT
    func setupAppearance() {
        let navAppearance = UINavigationBarAppearance()
        navAppearance.configureWithTransparentBackground()
        navAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor(brandColor)]
        navAppearance.titleTextAttributes = [.foregroundColor: UIColor(brandColor)]
        
        UINavigationBar.appearance().standardAppearance = navAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navAppearance
        
        let tabAppearance = UITabBarAppearance()
        tabAppearance.configureWithDefaultBackground()
        UITabBar.appearance().standardAppearance = tabAppearance
        UITabBar.appearance().scrollEdgeAppearance = tabAppearance
    }
}

// LỚP CẤU HÌNH HỆ THỐNG (Class này bị thiếu ở bước trước gây lỗi 65)
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        // Cấu hình bộ nhớ đệm ảnh (Nuke)
        ImagePipeline.shared = ImagePipeline(configuration: .withDataCache)
        
        // Tạo các thư mục lưu trữ cần thiết
        let fileManager = FileManager.default
        let directories = [fileManager.archives, fileManager.certificates, fileManager.signed, fileManager.unsigned]
        for url in directories {
            try? fileManager.createDirectoryIfNeeded(at: url)
        }
        return true
    }
}
