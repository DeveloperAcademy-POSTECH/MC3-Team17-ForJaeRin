//
//  PDFDocument.swift
//  ForJaeRin
//
//  Created by Yun Dongbeom on 2023/07/14
//

import Foundation

// MARK: PDF 정보를 들고 있을 클래스
final class PDFDocumentManager: ObservableObject {
    let url: URL
    @Published
    var PDFPages: [PDFPage]
    @Published
    /// PDF Group은 최대 7개
    var PDFGroups: [PDFGroup]
    
    init(url: URL, PDFPages: [PDFPage], PDFGroups: [PDFGroup]) {
        self.url = url
        self.PDFPages = PDFPages
        self.PDFGroups = PDFGroups
    }
    
    // MARK: 페이지 인덱스로 PDF Group을 조회해서 현재 페이지가 속한 그룹 인덱스 반환
    func findGroupIndex(pageIndex: Int) -> Int {
        var result: Int = 0
        
        for (index, element) in PDFGroups.enumerated() {
            
            if pageIndex >= element.range.start &&
                pageIndex <= element.range.end {
                result = index
            }
        }
        
        return result
    }
    
    // MARK: 전체 중 현재 그룹이 차지하는 점유율
    func getGroupVolumn(index: Int) -> CGFloat {
        let whole = PDFPages.count // 전체 페이지 수
        let part = (PDFGroups[index].range.end - PDFGroups[index].range.start) + 1
        
        return CGFloat((part * 100) / whole)
    }
}

struct CodablePDFDocumentManager: Codable {
    var PDFPages: [PDFPage]
    var PDFGroups: [PDFGroup]
}
