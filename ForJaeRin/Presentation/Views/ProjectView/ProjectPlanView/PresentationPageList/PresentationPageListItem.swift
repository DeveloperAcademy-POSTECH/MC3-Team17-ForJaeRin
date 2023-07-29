//
//  PresentationPageListItem.swift
//  ForJaeRin
//
//  Created by Yun Dongbeom on 2023/07/14.
//

import SwiftUI

struct PresentationPageListItem: View {
    @EnvironmentObject var projectFileManager: ProjectFileManager
    @State var groupIndex: Int
    @State var pageIndex: Int
    @State var pdfGroup: PDFGroup // 뷰모델이 만들어지면 인덱스로 조회해오자.
    // @State var pdfPage: PDFPage
    // 그룹의 첫번째 인덱스 == 페이지 인덱스
    @State var pageScript = ""
    @State var keywords: Keywords = []
    @FocusState var isFocus: Bool
    let scriptPlaceHolder = "스크립트를 입력해주세요."
    
    @EnvironmentObject var myData: MyData
    
    var body: some View {
        VStack(spacing: 0) {
            if checkGroupFirstItem() {
                groupNotiView()
            }
            HStack(spacing: 0) {
                // 그룹 인디케이터
                groupIndicator()
                // 프레젠테이션(PDF) 컨테이너
                pdfContainer(pageIndex: pageIndex)
                dottedDivider()
                // 스크립트 컨테이너
                scriptContainer()
                dottedDivider()
                // 키워드 컨테이너
                keywordContainer()
            }
            .background(Color.systemWhite)
            .cornerRadius(10)
            .padding(.bottom, .spacing150)
            .frame(maxWidth: .infinity, minHeight: 200, idealHeight: 200, maxHeight: 230)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.horizontal, .spacing1000)
        .onAppear {
            // pageScript = pdfPage.script
            // keywords = pdfPage.keywords
        }
    }
    
    private func checkGroupFirstItem() -> Bool {
        if pageIndex == pdfGroup.range.start {
            return true
        } else {
            return false
        }
    }
}

extension PresentationPageListItem {
    private func groupNotiView() -> some View {
        ZStack {
            Rectangle()
                .strokeBorder(style: StrokeStyle(lineWidth: 1, dash: [7]))
                .foregroundColor(GroupColor.allCases[groupIndex].text)
                .frame(maxWidth: .infinity ,minHeight:1, maxHeight: 1)
            RoundedRectangle(cornerRadius: 50)
                .stroke(GroupColor.allCases[groupIndex].text,lineWidth:1)
                .foregroundColor(Color.systemWhite)
                .background(Color.systemWhite)
                .cornerRadius(50)
                .frame(maxWidth: 255, maxHeight: 26)
            TextField("그룹명을 작성해주세요", text: $pdfGroup.name)
                .fixedSize()
                .systemFont(.caption1)
                .foregroundColor(GroupColor.allCases[groupIndex].text)
                .multilineTextAlignment(.center)
        }
        .padding(.top, myData.isOnboardingActive && pdfGroup.range.start == 0
                 ? .spacing300
                 :  pdfGroup.range.start == 0
                 ? .spacing600
                 : 0
        )
        .padding(.bottom, .spacing300)
//        .padding(.horizontal, .spacing1000)
        .frame(maxWidth: .infinity, minHeight: 26)
    }
    
    // MARK: 그룹 인디케이터
    private func groupIndicator() -> some View {
        Rectangle()
            .frame(width: 20)
            .foregroundColor(GroupColor.allCases[groupIndex].color)
    }
    
    // MARK: 프레젠테이션(PDF) 컨테이너 - 로키가 잘 해줄꺼야
    private func pdfContainer(pageIndex: Int) -> some View {
        // let pdfUrl = Bundle.main.url(forResource: "sample", withExtension: "pdf")!
        
        return ZStack(alignment: .topLeading) {
            Text("\(pageIndex + 1)")
                .offset(x: 6, y: -24)
                .zIndex(1)
                .systemFont(.caption1)
                .foregroundColor(Color.systemGray400)
            VStack {
                Image(nsImage: myData.images[pageIndex])
                    .resizable()
                    .frame(width: 212, height: 118)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.systemGray100,lineWidth:1)
                            .foregroundColor(Color.clear)
                            .cornerRadius(10)
                    )
            }
            .padding(.leading, .spacing500)
            .padding(.trailing, .spacing500)
            .frame(maxWidth: 318)
        }
    }
    
    // MARK: 스크립트 컨테이너
    private func scriptContainer() -> some View {
        HStack {
            ZStack(alignment: .topLeading) {
                if myData.script[pageIndex].isEmpty {
                    Text(scriptPlaceHolder)
                        .systemFont(.body)
                        .foregroundColor(Color.systemGray100)
                        .zIndex(1)
                        .onTapGesture {
                            isFocus = true
                        }
                        .padding(.leading, 4)
                        .padding(.top, 12)
                }
                TextEditor(text: $myData.script[pageIndex])
                    .systemFont(.body)
                    .foregroundColor(Color.systemGray400)
                    .frame(minHeight: 182-48, maxHeight: 182-48)
            }
        }
        .frame(maxWidth: 206, maxHeight: 182)
        .padding(.leading, 8)
        .border(.blue)
//        .padding(.trailing, .spacing500)
    }
    
    // MARK: 키워드 컨테이너
    private func keywordContainer() -> some View {
        VStack(spacing: 0) {
            KeywordView(
                pageNumber: pageIndex,
                lastIndex: enteredKeywordCount(pageNumber: pageIndex))
            .border(.blue)
            .padding(.vertical, 12)
            .padding(.leading, .spacing500)
            .padding(.trailing, .spacing200 + .spacing500)
        }.border(.red)
    }
    
    private func enteredKeywordCount(pageNumber: Int) -> Int {
        var answer = 0
        for allKeyword in myData.keywords[pageNumber] where allKeyword != "" {
            answer += 1
        }
        if answer > 0 {
            answer -= 1
        }
        return answer
    }
    
    private func dottedDivider() -> some View {
        Rectangle()
            .strokeBorder(style: StrokeStyle(lineWidth: 1, dash: [3]))
            .foregroundColor(Color.systemGray100)
            .frame(minWidth:1, maxWidth: 1)
            .padding(.vertical, 24)
    }
}

struct PresentationPageListItem_Previews: PreviewProvider {
    static var previews: some View {
        let groupIndex = 0
        let pageIndex = 0
        let pdfGroup = PDFGroup(name: "그룹명", range: PDFGroupRange(start: 0, end: 3), setTime: 300)
        //        let pdfPage = PDFPage(keywords: ["test", "test2"], script: "test..." )
        PresentationPageListItem(
            groupIndex: groupIndex,
            pageIndex: pageIndex,
            pdfGroup: pdfGroup
            // pdfPage: pdfPage
        )
    }
}
