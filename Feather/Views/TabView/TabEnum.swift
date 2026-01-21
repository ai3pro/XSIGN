import SwiftUI

enum Tab: String, CaseIterable {
    case library
    case buyCert // Tab VIP mới
    case settings
    
    var title: LocalizedStringKey {
        switch self {
        case .library: return "Kho Ứng Dụng"
        case .buyCert: return "Mua VIP"
        case .settings: return "Cài Đặt"
        }
    }
    
    var icon: String {
        switch self {
        case .library: return "square.stack.3d.up.fill"
        case .buyCert: return "crown.fill" // Icon Vương miện cho VIP
        case .settings: return "gearshape.fill"
        }
    }
}
