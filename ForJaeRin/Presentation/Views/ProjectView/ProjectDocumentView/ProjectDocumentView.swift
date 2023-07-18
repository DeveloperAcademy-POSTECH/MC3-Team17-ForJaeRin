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
    @EnvironmentObject var projectFileManager: ProjectFileManager
    @EnvironmentObject var document: KkoDocument
    @Environment(\.undoManager) var undoManager
    
    let mainTabs: [Tabs] = [.practice, .record]
    @State private var currentTab: Tabs = .practice
    @State private var isLeftSidebarActive = true
    
    var body: some View {
        VStack(spacing: 0) {
            // custom toolbar
            toolbarView()
            HSplitView {
                // left sidebar
                VStack {
                    VStack(spacing: 0) {
                        List(mainTabs, id: \.self, selection: $currentTab) { mainTab in
                            Label(mainTab.tabName, systemImage: mainTab.iconName)
                        }
                    }
                }
                .frame(
                    maxWidth: isLeftSidebarActive ? 172 : 0,
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
            .transition(.move(edge: .leading)) // 슬라이드 트랜지션
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

extension ProjectDocumentView {
    func toolbarView() -> some View {
        HStack(spacing: 0) {
            Button {
                withAnimation {
                    isLeftSidebarActive.toggle()
                }
            } label: {
                Label("leftSidebar", systemImage: "sidebar.leading")
                    .labelStyle(.iconOnly)
            }
            Spacer()
            Button {
                print("임시")
            } label: {
                Label("rightSidebar", systemImage: "sidebar.trailing")
                    .labelStyle(.iconOnly)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: 32, alignment: .center)
        .padding(.vertical ,4)
        .padding(.horizontal, 8)
        .background(Color.systemWhite)
        .border(width: 1, edges: [.bottom], color: Color.systemGray100)
    }
}

extension ProjectDocumentView {
    enum Tabs {
        case practice
        case record
        
        var tabName: String {
            switch self {
            case .practice:
                return "연습하기"
            case .record:
                return "연습 기록보기"
            }
        }
        
        var iconName: String {
            switch self {
            case .practice:
                return "folder.fill"
            case .record:
                return "doc.richtext.fill"
            }
        }
    }
}

extension ProjectDocumentView {
    private func testSidebar() -> some View {
        NavigationSplitView {
            List(mainTabs, id: \.self, selection: $currentTab) { mainTab in
                NavigationLink(value: mainTab) {
                    Label(mainTab.tabName, systemImage: mainTab.iconName)
                }
            }
            .navigationSplitViewColumnWidth(172)
        } detail: {
            VStack {
                if currentTab == .practice {
                    ProjectPlanView()
                } else {
                    Text("연습 기록보기")
                }
            }
        }
    }
    
    private struct 임시테스트: View {
        @EnvironmentObject var projectFileManager: ProjectFileManager
        @EnvironmentObject var document: KkoDocument
        
        var body: some View {
            VStack {
                Text(document.kkoProject.title)
                OpenWindowButton()
                Button {
                    document.kkoProject.title = "myTest!"
                } label: {
                    Text("change name")
                }

            }
            .onAppear {
                print(document.kkoProject.path)
            }
        }
    }
}

struct ProjectDocumentView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectDocumentView()
    }
}


struct OpenWindowButton: View {
    @Environment(\.openWindow) private var openWindow

    var body: some View {
        Button("Open Activity Window") {
            openWindow(id: "Home")
        }
    }
}
