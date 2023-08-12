//
//  RoutinesListView.swift
//  smuzy
//
//  Created by Andrey Zelenin on 12.08.2023.
//

import SwiftUI

struct HWrap<Item, ItemView, LastItemView>: View where Item: Identifiable, Item: Equatable, ItemView: View, LastItemView: View {
    var items: [Item]
    var itemView: (Item) -> ItemView
    var lastItemView: (Item) -> LastItemView

    @State private var totalHeight: CGFloat = .zero

    var body: some View {
        VStack {
            GeometryReader { geometry in
                self.generateContent(in: geometry)
            }
        }
        .frame(height: totalHeight)
    }

    private func generateContent(in g: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero

        return ZStack(alignment: .topLeading) {
            ForEach(items) { item in

                self.itemView(item)
                    .padding([.horizontal, .vertical], 4)
                    .alignmentGuide(.leading, computeValue: { d in
                        if abs(width - d.width) > g.size.width {
                            width = 0
                            height -= d.height
                        }
                        let result = width
                        if item == self.items.last {
                            width = 0 // last item
                        } else {
                            width -= d.width
                        }
                        return result
                    })
                    .alignmentGuide(.top, computeValue: { _ in
                        let result = height
                        if item == self.items.last {
                            height = 0 // last item
                        }
                        return result
                    })
            }
        }.background(viewHeightReader($totalHeight))
    }

    private func viewHeightReader(_ binding: Binding<CGFloat>) -> some View {
        return GeometryReader { geometry -> Color in
            let rect = geometry.frame(in: .local)
            DispatchQueue.main.async {
                binding.wrappedValue = rect.size.height
            }
            return .clear
        }
    }
}

struct RoutinesListView: View {
    let routines: [Routine] = [
        Routine(
            color: .blue, title: "media"),
        Routine(color: .green, title: "sleep"),
        Routine(color: .orange, title: "work")
    ]

    var body: some View {
        HWrap(items: routines, itemView: { routine in
            RoutineButtonView(routine: routine)
        }, lastItemView: { _ in
            Text("This is the last routine")
                .font(.headline)
                .padding()
        })
    }
}

struct RoutinesListView_Previews: PreviewProvider {
    static var previews: some View {
        RoutinesListView()
    }
}
