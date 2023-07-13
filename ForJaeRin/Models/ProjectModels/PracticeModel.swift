//
//  PracticeModel.swift
//  ForJaeRin
//
//  Created by Yun Dongbeom on 2023/07/14.
//

import Foundation

typealias speechRange = (start: Int, end: Int, group: Int)

// MARK: 프로젝트 연습정보를 담기위한 구조체
struct Practice: Identifiable {
    var id = UUID()
    // MARK: 그룹별로 키워드를 보여준다고 했는데, 그럼 최대 그룹 * 페이지 만큼 들어오는 걸까요?
    var saidKeywords: [Keywords]
    var speechRanges: [speechRange]
    var progressTime: Int
    var audioPath: URL
}
