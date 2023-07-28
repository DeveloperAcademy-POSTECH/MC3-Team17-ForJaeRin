//
//  HomeVM.swift
//  ForJaeRin
//
//  Created by Yun Dongbeom on 2023/07/11.
//

import Foundation
import SwiftUI

class HomeVM: ObservableObject {
    let LOGO_NAME = "logo_main"
    let LOGO_SIZE = CGSize(width: 169, height: 35)
    let SYMBOL_INNER_SIZE: CGFloat = 54
    let SYMBOL_OUTER_SIZE: CGFloat = 84
    let TOP_TEXT_INFO: SectionHeaderInfo = (
        title: "새 프로젝트",
        subTitle: "새 프로젝트를 추가해서 제작해보세요"
    )
    let BOTTOM_TEXT_INFO: SectionHeaderInfo = (
        title: "이전 프로젝트",
        subTitle: nil
    )
    let NEW_PROJECT_BUTTON_INFO = (
        icon: "folder.badge.plus",
        label: "프로젝트 생성하기"
    )
    let EMPTY_TEXT_INFO = (
        icon: "ellipsis.bubble",
        label: "이전 프로젝트가 없어요!"
    )
    
    let CARD_LIST_COLUMNS = [
        GridItem(.flexible(minimum: 160), spacing: 32),
        GridItem(.flexible(minimum: 160), spacing: 32),
        GridItem(.flexible(minimum: 160), spacing: 32),
        GridItem(.flexible(minimum: 160), spacing: 32),
        GridItem(.flexible(minimum: 160), spacing: 32)
    ]
    
    let HORIZONTAL_PADDING: CGFloat = .spacing1000
    
    // MARK: New Project Open Sheet Toggle State
    @Published var isSheetActive = false
    // MARK: 프로젝트 파일 리스트
    @Published var files: [KkoProject] = []
    // MARK: Sheet Height 조정을 상태
    @Published var sheetSize = CGSize()
    
    @Published var isNewProjectSettingDone = false
    
    func getSheetWidth(height: CGFloat) -> CGFloat {
        max(height * 110 / 100, 868)
    }
    
    func calcCardWidth(containerWidth: CGFloat) -> CGFloat {
        (containerWidth - 4 * 28) / 5
    }
    
    func requestCardListColumns(containerWidth: CGFloat) -> [GridItem] {
        let cardWidth = calcCardWidth(containerWidth: containerWidth)
        
        return [
            GridItem(.flexible(minimum: cardWidth), spacing: 28),
            GridItem(.flexible(minimum: cardWidth), spacing: 28),
            GridItem(.flexible(minimum: cardWidth), spacing: 28),
            GridItem(.flexible(minimum: cardWidth), spacing: 28),
            GridItem(.flexible(minimum: cardWidth), spacing: 28)
        ]
    }
}
