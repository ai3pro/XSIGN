import SwiftUI
import Nuke
import IDeviceSwift

@main
struct XSignApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject var downloadManager = DownloadManager.shared
    let storage = Storage.shared
    
    // MÀU CHỦ ĐẠO: Bạn có thể đổi mã Hex này (ví dụ: #FF0000 là đỏ)
    let themeColor = UIColor(red: 0.0, green: 0.48, blue: 1.0, alpha: 1.0) // Màu xanh Apple

    var body: some Scene {
        WindowGroup {
            VStack {
                DownloadHeaderView(downloadManager: downloadManager)
                VariedTabbarView()
                    .environment(\.managedObjectContext, storage.context)
                    .onOpenURL(perform: handleURL)
            }
            .accentColor(Color(themeColor)) // Ép toàn bộ app theo màu này
            .onAppear {
                // Ép giao diện Sáng/Tối theo ý bạn (ở đây là tự động)
                UIApplication.topViewController()?.view.window?.tintColor = themeColor
            }
        }
    }

    private func handleURL(_ url: URL) {
        // Xử lý link xsign://
        if url.scheme == "xsign" {
            if let fullPath = url.validatedScheme(after: "/install/"),
               let downloadURL = URL(string: fullPath) {
                _ = DownloadManager.shared.startDownload(from: downloadURL)
            }
        } else {
            // Mở file .ipa trực tiếp
            if url.pathExtension == "ipa" {
                FR.handlePackageFile(url) { _ in }
            }
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        // Khởi tạo bộ nhớ đệm hình ảnh
        ImagePipeline.shared = ImagePipeline(configuration: .withDataCache)
        // Tạo các thư mục cần thiết
        let fileManager = FileManager.default
        [fileManager.archives, fileManager.certificates, fileManager.signed].forEach {
            try? fileManager.createDirectoryIfNeeded(at: $0)
        }
        return true
    }
}
