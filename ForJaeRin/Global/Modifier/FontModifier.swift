//
//  SampleModifier.swift
//  ForJaeRin
//
//  Created by Yun Dongbeom on 2023/07/07.
//

import Foundation
import SwiftUI

func customFont(size: CGFloat) -> Font {
    if let font = NSFont(name: "Pretendard-Regular", size: size) {
        return Font(font)
    } else {
        // Return a fallback font or handle the error
        return Font.system(size: size)
    }
}

// MARK: 샘플코드입니다.

struct CustomFontModifier: ViewModifier {
    @Environment(\.sizeCategory) var sizeCategory
    var name: String = "Font_Name"
    var size: Double

    func body(content: Content) -> some View {
        return content.font(.custom(name, size: size))
    }
}
