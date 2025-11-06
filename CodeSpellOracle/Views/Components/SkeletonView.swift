import SwiftUI

struct SkeletonView: View {
    var cornerRadius: CGFloat = Theme.radius.m
    var body: some View {
        RoundedRectangle(cornerRadius: cornerRadius)
            .fill(Color.appSurface)
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(Color.appBorder, lineWidth: 1)
            )
            .shimmer()
    }
}

struct SkeletonText: View {
    var width: CGFloat = 120
    var height: CGFloat = 12
    var body: some View {
        SkeletonView(cornerRadius: 4)
            .frame(width: width, height: height)
    }
}
