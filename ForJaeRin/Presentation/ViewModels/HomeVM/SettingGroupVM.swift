//
//  SettingGroupVM.swift
//  ForJaeRin
//
//  Created by Yun Dongbeom on 2023/07/25.
//

import Foundation
import SwiftUI

class SettingGroupVM: ObservableObject {
    /// 각 PDF별 그룹 번호
    @Published var groupIndex: [Int] = []
    var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
    /// 현재 보고 있는 그룹 번호(-1은 안 보고 있음)
    @Published var focusGroup = -1
    /// 현재 수정 혹은 추가 중이면 true(focusGroup이 0이상)
    @Published var somethingIsEdit = false
    /// 클릭한 PDF 인덱스
    /// somethingIsEdit이 false로 변하면 tapHistory를 초기화해야한다.
    @Published var tapHistory: [Int] = [] {
        didSet {
            print(tapHistory)
        }
    }
    
//    let SIDEBAR_WIDTH: CGFloat = 205
    
    // MARK: - TempPDFView
    let CARD_GAP: CGFloat = 18
    
    func calcCardWidth(containerWidth: CGFloat) -> CGSize {
        let width = (containerWidth - CARD_GAP) / 3
        return CGSize(width: width, height: width / 4 * 3)
    }
}
