import SwiftUI

struct BuyCertView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                // Header Hình ảnh
                VStack(spacing: 15) {
                    Image(systemName: "checkmark.seal.fill")
                        .font(.system(size: 70))
                        .foregroundColor(.blue) // Dùng màu chủ đạo
                        .padding()
                        .background(Color.blue.opacity(0.1))
                        .clipShape(Circle())
                    
                    Text("Chứng chỉ VIP ThaiSon iOS")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                    
                    Text("Giải pháp ký ứng dụng ổn định nhất cho thiết bị của bạn.")
                        .font(.body)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }
                .padding(.top, 40)
                
                // Danh sách lợi ích (Kiểu Apple)
                VStack(alignment: .leading, spacing: 20) {
                    BenefitRow(icon: "person.fill.checkmark", title: "Chứng chỉ Riêng Tư", description: "Không dùng chung, giảm tối đa rủi ro thu hồi.")
                    BenefitRow(icon: "calendar.badge.clock", title: "Bảo hành 1 Năm", description: "Hỗ trợ 1 đổi 1 trong suốt thời gian sử dụng.")
                    BenefitRow(icon: "bolt.fill", title: "Ký tốc độ cao", description: "Không giới hạn số lượng ứng dụng cài đặt.")
                }
                .padding(25)
                .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(20)
                .padding(.horizontal)
                
                Spacer(minLength: 30)
                
                // Thẻ giá và nút mua
                VStack(spacing: 15) {
                    Text("Chỉ 75.000đ / Năm")
                        .font(.title2)
                        .fontWeight(.heavy)
                    
                    Link(destination: URL(string: "https://zalo.me/sdt_cua_ban")!) {
                        Text("Liên hệ Mua ngay (Zalo)")
                            .font(.headline)
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue) // Màu chủ đạo
                            .foregroundColor(.white)
                            .cornerRadius(15)
                    }
                    
                    Text("Thanh toán nhanh qua Zalo/Bank. Kích hoạt sau 5 phút.")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                .padding(.horizontal, 30)
                .padding(.bottom, 30)
            }
        }
        .navigationTitle("Nâng cấp VIP")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// Component dòng lợi ích
struct BenefitRow: View {
    let icon: String
    let title: String
    let description: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 15) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundColor(.blue)
                .frame(width: 30)
            VStack(alignment: .leading, spacing: 5) {
                Text(title)
                    .fontWeight(.semibold)
                Text(description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
    }
}
