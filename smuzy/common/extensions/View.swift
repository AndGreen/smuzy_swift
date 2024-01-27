import SwiftUI

extension View {
    func pressEvents(onPress: @escaping (() -> Void), onRelease: @escaping (() -> Void)) -> some View {
        modifier(ButtonPress(onPress: onPress, onRelease: onRelease))
    }

    func sideBorder(widths: [Edge: CGFloat], color: Color) -> some View {
        overlay(EdgeBorder(widths: widths).foregroundColor(color))
    }
}

struct EdgeBorder: Shape {
    var widths: [Edge: CGFloat]

    func path(in rect: CGRect) -> Path {
        Path { path in
            for (edge, width) in widths {
                switch edge {
                case .top:
                    path.move(to: CGPoint(x: rect.minX, y: rect.minY))
                    path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
                    path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY + width))
                    path.addLine(to: CGPoint(x: rect.minX, y: rect.minY + width))
                    path.closeSubpath()
                case .bottom:
                    path.move(to: CGPoint(x: rect.minX, y: rect.maxY))
                    path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
                    path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - width))
                    path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY - width))
                    path.closeSubpath()
                case .leading:
                    path.move(to: CGPoint(x: rect.minX, y: rect.minY))
                    path.addLine(to: CGPoint(x: rect.minX + width, y: rect.minY))
                    path.addLine(to: CGPoint(x: rect.minX + width, y: rect.maxY))
                    path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
                    path.closeSubpath()
                case .trailing:
                    path.move(to: CGPoint(x: rect.maxX, y: rect.minY))
                    path.addLine(to: CGPoint(x: rect.maxX - width, y: rect.minY))
                    path.addLine(to: CGPoint(x: rect.maxX - width, y: rect.maxY))
                    path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
                    path.closeSubpath()
                }
            }
        }
    }
}

struct ButtonPress: ViewModifier {
    var onPress: () -> Void
    var onRelease: () -> Void

    func body(content: Content) -> some View {
        content
            .simultaneousGesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { _ in
                        onPress()
                    }
                    .onEnded { _ in
                        onRelease()
                    }
            )
    }
}

