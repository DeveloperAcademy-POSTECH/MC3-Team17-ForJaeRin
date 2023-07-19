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
    @StateObject var vm = ProjectDocumentVM()
    
    @State var currentTab: Tabs = .practice
    @State var isPracticeModeActive = false
    
    var body: some View {
        VStack(spacing: 0) {
            // custom toolbar
            toolbarView()
            HSplitView {
                // left sidebar
                VStack {
                    VStack(spacing: 0) {
                        List(vm.mainTabs, id: \.self, selection: $currentTab) { mainTab in
                            Label(mainTab.tabName, systemImage: mainTab.iconName)
                                .labelStyle(LeftSidebarLabelStyle(
                                    isSelected: currentTab.tabName == mainTab.tabName ))
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
                        if currentTab == .practice {
                            ProjectPlanView(vm: vm)
                        } else {
                            Text("연습 기록보기")
                        }
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
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
                withAnimation {
                    vm.isLeftSidebarActive.toggle()
                }
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
            if currentTab == .practice {
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
                        PresentationView(projectFileManager: projectFileManager)
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
