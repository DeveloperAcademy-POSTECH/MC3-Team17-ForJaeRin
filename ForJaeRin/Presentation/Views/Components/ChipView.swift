//
//  ChipView.swift
//  ForJaeRin
//
//  Created by Yun Dongbeom on 2023/07/16.
//

import SwiftUI

struct ChipView<B, T: Hashable, V: View>: View {
  let mode: Mode
  @Binding var binding: B
  let items: [T]
  let viewMapping: (T) -> V

  @State private var totalHeight: CGFloat

  init(mode: Mode, binding: Binding<B>, items: [T], viewMapping: @escaping (T) -> V) {
    self.mode = mode
    _binding = binding
    self.items = items
    self.viewMapping = viewMapping
    _totalHeight = State(initialValue: (mode == .scrollable) ? .zero : .infinity)
  }

  var body: some View {
    let stack = VStack {
       GeometryReader { geometry in
         self.content(in: geometry)
       }
    }
    return Group {
      if mode == .scrollable {
        stack.frame(height: totalHeight)
      } else {
        stack.frame(maxHeight: totalHeight)
      }
    }
  }

  private func content(in geometry: GeometryProxy) -> some View {
    var width = CGFloat.zero
    var height = CGFloat.zero
    return ZStack(alignment: .topLeading) {
      ForEach(self.items, id: \.self) { item in
        self.viewMapping(item)
          .padding([.vertical], 12)
          .alignmentGuide(.leading, computeValue: { _item in
            if (abs(width - _item.width) > geometry.size.width) {
              width = 0
              height -= _item.height
            }
            let result = width
            if item == self.items.last {
              width = 0
            } else {
              width -= _item.width
            }
            return result
          })
          .alignmentGuide(.top, computeValue: { _ in
            let result = height
            if item == self.items.last {
              height = 0
            }
            return result
          })
        }
      }
      .background(viewHeightReader($totalHeight))
  }

  private func viewHeightReader(_ binding: Binding<CGFloat>) -> some View {
    return GeometryReader { geometry -> Color in
      DispatchQueue.main.async {
        binding.wrappedValue = geometry.frame(in: .local).size.height
      }
      return .clear
    }
  }

  enum Mode {
    case scrollable, vstack
  }
}
