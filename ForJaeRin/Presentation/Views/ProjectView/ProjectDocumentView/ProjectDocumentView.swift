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
    
    var body: some View {
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
                            Button {
                                print("myData.groupData", myData.groupData)
                                print("projectFileManager.pdfDocument?.PDFGroups", projectFileManager.pdfDocument?.PDFGroups)
                            } label: {
                                Text("테스트")
                            }

                            ProjectPlanView(vm: vm)
                                .environmentObject(myData)
                        } else {
                             ProjectHistoryView()
//                            Text("준비 중,,")
                        }
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .onAppear {
            print("projectFileManager.projectMetadata?.projectName", projectFileManager.projectMetadata?.projectName)

        }
    }
}

extension ProjectDocumentView {
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
            maxHeight: vm.TOOLBAR_HEIGHT,
            alignment: .center
        )
        .padding(.top, 12)
        .padding(.bottom, 8)
        .padding(.horizontal, 28)
        .padding(.trailing, 60)
        .background(Color.systemWhite)
        .border(width: 1, edges: [.bottom], color: Color.systemGray100)
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
        }
    }
    
    private func toolbarDynamicItemView() -> some View {
        Group {
            if vm.currentTab == .practice {
                HStack {
                    Button {
                        vm.currentSection = .edit
                    } label: {
                        Label(
                            Plans.edit.planName,
                            systemImage: Plans.edit.iconName
                        )
                        .labelStyle(ToolbarVerticalLabelStyle(isSelected:  vm.currentSection == .edit))
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
                    } label: {
                        Label(
                            Plans.flow.planName,
                            systemImage: Plans.flow.iconName
                        )
                        .labelStyle(ToolbarVerticalLabelStyle(isSelected:  vm.currentSection == .flow))
                        .frame(maxWidth: 64, maxHeight: 64)
                        .foregroundColor(Color.systemGray400)
                    }
                    .buttonStyle(.plain)
                    NavigationLink {
                        PresentationView()
                            .environmentObject(VoiceManager.shared)
                            .environmentObject(projectFileManager)
                            .environmentObject(vm)
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
