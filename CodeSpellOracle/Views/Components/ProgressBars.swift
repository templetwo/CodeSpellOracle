import SwiftUI

struct NeonProgressBar: View {
    let progress: CGFloat // 0...1
    let height: CGFloat = 10
    
    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: height/2)
                    .fill(Color.appSurface)
                    .overlay(
                        RoundedRectangle(cornerRadius: height/2)
                            .stroke(Color.appBorder, lineWidth: 1)
                    )
                RoundedRectangle(cornerRadius: height/2)
                    .fill(
                        LinearGradient(colors: [Theme.colors.primary, Theme.colors.accent], startPoint: .leading, endPoint: .trailing)
                    )
                    .frame(width: max(0, min(geo.size.width, geo.size.width * progress)))
                    .animation(.easeInOut(duration: 0.25), value: progress)
            }
        }
        .frame(height: height)
    }
}
