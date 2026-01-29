import SwiftUI

enum AppTab: String, CaseIterable {
    case library
    case sources // Thêm tab Nguồn
    case buyCert
    case settings
    
    var title: LocalizedStringKey {
        switch self {
        case .library: return "Kho Ứng Dụng"
        case .sources: return "Nguồn iPA" // Tên hiển thị
        case .buyCert: return "Mua VIP"
        case .settings: return "Cài Đặt"
        }
    }
    
    var icon: String {
        switch self {
        case .library: return "square.stack.3d.up.fill"
        case .sources: return "globe.americas.fill" // Icon quả địa cầu
        case .buyCert: return "crown.fill"
        case .settings: return "gearshape.fill"
        }
    }
}
