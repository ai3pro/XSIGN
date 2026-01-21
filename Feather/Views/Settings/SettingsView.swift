import SwiftUI
import NimbleViews

struct SettingsView: View {
    var body: some View {
        NavigationView {
            List {
                // PHẦN 1: HEADER THAISON IOS (Hiệu ứng đẹp)
                Section {
                    HStack {
                        Spacer()
                        VStack(spacing: 8) {
                            Text("ThaiSon iOS")
                                .font(.system(size: 30, weight: .heavy, design: .rounded))
                                .foregroundStyle(
                                    LinearGradient(
                                        colors: [.blue, .purple, .pink],
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                )
                                .shadow(color: .blue.opacity(0.5), radius: 5, x: 0, y: 2)
                            
                            Text("Phiên bản XSign Premium")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                    }
                    .padding(.vertical, 20)
                    .listRowBackground(Color.clear)
                }
                
                // PHẦN 2: MUA CHỨNG CHỈ (Nổi bật)
                Section {
                    Link(destination: URL(string: "https://zalo.me/sdt_cua_ban")!) {
                        HStack {
                            Image(systemName: "crown.fill")
                                .foregroundColor(.yellow)
                            VStack(alignment: .leading) {
                                Text("Mua chứng chỉ VIP")
                                    .font(.headline)
                                    .foregroundColor(.primary)
                                Text("Chỉ 75k/năm - Bảo hành 1:1")
                                    .font(.caption)
                                    .foregroundColor(.red)
                            }
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.gray)
                        }
                    }
                } header: {
                    Text("Dịch vụ VIP")
                }
                
                // PHẦN 3: CÁC CÀI ĐẶT CẦN THIẾT (Giữ lại tính năng ký)
                Section(header: Text("Quản lý ký")) {
                    NavigationLink(destination: CertificatesView()) {
                        Label("Quản lý Chứng chỉ", systemImage: "signature")
                    }
                    
                    NavigationLink(destination: ConfigurationView()) {
                        Label("Tùy chỉnh Ký (Signing)", systemImage: "gearshape.2")
                    }
                    
                    NavigationLink(destination: ArchiveView()) {
                        Label("Nén & Giải nén", systemImage: "archivebox")
                    }
                }
                
                // PHẦN 4: HỆ THỐNG
                Section(header: Text("Hệ thống")) {
                    NavigationLink(destination: ResetView()) {
                        Label("Đặt lại ứng dụng", systemImage: "trash")
                            .foregroundColor(.red)
                    }
                }
            }
            .navigationTitle("Cài đặt")
        }
    }
}
