import SwiftUI

// Đổi tên thành AppTab
enum AppTab: String, CaseIterable {
    case library = "Kho Ứng Dụng"
    case buyCert = "Mua VIP"
    case settings = "Cài Đặt"
    
    var icon: String {
        switch self {
        case .library: return "square.grid.2x2.fill"
        case .buyCert: return "crown.fill"
        case .settings: return "gearshape.fill"
        }
    }
}
