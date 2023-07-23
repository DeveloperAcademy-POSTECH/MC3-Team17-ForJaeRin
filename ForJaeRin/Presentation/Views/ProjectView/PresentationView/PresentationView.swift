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
    // MARK: NavigationStack에서 pop하기 위한 function
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var voiceManager: VoiceManager
    @ObservedObject var projectFileManager: ProjectFileManager
    @StateObject var vm = PresentationVM()
    @State var isSidebarActive = true
    @State var isDragging = false
    @State var position = CGSize.zero
    
    var body: some View {
            VStack(spacing: 0) {
                toolbarView()
                HStack(spacing: 0) {
                    splitLeftView()
                    splitRightView()
            }
        }
        .onAppear {
            if let practice = projectFileManager.practices {
                print(practice.count)
            } else {return}
        }
        .environmentObject(vm)
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
            }
            .background(Color.detailLayoutBackground)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }
    
    // MARK: 우측 사이드 바
    func splitRightView() -> some View {
        let ACTIVE_SIDEBAR_WIDTH: CGFloat = 302
        
        return VStack(spacing: 0) {
            PresentationProgressView(sidebarWidth: ACTIVE_SIDEBAR_WIDTH)
                .padding(.vertical, 35)
            KeywordListView(sidebarWidth: ACTIVE_SIDEBAR_WIDTH)
            VoiceVisualizationView()
        }
        .frame(
        minWidth: isSidebarActive ? ACTIVE_SIDEBAR_WIDTH : 0,
        maxWidth: isSidebarActive ? ACTIVE_SIDEBAR_WIDTH : 0,
        maxHeight: .infinity, alignment: .topLeading)
        .border(width: 1, edges: [.leading], color: Color.systemGray100)
        .background(Color.systemWhite)
    }
    
    // MARK: Presentation 내 레이아웃 조정 및 기능을 위한 뷰
    // MARK: toolbarView
    private func toolbarView() -> some View {
        HStack(spacing: 0) {
            // 고정 영역
            toolbarStaticItemView()
            Spacer()
            // 탭에 따라 변경되는 영역
            toolbarDynamicItemView()
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: 49,
            alignment: .center
        )
        .padding(.top, 12)
        .padding(.bottom, 8)
        .padding(.horizontal, 28)
        .padding(.trailing, 4)
        .background(Color.systemWhite)
        .border(width: 1, edges: [.bottom], color: Color.systemGray100)
    }
    
    private func toolbarStaticItemView() -> some View {
        HStack(spacing: 32) {
            // goToHome
            Button {
                    dismiss()
            } label: {
                Label("뒤로", systemImage: "chevron.left")
                    .labelStyle(ToolbarIconOnlyLabelStyle())
                    .frame(maxWidth: 28, maxHeight: 28)
                    .foregroundColor(Color.systemGray400)
            }
            .buttonStyle(.plain)
        }
    }

    private func toolbarDynamicItemView() -> some View {
        HStack(spacing: 56) {
            Button {
                withAnimation {
                    isSidebarActive.toggle()
                }
            } label: {
                Label("leftSidebar", systemImage: "sidebar.leading")
                .labelStyle(ToolbarIconOnlyLabelStyle())
                .frame(maxWidth: 64, maxHeight: 64)
                .foregroundColor(Color.systemGray400)
            }
            .buttonStyle(.plain)
            NavigationLink {
                PresentationView(projectFileManager: projectFileManager)
            } label: {
                Text("연습끝내기")
                    .systemFont(.body)
            }
            .buttonStyle(AppButtonStyle(
                backgroundColor: Color.systemPoint,
                width: 122,
                height: 46)
            )
        }
    }
}

struct PresentationView_Previews: PreviewProvider {
    static var previews: some View {
        PresentationView(projectFileManager: ProjectFileManager())
    }
}
