//
//  PracticeModel.swift
//  ForJaeRin
//
//  Created by Yun Dongbeom on 2023/07/14.
//

import Foundation

// MARK: Tuple -> Struct로 변경이 필요할 것 같지만 우선 남겨둘게요.
typealias SpeechRange = (start: Int, end: Int, group: Int)

// MARK: 프로젝트 연습정보를 담기위한 구조체
struct Practice: Identifiable {
    var id = UUID()
    // MARK: 그룹별로 키워드를 보여준다고 했는데, 그럼 최대 그룹 * 페이지 만큼 들어오는 걸까요?
    var saidKeywords: [Keywords]
    var speechRanges: [SpeechRange]
    var progressTime: Int
    var audioPath: URL
}
