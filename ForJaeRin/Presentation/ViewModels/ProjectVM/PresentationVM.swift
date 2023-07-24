//
//  PresentationVM.swift
//  ForJaeRin
//
//  Created by Yun Dongbeom on 2023/07/23.
//

import Foundation

class PresentationVM: ObservableObject {
    // MARK: 현재 진행상황과 인터랙션 하기 위한 인덱스
    @Published var currentPageIndex = 1 {
        didSet {
            print("currentPageIndex Update", currentPageIndex)
        }
    }
    // MARK: 연습기록을 저장하기 위한 구조체
    // 2. 초기화
    @Published var practice = Practice(
        /// PresentationView가 Appear될때 빈 배열들로 초기화 됨
        /// PresentationTimerView의 재생 버튼을 누르면 STT가 시작되며
        /// currentPageIndex에 속해 있는 것들 중 언급한 단어가 있으면 saidKeywords에 추가됨
        /// 일시정지 버튼을 누르면 STT가 정지됨
        /// 연습 끝내기 버튼을 누르면 STT가 정지됨
        saidKeywords: [],
        /// 재생 버튼을 누르면 currentPageIndex의 group과 0:00를 저장한다.
        /// PresentationPDFView에서 currentPageIndex가 변경되면 projectFilmManager를 통해 group index를 알고
        /// group index가 change된다면 voiceManager.timer를 통해 시간과 변경된 groupindex를 함께 저장한다.
        speechRanges: [],
        /// PresentationView에서 연습 끝내기 버튼이 눌리면 총 발표 시간이 추가된다.
        progressTime: 0,
        audioPath: AppFileManager.shared.directoryPath)
}
