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
    @EnvironmentObject var projectDocumentVM: ProjectDocumentVM
    @StateObject var vm = PresentationVM()
    
    var body: some View {
            VStack(spacing: 0) {
                toolbarView()
                HStack(spacing: 0) {
                    splitLeftView()
                    splitRightView()
            }
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
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }
    
    // MARK: 우측 사이드 바
    func splitRightView() -> some View {
        VStack(spacing: 0) {
            PresentationProgressView()
                .padding(.vertical, 35)
            KeywordListView()
            VoiceVisualizationView()
        }
        .frame(
            minWidth: vm.isSidebarActive ? vm.ACTIVE_SIDEBAR_WIDTH : 0,
            maxWidth: vm.isSidebarActive ? vm.ACTIVE_SIDEBAR_WIDTH : 0,
        maxHeight: .infinity, alignment: .topLeading)
        .border(width: 1, edges: [.leading], color: Color.systemGray100)
        .background(Color.systemWhite)
    }
    
    // MARK: Presentation 내 레이아웃 조정 및 기능을 위한 뷰
    private func toolbarView() -> some View {
        HStack(spacing: 0) {
            toolbarStaticItemView()
            Spacer()
            toolbarDynamicItemView()
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: 49,
            alignment: .center
        )
        .padding(.top, 12)
        .padding(.bottom, 8)
        .padding(.leading, 8)
        .padding(.trailing, 32)
        .background(Color.systemWhite)
        .border(width: 1, edges: [.bottom], color: Color.systemGray100)
    }
    
    private func toolbarStaticItemView() -> some View {
        HStack(spacing: 32) {
            // goToHome
            Button {
                dismiss()
            } label: {
                Label(vm.TOOLBAR_LEFT_BUTTON_INFO.label, systemImage: vm.TOOLBAR_LEFT_BUTTON_INFO.icon)
                    .labelStyle(ToolbarIconOnlyLabelStyle())
                    .frame(maxWidth: 64, maxHeight: 64)
                    .foregroundColor(Color.systemGray400)
            }
            .buttonStyle(.plain)
        }
    }

    private func toolbarDynamicItemView() -> some View {
        HStack(spacing: 56) {
            // MARK: 사이드 바를 토글시키기 위한 버튼
            Button {
                withAnimation {
                    vm.isSidebarActive.toggle()
                }
            } label: {
                Label(vm.TOOLBAR_RIGHT_BUTTON_INFO.label, systemImage: vm.TOOLBAR_RIGHT_BUTTON_INFO.icon)
                .labelStyle(ToolbarIconOnlyLabelStyle())
                .frame(maxWidth: 64, maxHeight: 64)
                .foregroundColor(Color.systemGray400)
            }
            .buttonStyle(.plain)
            // MARK: 연습을 종료하고 연습 기록보는 페이지로 이동시키기 위한 버튼
            Button {
                // MARK: 로직 작성 필요
                projectDocumentVM.currentTab = .record
                dismiss()
                
            } label: {
                Text(vm.TOOLBAR_END_PRACTICE_INFO.label)
                    .systemFont(.body)
            }
            .buttonStyle(AppButtonStyle(
                backgroundColor: Color.systemPoint,
                width: 122,
                height: 46)
            )
//            NavigationLink {
//                PresentationView(projectFileManager: projectFileManager)
//
//            } label: {
//                Text(vm.TOOLBAR_END_PRACTICE_INFO.label)
//                    .systemFont(.body)
//            }
//            .buttonStyle(AppButtonStyle(
//                backgroundColor: Color.systemPoint,
//                width: 122,
//                height: 46)
//            )
        }
    }
}

struct PresentationView_Previews: PreviewProvider {
    static var previews: some View {
        PresentationView()
    }
}
