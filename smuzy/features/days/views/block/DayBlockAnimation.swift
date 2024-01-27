import SwiftUI

struct AnimationProperties {
    var scale = 1.0
    var opacity = 0.0
    var shadowRadius = 0.0
}

struct DayBlockAnimation: View {
    var blockColor: Color?
    var blockWidth: Double
    var onTap: () -> Void

    @State private var shouldAnimate = false
    @State private var show = false
    @State private var shakes = 0

    init(blockColor: Color?, blockWidth: Double, onTap: @escaping () -> Void) {
        self.blockColor = blockColor
        self.blockWidth = blockWidth
        self.onTap = onTap
    }
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.white.opacity(0.001))
                .frame(width: blockWidth, height: blockWidth)
                .sensoryFeedback(.impact(weight: .light, intensity: 0.5), trigger: show)
                .onTapGesture {
                    onTap()
                    show.toggle()

                    // TODO: is it possible to do it without DispatchQueue?
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        show.toggle()
                    }
                }

           
            if show == true {
                Rectangle()
                    .fill(blockColor ?? .clear)
                    .frame(width: blockWidth, height: blockWidth)
                    .onAppear {
                        shakes = 1
                    }
                    .onDisappear {
                        shakes = 0
                    }
                    .keyframeAnimator(initialValue: AnimationProperties(), trigger: shakes) {
                        content, value in
                        content
                            .scaleEffect(value.scale)
                            .opacity(value.opacity)
                            .shadow(radius: value.shadowRadius)
                    } keyframes: { _ in
                        KeyframeTrack(\.scale) {
                            SpringKeyframe(1.5, duration: 0.1)
                            SpringKeyframe(0.7, duration: 0.1)
                        }
                        
                        KeyframeTrack(\.opacity) {
                            MoveKeyframe(1)
                            LinearKeyframe(1, duration: 0.15)
                            MoveKeyframe(0)
                        }
                        
                        KeyframeTrack(\.shadowRadius) {
                            MoveKeyframe(5)
                            LinearKeyframe(5, duration: 0.15)
                            MoveKeyframe(0)
                        }
                    }
            }
           
        }
    }
}
