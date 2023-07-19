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
                            ProjectPlanView()
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
            HStack(spacing: 0) {
                Button {
                    withAnimation {
                        vm.isLeftSidebarActive.toggle()
                    }
                } label: {
                    Label("leftSidebar", systemImage: "sidebar.leading")
                        .labelStyle(.iconOnly)
                }
                Button {
                    withAnimation {
                        dismiss()
                    }
                } label: {
                    Label("leftSidebar", systemImage: "sidebar.leading")
                        .labelStyle(.iconOnly)
                }
            }
            Spacer()
            // 탭에 따라 변경되는 영역
            if currentTab == .practice {
                Button {
                    print("임시")
                } label: {
                    Label("rightSidebar", systemImage: "sidebar.trailing")
                        .labelStyle(.iconOnly)
                }
            }

        }
        .frame(maxWidth: .infinity, maxHeight: 72, alignment: .center)
        .padding(.vertical ,4)
        .padding(.horizontal, 8)
        .background(Color.systemWhite)
        .border(width: 1, edges: [.bottom], color: Color.systemGray100)
    }
}


struct ProjectDocumentView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectDocumentView()
    }
}
