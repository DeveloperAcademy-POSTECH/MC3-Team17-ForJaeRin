//
//  View+Extension.swift
//  ForJaeRin
//
//  Created by Yun Dongbeom on 2023/07/07.
//

import Foundation
import SwiftUI

extension View {
    func customFontModifier(name: String, size: Double) -> some View {
        return modifier(CustomFontModifier(name: name, size: size))
    }
}
