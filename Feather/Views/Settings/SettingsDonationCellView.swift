import SwiftUI

struct BuyCertView: View {
    var body: some View {
        NavigationView {
            ZStack {
                // Màu nền Gradient đẹp mắt
                LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.3), Color.purple.opacity(0.3)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 25) {
                    Image(systemName: "crown.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 80, height: 80)
                        .foregroundColor(.yellow)
                        .shadow(color: .orange, radius: 10)
                    
                    Text("ThaiSon iOS VIP")
                        .font(.system(size: 32, weight: .bold, design: .rounded))
                        .foregroundColor(.primary)
                    
                    Text("Sở hữu chứng chỉ cá nhân ổn định\nKhông bị thu hồi, bảo hành 1 năm.")
                        .multilineTextAlignment(.center)
                        .font(.body)
                        .foregroundColor(.secondary)
                        .padding(.horizontal)
                    
                    // Thẻ giá tiền
                    VStack {
                        Text("Gói Siêu Tốc")
                            .font(.headline)
                            .foregroundColor(.white)
                        Text("75.000đ / Năm")
                            .font(.system(size: 28, weight: .heavy))
                            .foregroundColor(.yellow)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(20)
                    .shadow(radius: 5)
                    .padding(.horizontal, 40)
                    
                    Spacer()
                    
                    // Nút mua hàng
                    Link(destination: URL(string: "https://zalo.me/sdt_cua_ban")!) { // Thay link Zalo/Facebook của bạn vào đây
                        HStack {
                            Image(systemName: "cart.fill")
                            Text("MUA NGAY (ZALO/FB)")
                                .fontWeight(.bold)
                        }
                        .font(.title3)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(LinearGradient(gradient: Gradient(colors: [Color.green, Color.teal]), startPoint: .leading, endPoint: .trailing))
                        .foregroundColor(.white)
                        .cornerRadius(15)
                        .shadow(radius: 5)
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 30)
                }
                .padding(.top, 40)
            }
            .navigationTitle("Nâng cấp VIP")
        }
    }
}
