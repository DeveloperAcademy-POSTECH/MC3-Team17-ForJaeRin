//
//  ViewModifier.swift
//  ForJaeRin
//
//  Created by 이용준의 Macbook on 2023/07/29.
//

import Foundation
import SwiftUI

struct SizeCalculator: ViewModifier {
    @Binding var size: CGSize
    func body(content: Content) -> some View {
        content
            .background(
                GeometryReader { proxy in
                    Color.clear
                        .onAppear {
                            size = proxy.size
                        }
                }
            )
    }
}
