import SwiftUI
import NimbleViews

struct VariedTabbarView: View {
    // Tự động lấy màu chủ đạo đã cài (Xanh/Tím/Vàng...)
    @AppStorage("XSign.Tint") var userTintColor: String = "#007AFF"
    @State var tab: Tab = .library
    
    var body: some View {
        ZStack(alignment: .bottom) {
            // Nội dung chính của từng màn hình
            content
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .safeAreaInset(edge: .bottom) {
                    // Khoảng trống để không bị Tabbar che mất nội dung
                    Color.clear.frame(height: 80)
                }
            
            // Thanh Tabbar ở dưới đáy
            VStack(spacing: 0) {
                Divider() // Đường kẻ mờ ngăn cách
                    .background(Color(UIColor.separator))
                
                HStack {
                    ForEach(Tab.allCases, id: \.self) { item in
                        Button {
                            // Hiệu ứng rung nhẹ khi bấm
                            let generator = UIImpactFeedbackGenerator(style: .light)
                            generator.impactOccurred()
                            
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                                tab = item
                            }
                        } label: {
                            VStack(spacing: 4) {
                                Image(systemName: item.icon)
                                    .font(.system(size: 22, weight: tab == item ? .bold : .medium))
                                    .scaleEffect(tab == item ? 1.1 : 1.0) // Phóng to nhẹ khi chọn
                                
                                Text(item.title)
                                    .font(.system(size: 10, weight: tab == item ? .semibold : .medium))
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.top, 10)
                            .padding(.bottom, 5)
                            // SỬA: Dùng safeHex thay vì hex để tránh lỗi ambiguous
                            .foregroundColor(tab == item ? Color(safeHex: userTintColor) ?? .blue : .gray)
                        }
                    }
                }
                .padding(.bottom, 20) // Đẩy lên khỏi cạnh dưới màn hình iPhone tai thỏ
                .background(.regularMaterial) // Hiệu ứng mờ nền (Blur) giống iOS gốc
            }
        }
        .ignoresSafeArea(.keyboard) // Tránh bị bàn phím đẩy lên
    }
    
    // Điều hướng màn hình
    @ViewBuilder
    var content: some View {
        switch tab {
        case .library:
            LibraryView() // Màn hình danh sách App đã cài
        case .buyCert:
            BuyCertView() // Màn hình Mua VIP
        case .settings:
            SettingsView() // Màn hình Cài đặt ThaiSon iOS
        }
    }
}

// SỬA: Đổi tên hàm init thành safeHex để không trùng với thư viện khác
extension Color {
    init?(safeHex: String) {
        var hexSanitized = safeHex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0

        var r: CGFloat = 0.0
        var g: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 1.0

        let length = hexSanitized.count

        guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else { return nil }

        if length == 6 {
            r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
            g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
            b = CGFloat(rgb & 0x0000FF) / 255.0

        } else if length == 8 {
            r = CGFloat((rgb & 0xFF000000) >> 24) / 255.0
            g = CGFloat((rgb & 0x00FF0000) >> 16) / 255.0
            b = CGFloat((rgb & 0x0000FF00) >> 8) / 255.0
            a = CGFloat(rgb & 0x000000FF) / 255.0

        } else {
            return nil
        }

        self.init(red: r, green: g, blue: b, opacity: a)
    }
}
