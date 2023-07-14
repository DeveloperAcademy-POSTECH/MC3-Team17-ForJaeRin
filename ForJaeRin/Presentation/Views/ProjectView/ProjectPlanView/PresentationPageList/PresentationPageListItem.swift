//
//  PresentationPageListItem.swift
//  ForJaeRin
//
//  Created by Yun Dongbeom on 2023/07/14.
//

import SwiftUI

struct PresentationPageListItem: View {
    var groupIndex: Int
    var pageIndex: Int
    var pdfGroup: PDFGroup // 뷰모델이 만들어지면 인덱스로 조회해오자.
    var pdfPage: PDFPage
    // 그룹의 첫번째 인덱스 == 페이지 인덱스
    
    var body: some View {
        HStack(spacing: 0) {
            // 그룹 인디케이터
            groupIndicator(groupColor: GroupColor.allCases[groupIndex])
            // 프레젠테이션(PDF) 컨테이너
            // 스크립트 컨테이너
            // 키워드 컨테이너
        }
    }
}

extension PresentationPageListItem {
    // MARK: 그룹 인디케이터
    private func groupIndicator(groupColor: GroupColor) -> some View {
        Rectangle()
            .frame(width: 20)
            .foregroundColor(groupColor.color)
            .border(.red)
    }
    
    // MARK: 프레젠테이션(PDF) 컨테이너
    private func pdfContainer() -> some View {
        VStack {
            Rectangle()
        }
        .background(Color.blue)
    }
    
    // MARK: 스크립트 컨테이너
    private func scriptContainer(script: String) -> some View {
        ScrollView {
            Text(script)
        }
    }
    
    // MARK: 키워드 컨테이너
    private func keywordContainer(keywords: Keywords) -> some View {
        VStack {
            List {
                ForEach(0..<keywords.count, id: \.self) { index in
                    Text(keywords[index])
                }
            }
        }
    }
    
}

struct PresentationPageListItem_Previews: PreviewProvider {
    static var previews: some View {
        var groupIndex = 0
        var pageIndex = 0
        var pdfGroup = PDFGroup(name: "그룹명", range: (start: 0, end: 3), setTime: 300)
        var pdfPage = PDFPage(keywords: ["test", "test2"], script: "test..." )
        PresentationPageListItem(
            groupIndex: groupIndex,
            pageIndex: pageIndex,
            pdfGroup: pdfGroup,
            pdfPage: pdfPage)
    }
}
