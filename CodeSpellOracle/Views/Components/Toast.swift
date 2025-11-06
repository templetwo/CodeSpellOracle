import SwiftUI

struct ToastConfig {
    enum Style { case success, error, info }
    var style: Style
    var message: String
    var duration: Double = 2.0
}

private struct ToastModifier: ViewModifier {
    @Binding var isPresented: Bool
    let config: ToastConfig
    
    func body(content: Content) -> some View {
        ZStack {
            content
            if isPresented {
                VStack {
                    Spacer()
                    HStack {
                        Image(systemName: iconName)
                        Text(config.message)
                            .font(.system(size: 13, weight: .semibold))
                    }
                    .padding(.horizontal, Theme.spacing.xl)
                    .padding(.vertical, Theme.spacing.s)
                    .background(backgroundColor)
                    .foregroundColor(.white)
                    .cornerRadius(Theme.radius.m)
                    .shadow(radius: Theme.elevation.popover)
                    .padding(.bottom, Theme.spacing.xl)
                }
                .transition(.move(edge: .bottom).combined(with: .opacity))
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + config.duration) {
                        withAnimation { isPresented = false }
                    }
                }
            }
        }
        .animation(.easeInOut(duration: 0.2), value: isPresented)
    }
    
    private var backgroundColor: Color {
        switch config.style {
        case .success: return Color.appSuccess
        case .error: return Color.appDanger
        case .info: return Color.appInfo
        }
    }
    private var iconName: String {
        switch config.style {
        case .success: return "checkmark.seal.fill"
        case .error: return "xmark.octagon.fill"
        case .info: return "info.circle.fill"
        }
    }
}

extension View {
    func toast(isPresented: Binding<Bool>, _ config: ToastConfig) -> some View {
        modifier(ToastModifier(isPresented: isPresented, config: config))
    }
}
