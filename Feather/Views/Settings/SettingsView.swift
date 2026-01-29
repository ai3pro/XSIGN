import SwiftUI
import NimbleViews

struct SettingsView: View {
    var body: some View {
        List {
            // --- PHẦN 1: HEADER THƯƠNG HIỆU (Tối giản, Sang trọng) ---
            Section {
                HStack(spacing: 15) {
                    // Logo thương hiệu
                    Image(uiImage: UIImage(named: "AppIcon") ?? UIImage())
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 60, height: 60)
                        .cornerRadius(14)
                        .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("ThaiSon iOS")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                        
                        Text("Công cụ Ký & Quản lý IPA chuyên nghiệp")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
                .padding(.vertical, 10)
            }
            .listRowBackground(Color.clear)
            
            // --- PHẦN 2: DỊCH VỤ CỐT LÕI (VIP) ---
            Section(header: Text("Dịch vụ")) {
                NavigationLink(destination: BuyCertView()) {
                    HStack {
                        Image(systemName: "crown.fill")
                            .foregroundColor(.yellow)
                            .font(.title3)
                            .frame(width: 30)
                        
                        VStack(alignment: .leading) {
                            Text("Nâng cấp Chứng chỉ VIP")
                                .fontWeight(.medium)
                            Text("Ổn định, bảo hành 1 năm")
                                .font(.caption2)
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
            
            // --- PHẦN 3: QUẢN LÝ KỸ THUẬT ---
            Section(header: Text("Quản lý Ký")) {
                NavigationLink(destination: CertificatesView()) {
                    Label("Chứng chỉ của bạn", systemImage: "doc.text.fill")
                }
                NavigationLink(destination: ConfigurationView()) {
                    Label("Cấu hình ký (Signing)", systemImage: "slider.horizontal.3")
                }
            }
            
            // --- PHẦN 4: TIỆN ÍCH KHÁC ---
            Section(header: Text("Tiện ích")) {
                NavigationLink(destination: ArchiveView()) {
                    Label("Quản lý file nén (.zip)", systemImage: "archivebox.fill")
                }
                NavigationLink(destination: ResetView()) {
                    Label("Đặt lại ứng dụng", systemImage: "arrow.counterclockwise")
                        .foregroundColor(.red)
                }
            }
            
            // Footer bản quyền tinh tế
            Section {
                HStack {
                    Spacer()
                    Text("Designed by ThaiSon iOS © 2026")
                        .font(.footnote)
                        // SỬA: Chuyển đổi UIColor.tertiaryLabel sang Color chuẩn SwiftUI
                        .foregroundColor(Color(UIColor.tertiaryLabel))
                    Spacer()
                }
                .listRowBackground(Color.clear)
            }
        }
        .listStyle(.insetGrouped)
        .navigationTitle("Cài đặt")
    }
}
