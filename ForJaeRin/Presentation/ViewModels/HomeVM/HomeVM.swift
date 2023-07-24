//
//  HomeVM.swift
//  ForJaeRin
//
//  Created by Yun Dongbeom on 2023/07/11.
//

import Foundation
import SwiftUI

class HomeVM: ObservableObject {
    let LOGO_NAME = ""
    let LOGO_SIZE = CGSize(width: 110, height: 40)
    let SYMBOL_INNER_SIZE: CGFloat = 54
    let SYMBOL_OUTER_SIZE: CGFloat = 85
    let TOP_TEXT_INFO: SectionHeaderInfo = (
        title: "새 프로젝트",
        subTitle: "새 프로젝트를 추가해서 제작해보세요"
    )
    let BOTTOM_TEXT_INFO: SectionHeaderInfo = (
        title: "이전 프로젝트",
        subTitle: nil
    )
    let NEW_PROJECT_BUTTON_INFO = (
        icon: "folder.fill.badge.plus",
        label: "프로젝트 생성하기"
    )
    let EMPTY_TEXT_INFO = (
        icon: "exclamationmark.bubble.fill",
        label: "이전 프로젝트가 없어요"
    )
    
    let CARD_LIST_COLUMNS = [
        GridItem(.flexible(minimum: 160), spacing: 32),
        GridItem(.flexible(minimum: 160), spacing: 32),
        GridItem(.flexible(minimum: 160), spacing: 32),
        GridItem(.flexible(minimum: 160), spacing: 32),
        GridItem(.flexible(minimum: 160), spacing: 32)
    ]
    
    let HORIZONTAL_PADDING: CGFloat = 92
    
    // MARK: 프로젝트 파일 리스트
    @Published var files: [KkoProject] = []
    
    func calcCardWidth(containerWidth: CGFloat) -> CGFloat {
        (containerWidth - 4 * 32) / 5
    }
    
    func requestCardListColumns(containerWidth: CGFloat) -> [GridItem] {
        let cardWidth = calcCardWidth(containerWidth: containerWidth)
        
        return [
            GridItem(.flexible(minimum: cardWidth), spacing: 32),
            GridItem(.flexible(minimum: cardWidth), spacing: 32),
            GridItem(.flexible(minimum: cardWidth), spacing: 32),
            GridItem(.flexible(minimum: cardWidth), spacing: 32),
            GridItem(.flexible(minimum: cardWidth), spacing: 32)
        ]
    }
}
