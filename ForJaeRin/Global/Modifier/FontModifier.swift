//
//  SampleModifier.swift
//  ForJaeRin
//
//  Created by Yun Dongbeom on 2023/07/07.
//

import Foundation
import SwiftUI

struct SystemFontModifier: ViewModifier {
    @Environment(\.sizeCategory) var sizeCategory
    var font: SystemFont = .body

    func body(content: Content) -> some View {
        content.font(font.value)
    }
}

enum SystemFont {
    case headline
    case subTitle
    case body
    case caption1
    case caption2
    
    var value: Font {
        switch self {
        case .headline:
            return Font.systemHeadline
        case .subTitle:
            return Font.systemSubtitle
        case .body:
            return Font.systemBody
        case .caption1:
            return Font.systemCaption1
        case .caption2:
            return Font.systemCaption1
        }
    }
}
