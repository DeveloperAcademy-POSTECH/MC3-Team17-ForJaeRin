//
//  CustomLabel.swift
//  ForJaeRin
//
//  Created by Yun Dongbeom on 2023/07/11.
//

import Foundation
import SwiftUI

// MARK: 최상위 리스트 뷰의 사용될 라벨 스타일
struct LeftSidebarLabelStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack(alignment: .center, spacing: 0) {
            configuration.icon
                .scaledToFill()
                .padding(.bottom, 8)
                .font(.title2)
            configuration.title
                .multilineTextAlignment(.center)
                .font(.caption)
        }
        .frame(maxWidth: .infinity)
    }
}