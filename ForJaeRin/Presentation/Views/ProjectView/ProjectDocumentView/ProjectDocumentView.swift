//
//  ProjectDocumentView.swift
//  ForJaeRin
//
//  Created by Yun Dongbeom on 2023/07/17.
//

import SwiftUI

/**
 두번째 플로우 테스트
 */

struct ProjectDocumentView: View {
    // MARK: NavigationStack에서 pop하기 위한 function
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var projectFileManager: ProjectFileManager
    @EnvironmentObject var document: KkoDocument
    @EnvironmentObject var myData: MyData
    @StateObject var vm = ProjectDocumentVM()
    @StateObject var importPDFVM = ImportPDFVM()
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                // custom toolbar
                toolbarView()
                HStack(spacing: 0) {
                    // left sidebar
                    VStack {
                        VStack(spacing: 0) {
                            List(vm.mainTabs, id: \.self, selection: $vm.currentTab) { mainTab in
                                Label(mainTab.tabName, systemImage: mainTab.iconName)
                                    .labelStyle(LeftSidebarLabelStyle(
                                        isSelected: vm.currentTab.tabName == mainTab.tabName ))
                                    .listRowBackground(Color.systemWhite)
                                    .listStyle(.plain)
                                    .frame(minHeight: 40)
                            }
                        }
                    }
                    .frame(
                        maxWidth: vm.isLeftSidebarActive ? 172 : 0,
                        maxHeight: .infinity,
                        alignment: .topLeading)
                    .background(Color.systemWhite)
                    // rightsidebar
                    VStack {
                        VStack {
                            if vm.currentTab == .practice {
                                ProjectPlanView(vm: vm)
                            } else {
                                ProjectHistoryDashboardView()
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .sheet(isPresented: $vm.isSheetActive) {
                let height = min(geometry.size.height - 64, 804)
                // MARK: 새 프로젝트 열기 데이터를 받기 위한 뷰
                ImportPDFView(
                    vm: importPDFVM,
                    isSheetActive: $vm.isSheetActive,
                    isNewProjectSettingDone: $vm.isNewProjectSettingDone
                )
                .frame(
                    minWidth: vm.getSheetWidth(height: height),
                    maxWidth: vm.getSheetWidth(height: height),
                    minHeight: height
                )
                .environmentObject(projectFileManager)
                .environmentObject(myData)
            }
            .onAppear {
                importPDFVM.step = .setGroup
                // MARK: - 온보딩 토글 임시
    //            myData.isOnboardingActive = true
            }
        }
    }
    private func handleGoToback() {
        if myData.isHistoryDetailActive {
            myData.isHistoryDetailActive = false
        } else if vm.currentSection == .flow {
            vm.currentSection = .edit
        }
    }
}

extension ProjectDocumentView {
    // MARK: toolbarView
    private func toolbarView() -> some View {
        ZStack {
            HStack(spacing: 0) {
                // 고정 영역
                toolbarStaticItemView()
                Spacer()
                // 탭에 따라 변경되는 영역
                toolbarDynamicItemView()
            }
            .frame(
                maxWidth: .infinity,
                maxHeight: vm.TOOLBAR_HEIGHT,
                alignment: .center
            )
            .padding(.top, 12)
            .padding(.bottom, 8)
            .padding(.horizontal, 28)
            .background(Color.systemWhite)
            .border(width: 1, edges: [.bottom], color: Color.systemGray100)
            Text(projectFileManager.projectMetadata?.projectName ?? "프로젝트 명")
                .systemFont(.body)
            
        }
    }
    
    private func toolbarStaticItemView() -> some View {
        HStack(spacing: 32) {
            // goToHome
            Button {
                    dismiss()
            } label: {
                Label("home", systemImage: "house.fill")
                    .labelStyle(ToolbarIconOnlyLabelStyle())
                    .frame(maxWidth: 28, maxHeight: 28)
                    .foregroundColor(Color.systemGray400)
            }
            .buttonStyle(.plain)
            Button {
                vm.isLeftSidebarActive.toggle()

            } label: {
                Label("leftSidebar", systemImage: "sidebar.leading")
                    .labelStyle(ToolbarIconOnlyLabelStyle())
                    .frame(maxWidth: 28, maxHeight: 28)
                    .foregroundColor(Color.systemGray400)
            }
            .buttonStyle(.plain)
            if myData.isHistoryDetailActive || vm.currentSection == .flow {
                Button {
                    handleGoToback()
                } label: {
                    Label("redo", systemImage: "chevron.left")
                        .labelStyle(ToolbarIconOnlyLabelStyle())
                        .frame(maxWidth: 28, maxHeight: 28)
                        .foregroundColor(Color.systemGray400)
                }
                .buttonStyle(.plain)
            }
        }
    }
    
    private func toolbarDynamicItemView() -> some View {
        Group {
            if vm.currentTab == .practice {
                HStack {
                    Button {
                        vm.isSheetActive = true
                        // 키워드 or 스크립트 변경된거까지 다시 저장
                        projectFileManager.myDataToProjectFileManager(myData: myData)
                        projectFileManager.exportFile()
                    } label: {
                        Label(
                            Plans.edit.planName,
                            systemImage: Plans.edit.iconName
                        )
                        .labelStyle(ToolbarVerticalLabelStyle(isSelected:  false))
                        .frame(maxWidth: 64, maxHeight: 64)
                        .foregroundColor(Color.systemGray400)
                    }
                    .buttonStyle(.plain)
                    Button {
                        // MARK: - 임시 그룹 설정을 위한,,
                        projectFileManager.pdfDocument?.url = myData.url
                        myData.keywords.enumerated().forEach { index, keyword in
                            projectFileManager.pdfDocument?.PDFPages[index].keywords = []
                            
                            keyword.forEach { item in
                                if item != "" {
                                    projectFileManager.pdfDocument?.PDFPages[index].keywords.append(item)
                                }
                            }
                        }
                        vm.currentSection = .flow
                        
                        // 키워드 or 스크립트 변경된거까지 다시 저장
                        projectFileManager.myDataToProjectFileManager(myData: myData)
                        projectFileManager.exportFile()
                    } label: {
                        Label(
                            Plans.flow.planName,
                            systemImage: Plans.flow.iconName
                        )
                        .labelStyle(ToolbarVerticalLabelStyle(isSelected:  false))
                        .frame(maxWidth: 64, maxHeight: 64)
                        .foregroundColor(Color.systemGray400)
                    }
                    .buttonStyle(.plain)
                    NavigationLink {
                        PresentationView()
                            .environmentObject(VoiceManager.shared)
                            .environmentObject(projectFileManager)
                            .environmentObject(vm)
//                            .onAppear {
//                                // 키워드 or 스크립트 변경된거까지 다시 저장
//                                projectFileManager.myDataToProjectFileManager(myData: myData)
//                                projectFileManager.exportFile()
//                            }
                    } label: {
                        Label(
                            Plans.practice.planName,
                            systemImage: Plans.practice.iconName
                        )
                        .labelStyle(ToolbarVerticalLabelStyle(isSelected:  vm.currentSection == .practice))
                        .frame(maxWidth: 64, maxHeight: 64)
                        .foregroundColor(Color.systemGray400)
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }
}

struct ProjectDocumentView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectDocumentView()
    }
}
