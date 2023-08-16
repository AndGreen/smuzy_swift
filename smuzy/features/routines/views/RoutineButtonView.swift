import SwiftData
import SwiftUI

struct RoutineButtonView: View {
    var routine: Routine
    var isActive: Bool = false // Default value is false
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Circle()
                    .fill(Color.fromHex(routine.color))
                    .frame(width: 18, height: 18)
                    .overlay(
                        Circle()
                            .strokeBorder(isActive ? Color.white : Color.clear, lineWidth: 2)
                    )

                Text(routine.title)
                    .padding(.leading, 3)
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 12)
            .background(isActive ? Color.blue.opacity(0.8) : Color.gray.opacity(0.1))
            .cornerRadius(10)
            .foregroundColor(isActive ? .white : .primary)
        }
    }
}

#Preview {
    RoutineButtonView(routine: Routine(color: Color.blue.toHex, title: "Morning Routine")) {}
        .modelContainer(for: Routine.self)
        .previewLayout(.sizeThatFits)
        .padding()
}
