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
    var isSelected = false
    
    func makeBody(configuration: Configuration) -> some View {
        HStack(alignment: .center, spacing: 8) {
            configuration.icon
                .scaledToFill()
                .systemFont(.subTitle)
                .foregroundColor(isSelected ? Color.systemPrimary : Color.systemGray300)
            configuration.title
                .systemFont(.body)
                .foregroundColor(Color.systemGray500)
                .bold(isSelected)
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct ToolbarIconOnlyLabelStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack(alignment: .center, spacing: 0) {
            configuration.icon
                .scaledToFill()
                .font(Font.system(size: 18))
        }
    }
}

struct ToolbarVerticalLabelStyle: LabelStyle {
    var isSelected = false
    
    func makeBody(configuration: Configuration) -> some View {
        VStack(alignment: .center, spacing: 5) {
            configuration.icon
                .scaledToFill()
                .systemFont(.caption2)
                .padding(.vertical, 2)
                .frame(maxWidth: 64)
                .background(isSelected
                            ? Color.systemGray100
                            : Color.clear
                )
                .cornerRadius(5)
            configuration.title
                .multilineTextAlignment(.center)
                .font(.caption)
        }
    }
}

struct LayoutContentLabelStyle: LabelStyle {
//    var isSelected: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        HStack(spacing: 8) {
            configuration.icon
                .font(.title3)
            configuration.title
                .font(.body)
                .foregroundColor(.systemBlack)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
