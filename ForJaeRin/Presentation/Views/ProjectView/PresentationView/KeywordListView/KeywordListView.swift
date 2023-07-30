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
    @EnvironmentObject var projectFileManager: ProjectFileManager
    @EnvironmentObject var vm: PresentationVM
    @EnvironmentObject var speechRecognizer: SpeechRecognizer

    var body: some View {
        VStack {
            Text(vm.KEYWORD_SECTION_TITLE)
                .systemFont(.body)
                .bold()
                .foregroundColor(Color.systemGray500)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, .spacing300)
            ZStack(alignment: .top) {
                Rectangle()
                    .fill(Color.clear)
                    .frame(maxWidth: .infinity, maxHeight: .spacing500)
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
                                    if let document = projectFileManager.pdfDocument {
                                        ForEach(document.PDFPages.indices, id: \.self) { index in
                                            KeywordListItem(
                                                pdfPage: document.PDFPages[index],
                                                sidebarWidth: vm.ACTIVE_SIDEBAR_WIDTH - .spacing300 * 2,
                                                keywordSizes: Array(
                                                    repeating: CGSize.zero,
                                                    count: keywordCount(index: index)
                                                ),
                                                index: index,
                                                isSelected: index == vm.currentPageIndex
                                            )
                                            .onTapGesture {
                                                vm.currentPageIndex = index
                                            }
                                            .frame(maxWidth: geometry.size.width)
                                            .id(index)
                                        }
                                        .onChange(of: vm.currentPageIndex) { newID in
                                            // MARK: scrollToID 값이 변경되면 해당 ID를 가진 뷰로 스크롤합니다.
                                            withAnimation {
                                                scrollViewProxy.scrollTo(newID, anchor: .center)
                                            }
                                        }
                                    }
                                }
                                .padding(.vertical, geometry.size.height / 2 - 100)
                            }
                            .padding(.bottom, 24)
                            .frame(alignment: .center)
                            Rectangle()
                                .fill(Color.clear)
                                .frame(maxWidth: .infinity, maxHeight: .spacing500)
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
                        maxHeight: .infinity
                    )
                }
                .padding(.horizontal, .spacing300)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    func keywordCount(index: Int) -> Int {
        var answer = 0
        for each in projectFileManager.pdfDocument!.PDFPages[index].keywords where each != "" {
            answer += 1
        }
        return answer
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
        KeywordListView()
    }
}
