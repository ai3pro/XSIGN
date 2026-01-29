import SwiftUI

struct CustomTabBar: View {
    @Binding var currentTab: AppTab // Sử dụng AppTab
    @Namespace var animation
    
    // Màu Xanh Navy
    let brandColor = Color(red: 0.0, green: 0.12, blue: 0.35)
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(AppTab.allCases, id: \.self) { tab in
                Button {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                        currentTab = tab
                    }
                    let impactMed = UIImpactFeedbackGenerator(style: .medium)
                    impactMed.impactOccurred()
                } label: {
                    VStack(spacing: 4) {
                        Image(systemName: tab.icon)
                            .font(.system(size: 24))
                            .scaleEffect(currentTab == tab ? 1.2 : 1.0)
                        
                        if currentTab == tab {
                            Text(tab.title)
                                .font(.caption2)
                                .fontWeight(.bold)
                                .transition(.opacity.combined(with: .move(edge: .bottom)))
                                .lineLimit(1)
                        }
                    }
                    .foregroundColor(currentTab == tab ? .white : .gray.opacity(0.8))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .background {
                        if currentTab == tab {
                            RoundedRectangle(cornerRadius: 20, style: .continuous)
                                .fill(brandColor.gradient)
                                .matchedGeometryEffect(id: "TAB_BG", in: animation)
                        }
                    }
                }
            }
        }
        .padding(6)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
        .shadow(color: .black.opacity(0.15), radius: 10, x: 0, y: 10)
        .padding(.horizontal, 20)
    }
}
