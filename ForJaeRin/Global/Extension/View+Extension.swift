//
//  View+Extension.swift
//  ForJaeRin
//
//  Created by Yun Dongbeom on 2023/07/07.
//

import Foundation
import SwiftUI

extension View {
    func systemFont(_ name: SystemFont) -> some View {
        return modifier(SystemFontModifier(font: name))
    }
    
    func border(width: CGFloat, edges: [Edge], color: Color) -> some View {
        overlay(EdgeBorder(width: width, edges: edges).foregroundColor(color))
    }
}
