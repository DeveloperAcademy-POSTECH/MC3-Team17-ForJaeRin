//
//  PresentationView.swift
//  ForJaeRin
//
//  Created by Yun Dongbeom on 2023/07/11.
//

import SwiftUI

/**
 앱의 메인이 되는 페이지입니다.
 - 키워드 편집
 - PDF와 스크롤 연동되는 키워드
 - PPT 진행상황 확인을 위한 프로그레스바
 - 음성 인식 피드백
 - 연습 끝내기 시 키워드 발화 여부 / 소요시간 / 다시 듣기 등 피드백(후순위)
 - 다시 연습하기
 */
// MARK: 연습모드 페이지 뷰
struct PresentationView: View {
    @Binding var isContentsActive: Bool
    @State var isSidebarActive = true
    @State var isDragging = false
    @State var position = CGSize.zero
    
    var body: some View {
            VStack(spacing: 0) {
                toolbarView()
                HSplitView {
                    splitLeftView()
                    splitRightView()
            }
        }
    }
}

extension PresentationView {
    // MARK: PDF 및 연습 오디오 컨트롤러
    func splitLeftView() -> some View {
        return ZStack {
            PresentationTimerView()
                .zIndex(10)
            VStack(spacing: 0) {
                PresentationPDFView()
                AudioControllerView()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .border(.red, width: 2)
    }
    
    // MARK: 우측 사이드 바
    func splitRightView() -> some View {
        let ACTIVE_SIDEBAR_WIDTH: CGFloat = 272
        
        return VStack(spacing: 0) {
            KeywordListView()
            VoiceVisualizationView()
        }
        .frame(
        minWidth: isSidebarActive ? ACTIVE_SIDEBAR_WIDTH : 0,
        maxWidth: isSidebarActive ? ACTIVE_SIDEBAR_WIDTH : 0,
        maxHeight: .infinity, alignment: .topLeading)
    }
    
    // MARK: Presentation 내 레이아웃 조정 및 기능을 위한 뷰
    func toolbarView() -> some View {
        HStack(spacing: 0) {
            Button {
                isContentsActive.toggle()
            } label: {
                Label("leftSidebar", systemImage: "sidebar.leading")
                    .labelStyle(.iconOnly)
            }
            Spacer()
            Button {
                isSidebarActive.toggle()
            } label: {
                Label("rightSidebar", systemImage: "sidebar.trailing")
                    .labelStyle(.iconOnly)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: 32, alignment: .center)
        .padding(.vertical ,4)
        .padding(.horizontal, 8)
        .border(width: 1, edges: [.bottom], color: .init(nsColor: .alternateSelectedControlTextColor))
    }
}

struct PresentationView_Previews: PreviewProvider {
    static var previews: some View {
        @State var isContentsActive = true
        PresentationView(isContentsActive: $isContentsActive)
    }
}
