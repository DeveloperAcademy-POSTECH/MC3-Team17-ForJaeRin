//
//  ButtonModifier.swift
//  ForJaeRin
//
//  Created by Yun Dongbeom on 2023/07/12.
//

import Foundation
import SwiftUI

// MARK: 앱 내에서 공용으로 사용될 버튼 스타일
struct AppButtonStyle: ButtonStyle {
    var labelColor = Color.white
    var backgroundColor = Color.systemPrimary
    var width: CGFloat = 200
    var height: CGFloat = 55
    
    func makeBody(configuration: Configuration) -> some View {
      configuration.label
        .padding(.horizontal, 32)
        .padding(.vertical, 12)
        .frame(maxWidth: width, minHeight: height)
        .foregroundColor(labelColor)
        .background(backgroundColor)
        .cornerRadius(10)
        
    }
}
