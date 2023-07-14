//
//  PDFGroupModel.swift
//  ForJaeRin
//
//  Created by Yun Dongbeom on 2023/07/14.
//

import Foundation

// MARK: PDF Group 별 정보를 담을 구조체
struct PDFGroup: Identifiable {
    let id = UUID()
    var name: String
    /// 그룹이 시작하는 페이지 인덱스와 끝나는 인덱스 저장
    var range: (start: Int, end: Int)
    /// 초단위로 저장 - 시간 계산 필요
    var setTime: Int
}
