//
//  ProjectView.swift
//  ForJaeRin
//
//  Created by Yun Dongbeom on 2023/07/11.
//

import SwiftUI
import AppKit

struct SplitLayoutView: View {
    let mainTabs: [MainTabs] = [.home, .project, .settings]

    @State private var currentTab: MainTabs = .home
    @State private var currentContents: TabContents = .home
    @State private var currentColumn: TabColumns = .single
    @State private var isContentsActive = true
    
    var body: some View {
        NavigationSplitView {
            sidebarView()
            .navigationSplitViewColumnWidth(80)
            .onChange(of: currentTab) { newCurrentTab in
                currentContents = newCurrentTab.tabContents[0]
            }
        } content: {
            tabContentsView()
        } detail: {
            detailView()
        }
    }
}

extension SplitLayoutView {
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
    
    private func tabContentsView() -> some View {
        Group {
            if currentTab == .project {
                Group {
                    if isContentsActive {
                        List(
                            currentTab.tabContents,
                            id: \.self,selection: $currentContents) { tabContents in
                            NavigationLink(value: tabContents) {
                                Label(tabContents.contentsName, systemImage: "heart.fill")
                            }
                        }
                        .navigationSplitViewColumnWidth(120)
                    } else {
                        List(
                            currentTab.tabContents,
                            id: \.self,selection: $currentContents) { tabContents in
                            NavigationLink(value: tabContents) {
                                Label(tabContents.contentsName, systemImage: "heart.fill")
                            }
                        }
                        .navigationSplitViewColumnWidth(0)
                    }
                }
            } else {
                List(currentTab.tabContents, id: \.self,selection: $currentContents) { tabContents in
                    NavigationLink(value: tabContents) {
                        Label(tabContents.contentsName, systemImage: "heart.fill")
                    }
                }
                .navigationSplitViewColumnWidth(0)
            }
        }
        .navigationTitle(currentContents.contentsName)
    }
    
    private func detailView() -> some View {
        Group {
            if currentContents == .home {
                HomeView()
            } else if currentContents == .present {
                PresentationView(isContentsActive: $isContentsActive)
            } else if currentContents == .history {
                ProjectHistoryView()
            }
        }
    }
}

struct SplitLayoutView_Previews: PreviewProvider {
    static var previews: some View {
        SplitLayoutView()
    }
}
