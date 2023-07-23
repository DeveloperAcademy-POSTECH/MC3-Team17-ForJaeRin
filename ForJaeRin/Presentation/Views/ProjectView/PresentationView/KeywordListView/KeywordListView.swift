//
//  KeywordListView.swift
//  ForJaeRin
//
//  Created by Yun Dongbeom on 2023/07/12.
//

import SwiftUI

/**
 사전 설정 키워드 보여주기
 */
// MARK: 사전 설정한 PDF 페이지 별 키워드를 출력하는 뷰
struct KeywordListView: View {
    @State var isSheetActive = false
    @State var pdfPages: [PDFPage] = [
        PDFPage(keywords: ["HIG", "타이포그래피", "가독성", "자동", "사이즈", "일관된", "개발자"], script: "안중요하죠?"),
        PDFPage(keywords: ["차이", "디테일", "디자이너", "개발자", "소통"], script: "안중요하죠?"),
        PDFPage(keywords: [ "사이즈", "일관된", "개발자"], script: "안중요하죠?")
    ]
    @EnvironmentObject var vm: PresentationVM
//    @State var currentPageCount: CGFloat = 12
    @State var wholePageCount: CGFloat = 32
    
    var sidebarWidth: CGFloat
    
    var body: some View {
        VStack {
            Text("키워드")
                .systemFont(.body)
                .bold()
                .foregroundColor(Color.systemGray500)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 32)
            ZStack(alignment: .top) {
                Rectangle()
                    .fill(Color.clear)
                    .frame(maxWidth: .infinity, maxHeight: 24)
                    .background(LinearGradient(
                        stops: [
                        Gradient.Stop(color: .white, location: 0.00),
                        Gradient.Stop(color: .white.opacity(0), location: 1.00)
                        ],
                        startPoint: UnitPoint(x: 0.5, y: 0),
                        endPoint: UnitPoint(x: 0.5, y: 1)
                        ))
                    .zIndex(10)
                VStack(spacing: 24) {
                    GeometryReader { geometry in
                        ZStack(alignment: .bottom) {
                            ScrollView(showsIndicators: false) {
                                ScrollViewReader { scrollViewProxy in
                                    ForEach(pdfPages.indices, id: \.self) { index in
                                        KeywordListItem(
                                            pdfPage: pdfPages[index],
                                            sidebarWidth: sidebarWidth - 32,
                                            isSelected: index == vm.currentPageIndex
                                        )
                                        .frame(maxWidth: geometry.size.width)
                                        .id(index)
                                    }
                                    .padding(.vertical, geometry.size.height / 2 - 100)
                                    .onChange(of: vm.currentPageIndex) { newID in
                                        // scrollToID 값이 변경되면 해당 ID를 가진 뷰로 스크롤합니다.
                                        withAnimation {
                                            scrollViewProxy.scrollTo(newID, anchor: .center)
                                        }
                                    }
                                }
                            }
                            .padding(.bottom, 24)
                            .frame(alignment: .center)
                            Rectangle()
                                .fill(Color.clear)
                                .frame(maxWidth: .infinity, maxHeight: 24)
                                .background(LinearGradient(
                                    stops: [
                                        Gradient.Stop(color: .white.opacity(0), location: 0.00),
                                        Gradient.Stop(color: .white, location: 1.00)
                                    ],
                                    startPoint: UnitPoint(x: 0.5, y: 0),
                                    endPoint: UnitPoint(x: 0.5, y: 1)))
                                .offset(y: -24)
                        }
                    }
                    .frame(
                        maxWidth: .infinity,
                        maxHeight: .infinity,
                        alignment: .center
                    )
                }
                .padding(.horizontal, 16)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .sheet(isPresented: $isSheetActive) {
            editKeywordListView()
                .frame(minWidth: 650, minHeight: 320)
        }
    }
}

extension KeywordListView {
    func editKeywordListView () -> some View {
        VStack {
            Text("Edit!")
        }
    }
}

struct KeywordListView_Previews: PreviewProvider {
    static var previews: some View {
        KeywordListView(sidebarWidth: 302)
    }
}
