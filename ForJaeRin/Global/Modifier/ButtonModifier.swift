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
    var backgroundColor = Color.primary
    var width: CGFloat = 160
    
    func makeBody(configuration: Configuration) -> some View {
      configuration.label
        .padding(.horizontal, 20)
        .padding(.vertical, 8)
        .frame(width: width, height: 40)
        .foregroundColor(labelColor)
        .background(backgroundColor)
        .cornerRadius(8)
        
    }
}
