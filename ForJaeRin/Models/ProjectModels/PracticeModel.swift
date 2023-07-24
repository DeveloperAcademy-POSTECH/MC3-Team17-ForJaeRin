//
//  PracticeModel.swift
//  ForJaeRin
//
//  Created by Yun Dongbeom on 2023/07/14.
//

import Foundation

struct SpeechRange {
    var start: Int
    var end: Int
    var group: Int
}

// MARK: 프로젝트 연습정보를 담기위한 구조체
struct Practice: Identifiable {
    var id = UUID()
    // MARK: 그룹별로 키워드를 보여준다고 했는데, 그럼 최대 그룹 * 페이지 만큼 들어오는 걸까요?
    var saidKeywords: [Keywords]
    var speechRanges: [SpeechRange]
    var progressTime: Int
    var audioPath: URL
}

let practice1 = Practice(
    saidKeywords: [["말한 키워드1", "말한 키워드2", "말한 키워드3"], ["말한 키워드1", "말한 키워드2"], [], [], [], [], []],
    speechRanges: [SpeechRange(start: 0, end: 60, group: 0), SpeechRange(start: 61, end: 120, group: 1)],
    progressTime: 300,
    audioPath: URL(string: "ff")!)
