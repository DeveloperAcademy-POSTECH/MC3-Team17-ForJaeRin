//
//  PDFDocument.swift
//  ForJaeRin
//
//  Created by Yun Dongbeom on 2023/07/14.
//

import Foundation

// MARK: PDF 정보를 들고 있을 클래스
final class PDFDocumentManager: ObservableObject {
    let url: URL
    var PDFPages: [PDFPage]
    /// PDF Group은 최대 7개
    var PDFGroups: [PDFGroup]
    
    init(url: URL, PDFPages: [PDFPage], PDFGroups: [PDFGroup]) {
        self.url = url
        self.PDFPages = PDFPages
        self.PDFGroups = PDFGroups
    }
}
