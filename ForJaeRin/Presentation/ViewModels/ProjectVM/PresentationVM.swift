//
//  PresentationVM.swift
//  ForJaeRin
//
//  Created by Yun Dongbeom on 2023/07/23.
//

import Foundation

class PresentationVM: ObservableObject {
    // MARK: 현재 진행상황과 인터랙션 하기 위한 인덱스
    @Published var currentPageIndex = 0 {
        didSet {
            print("currentPageIndex Update", currentPageIndex)
        }
    }
    // MARK: 연습기록을 저장하기 위한 구조체
    @Published var practice = Practice(
        saidKeywords: [],
        speechRanges: [],
        progressTime: 0,
        audioPath: AppFileManager.shared.directoryPath)
    @Published var isSidebarActive = true
    
    let ACTIVE_SIDEBAR_WIDTH: CGFloat = 302
    let TOOLBAR_LEFT_BUTTON_INFO = (
        icon: "chevron.left",
        label: "뒤로가기"
    )
    let TOOLBAR_RIGHT_BUTTON_INFO = (
        icon: "sidebar.trailing",
        label: "사이드 바 열기"
    )
    let TOOLBAR_END_PRACTICE_INFO = (
        icon: "xmark",
        label: "연습 끝내기"
    )
}
