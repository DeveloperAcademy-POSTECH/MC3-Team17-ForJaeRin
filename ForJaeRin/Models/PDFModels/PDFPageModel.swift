//
//  PDFPageModel.swift
//  ForJaeRin
//
//  Created by Yun Dongbeom on 2023/07/14.
//

import Foundation

// MARK: PDF 페이지 별 정보를 들고 있는 구조체
struct PDFPage: Identifiable, Equatable {
    var id = UUID()
    var keywords: Keywords
    var script: String
}
