import SwiftUI
import NimbleViews

struct AboutView: View {
    var body: some View {
        NBList("XSign") {
            Section {
                VStack(spacing: 15) {
                    // Logo App
                    Image(uiImage: UIImage(named: "AppIcon") ?? UIImage())
                        .resizable()
                        .frame(width: 80, height: 80)
                        .cornerRadius(18)
                        .shadow(radius: 5)
                    
                    Text("XSign Installer")
                        .font(.title2.bold())
                    
                    Text("Phiên bản 1.0")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                }
                .frame(maxWidth: .infinity)
                .listRowBackground(Color.clear)
            }
            
            NBSection("Thông tin") {
                HStack {
                    Text("Nhà phát triển")
                    Spacer()
                    Text("XSign Team")
                        .foregroundColor(.secondary)
                }
                HStack {
                    Text("Website")
                    Spacer()
                    Text("xsign.app") // Thay web của bạn vào đây
                        .foregroundColor(.blue)
                }
            }
        }
    }
}
