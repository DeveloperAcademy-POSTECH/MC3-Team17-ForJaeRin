//
//  PresentationView.swift
//  ForJaeRin
//
//  Created by Yun Dongbeom on 2023/07/11.
//

import SwiftUI
import PDFKit

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
    @EnvironmentObject var projectFileManager: ProjectFileManager
    @EnvironmentObject var projectDocumentVM: ProjectDocumentVM
    @StateObject var vm = PresentationVM()
    @StateObject var speechRecognizer = SpeechRecognizer()
    @EnvironmentObject var myData: MyData
    @State var isShowTime = false {
        didSet {
            vm.isSidebarActive.toggle()
        }
    }
    @State var isAniActive = false
    @State var aniOffset: CGFloat = 0
    
    var body: some View {
        ZStack {
            Button {
                withAnimation {
                    isShowTime.toggle()
                }
            } label: {
                Text("..")
                    .foregroundColor(Color.clear)
            }
            .keyboardShortcut(.return, modifiers: [])
            VStack(spacing: 0) {
                if !isShowTime {
                    toolbarView()
                        .transition(.move(edge: .top))
                }
                HStack(spacing: 0) {
                    splitLeftView()
                    splitRightView()
                }
            }
            if vm.isPresentationOnboardingActive {
                PresentationOnboardingView(vm: vm)
            }
        }
        .onAppear {
            // MARK: - 온보딩 Active
//            vm.isPresentationOnboardingActive = true
        }
        .onChange(of: speechRecognizer.arr_transcript, perform: { _ in
            keywordCheck((projectFileManager.pdfDocument?.PDFPages[vm.currentPageIndex].keywords)!)
            print(speechRecognizer.arr_transcript)
        })
        .onChange(of: vm.currentPageIndex, perform: { _ in
            resetGroup()
        })
        .onChange(of: vm.currentPageGroup, perform: { newValue in
            vm.practice.speechRanges.append(SpeechRange(start: Int(voiceManager.countSec), group: newValue))
        })
        .onAppear {
            // saidKeywords에 pdf 페이지 수만큼 [] append
            for _ in 0..<(projectFileManager.pdfDocument?.PDFPages.count ?? 0) {
                vm.practice.saidKeywords.append([])
            }
        }
        .environmentObject(vm)
        .environmentObject(speechRecognizer)
    }
}

extension PresentationView {
    // MARK: PDF 및 연습 오디오 컨트롤러
    func splitLeftView() -> some View {
        return ZStack {
            if !isShowTime {
                PresentationTimerView()
                    .zIndex(10)
            }
            VStack(spacing: 0) {
                PresentationPDFView(
                    document: PDFDocument(url: projectFileManager.pdfDocument!.url)!
                )
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }
    
    // MARK: 우측 사이드 바
    func splitRightView() -> some View {
        VStack(spacing: 0) {
            PresentationProgressView()
                .padding(.vertical, .spacing600)
            KeywordListView()
            VoiceVisualizationView()
                .padding(.vertical, .spacing600)
        }
        .frame(
            minWidth: vm.isSidebarActive ? vm.ACTIVE_SIDEBAR_WIDTH : 0,
            maxWidth: vm.isSidebarActive ? vm.ACTIVE_SIDEBAR_WIDTH : 0,
            maxHeight: .infinity, alignment: .topLeading
        )
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
                speechRecognizer.stopTranscribing()
                vm.practice.progressTime = Int(voiceManager.countSec)
                projectDocumentVM.currentTab = .record
                
                if let check = VoiceManager.shared.currentPath {
                    vm.practice.audioPath = VoiceManager.shared.currentPath!
                    if vm.practice.progressTime != 0 {
                        projectFileManager.practices?.append(vm.practice)
                    }
                    projectFileManager.exportFile()
                }
                // 연습 끝내기 버튼
                // 녹음 중지
                voiceManager.stopRecording(index: 0)
                myData.isHistoryDetailActive = true
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
    
    func keywordCheck(_ keywordList: [String]) {
        var arr_keyword: [String.SubSequence] = []
        for keyword in keywordList {
            var checking = true
            arr_keyword = keyword.split(separator: " ")
            if arr_keyword.isEmpty
                || speechRecognizer.arr_transcript.count < arr_keyword.count {
                checking = false
                continue
            }
            for temp in 1...arr_keyword.count {
                let arr_keyword_index = arr_keyword.count - temp
                let arr_transcript_index = speechRecognizer.arr_transcript.count - temp
                if !speechRecognizer
                    .arr_transcript[arr_transcript_index]
                    .contains(String(arr_keyword[arr_keyword_index])) {
                    checking = false
                    break
                }
            }
            if checking && !vm.practice.saidKeywords[vm.currentPageIndex].contains(keyword) {
                vm.practice.saidKeywords[vm.currentPageIndex].append(keyword)
            }
        }
    }
    
    func resetGroup() {
        for groupIndex in 0..<(projectFileManager.pdfDocument?.PDFGroups.count)! {
            if vm.currentPageIndex <= (projectFileManager
                .pdfDocument?.PDFGroups[groupIndex].range.end)!
                && vm.currentPageIndex >= (projectFileManager
                    .pdfDocument?.PDFGroups[groupIndex].range.start)! {
                vm.currentPageGroup = groupIndex
            }
        }
    }
}

struct PresentationView_Previews: PreviewProvider {
    static var previews: some View {
        PresentationView()
    }
}
