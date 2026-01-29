//
//  AppearanceTintColorView.swift
//  Feather
//
//  Created by samara on 14.06.2025.
//

import SwiftUI

// MARK: - View
struct AppearanceTintColorView: View {
    @AppStorage("Feather.userTintColor") private var selectedColorHex: String = "#848ef9"
    private let tintOptions: [(name: String, hex: String)] = [
        ("Default",         "#848ef9"),
        ("V2",              "#B496DC"),
        ("Berry",           "#ff7a83"),
        ("Cool Blue",       "#4161F1"),
        ("Fuchsia",         "#FF00FF"),
        ("Protokolle",      "#4CD964"),
        ("Aidoku",          "#FF2D55"),
        ("Clock",           "#FF9500"),
        ("Peculiar",        "#4860e8"),
        ("Very Peculiar",   "#5394F7"),
        ("Emily",           "#e18aab")
    ]
    // MARK: Body
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHGrid(rows: [GridItem(.fixed(100))], spacing: 12) {
                ForEach(tintOptions, id: \.hex) { option in
                    // SỬA: Gọi hàm init đúng cách
                    let color = Color(safeHex: option.hex) ?? Color.blue
                    let cornerRadius = {
                        if #available(iOS 26.0, *) {
                            28.0
                        } else {
                            10.5
                        }
                    }()
                    VStack(spacing: 8) {
                        Circle()
                            .fill(color)
                            .frame(width: 30, height: 30)
                            .overlay(
                                Circle()
                                    .strokeBorder(Color.black.opacity(0.3), lineWidth: 2)
                            )

                        Text(option.name)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .frame(width: 120, height: 100)
                    .background(Color(uiColor: .secondarySystemGroupedBackground))
                    .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
                    .overlay(
                        RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                            .strokeBorder(selectedColorHex == option.hex ? color : .clear, lineWidth: 2)
                    )
                    .onTapGesture {
                        selectedColorHex = option.hex
                    }
                    .accessibilityLabel(Text(option.name))
                }
            }
        }
        .onChange(of: selectedColorHex) { value in
            UIApplication.topViewController()?.view.window?.tintColor = UIColor(Color(safeHex: value) ?? .blue)
        }
    }
}

// SỬA: Thêm lại Extension này (bị mất khi xóa VariedTabbarView)
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
