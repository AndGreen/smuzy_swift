import SwiftUI

struct AddRoutineButton: View {
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: "plus")
                    .font(.system(size: 24))
                    .foregroundColor(.blue)

                Text("Add")
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 12)
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.gray.opacity(0.2), lineWidth: 1)
            )
        }
    }
}

#Preview {
    AddRoutineButton(action: {})
}
