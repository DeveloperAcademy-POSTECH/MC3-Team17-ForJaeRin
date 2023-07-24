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
    
    // MARK: PresentationContainer
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
    
    // MARK: PresentationProgressView
    let PROGRESS_SECTION_TITLE = "PPT 진행상황"
    
    func calcProgress(wholeCount: Int) -> CGFloat {
        CGFloat(currentPageIndex * 100 / wholeCount) * (ACTIVE_SIDEBAR_WIDTH - 64) / 100
    }
    
    // MARK: KeywordListView
    let KEYWORD_SECTION_TITLE = "키워드"
    
    // MARK: VoiceVisualization
    @Published var voiceScaleSize: CGFloat = 0
    @Published var isScaled = true
    let VOICE_SCALE_SIZE: (min:CGFloat, max:CGFloat) = (
        min: 48,
        max: 96
    )
    let VOICE_VISUALIZATION_ICON_INFO = (
        icon: "mic.fill",
        label: "내 음성 크기"
    )
    
    // MARK: 음성 녹음 시 노티피케이션 사이즈 보정을 위한 함수
    func normalizeSoundLevel(level: Float) {
        let level = max(0.2, CGFloat(level) + 50) / 2 // // between 0.2 and 25
        // scaled to max at 96 (our height of our bar)
        voiceScaleSize = CGFloat(level * (VOICE_SCALE_SIZE.max / 10))
    }
}
