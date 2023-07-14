//
//  ProjectView.swift
//  ForJaeRin
//
//  Created by Yun Dongbeom on 2023/07/11.
//

import SwiftUI
import AppKit

// MARK: 메인으로 사용될 레이아웃 컨테이너 뷰
struct SplitLayoutView: View {
    ///
    /// Tab Layout 구조
    ///
    /// Tab : [
    ///     TabContents: [
    ///         TabColumns,
    ///         TabColumns
    ///     ],
    ///     TabContents: [
    ///         TabColumns
    ///     ]
    ///  ]
    ///
    let mainTabs: [MainTabs] = [.home, .project, .settings]
    @State private var currentTab: MainTabs = .home
    @State private var currentContent: TabContents = .home
    @State private var currentColumn: TabColumns = .single
    @State private var isContentsActive = true
    
    var body: some View {
        /// NavigationSplitView은 3 depth로 이루어져 있습니다.
        NavigationSplitView {
            /// 1depth - 최상위 view
            sidebarView()
            .navigationSplitViewColumnWidth(80)
            .onChange(of: currentTab) { newCurrentTab in
                currentContent = newCurrentTab.tabContents[0]
            }
        } content: {
            /// 2depth - currentTab에 따라 다른 view로 분기됩니다.
            tabContentsView()
        } detail: {
            /// 3depth - currentContent에 따라 다른 view로 분기됩니다.
            detailView()
        }
    }
}

extension SplitLayoutView {
    // MARK: 1Depth 메뉴
    private func sidebarView() -> some View {
        List(mainTabs, id: \.self,selection: $currentTab) { mainTab in
            NavigationLink(value: mainTab) {
                Label(mainTab.tabName, systemImage: "heart.fill")
                    .labelStyle(LeftSidebarLabelStyle())
                    .padding(8)
                    .foregroundColor(
                        mainTab == currentTab
                        ? .accentColor
                        : Color(nsColor: .tertiaryLabelColor))
            }
            .listRowBackground(mainTab == currentTab ? .white : Color(hex: "#F2F2F7"))
        }
        .listStyle(.plain)
        .background(Color(hex: "#F2F2F7"))
        .scrollContentBackground(.hidden)
    }
    
    // MARK: 2Depth View
    private func tabContentsView() -> some View {
        Group {
            if currentTab == .project {
                Group {
                    if isContentsActive {
                        List(
                            currentTab.tabContents,
                            id: \.self,selection: $currentContent) { tabContents in
                            NavigationLink(value: tabContents) {
                                Label(tabContents.contentsName, systemImage: "heart.fill")
                            }
                        }
                        .navigationSplitViewColumnWidth(120)
                    } else {
                        List(
                            currentTab.tabContents,
                            id: \.self,selection: $currentContent) { tabContents in
                            NavigationLink(value: tabContents) {
                                Label(tabContents.contentsName, systemImage: "heart.fill")
                            }
                        }
                        .navigationSplitViewColumnWidth(0)
                    }
                }
            } else {
                List(currentTab.tabContents, id: \.self,selection: $currentContent) { tabContents in
                    NavigationLink(value: tabContents) {
                        Label(tabContents.contentsName, systemImage: "heart.fill")
                    }
                }
                .navigationSplitViewColumnWidth(0)
            }
        }
        .navigationTitle(currentContent.contentsName)
    }
    
    // MARK: 3Depth View
    private func detailView() -> some View {
        Group {
            if currentContent == .home {
                HomeView()
            } else if currentContent == .present {
                PresentationView(isContentsActive: $isContentsActive)
            } else if currentContent == .history {
                ProjectHistoryView()
            } else if currentContent == .plan {
                ProjectPlanView()
            }
        }
    }
}

struct SplitLayoutView_Previews: PreviewProvider {
    static var previews: some View {
        SplitLayoutView()
    }
}
