//
//  PresentationView.swift
//  ForJaeRin
//
//  Created by Yun Dongbeom on 2023/07/11.
//

import SwiftUI

struct PresentationView: View {
    @Binding var isContentsActive: Bool
    @State var isSidebarActive = true
    @State var isDragging = false
    @State var position = CGSize.zero
    
    var body: some View {
            VStack(spacing: 0) {
                toolbarView()
                HSplitView {
                    splitLeftView()
                    splitRightView()
                }
                .toolbar {
                    Button {
                        isSidebarActive.toggle()
                    } label: {
                        Image(systemName: "sidebar.trailing")
                    }
                }
            }
        .presentedWindowToolbarStyle(.unifiedCompact(showsTitle: true))
    }
}

extension PresentationView {
    func splitLeftView() -> some View {
        return ZStack {
            PresentationTimerView()
                .zIndex(10)
            VStack(spacing: 0) {
                PresentationPDFView()
                AudioControllerView()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .border(.red, width: 2)
    }
    
    func splitRightView() -> some View {
        let ACTIVE_SIDEBAR_WIDTH: CGFloat = 272
        
        return VStack(spacing: 0) {
            KeywordListView()
            VoiceVisualizationView()
        }
        .frame(
        minWidth: isSidebarActive ? ACTIVE_SIDEBAR_WIDTH : 0,
        maxWidth: isSidebarActive ? ACTIVE_SIDEBAR_WIDTH : 0,
        maxHeight: .infinity, alignment: .topLeading)
    }
    
    func toolbarView() -> some View {
        HStack(spacing: 0) {
            Button {
                isContentsActive.toggle()
            } label: {
                Label("leftSidebar", systemImage: "sidebar.leading")
                    .labelStyle(.iconOnly)
            }
            Spacer()
            Button {
                isSidebarActive.toggle()
            } label: {
                Label("rightSidebar", systemImage: "sidebar.trailing")
                    .labelStyle(.iconOnly)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: 32, alignment: .center)
        .padding(.vertical ,4)
        .padding(.horizontal, 8)
        .border(width: 1, edges: [.bottom], color: .init(nsColor: .alternateSelectedControlTextColor))
    }
}

struct PresentationView_Previews: PreviewProvider {
    static var previews: some View {
        @State var isContentsActive = true
        PresentationView(isContentsActive: $isContentsActive)
    }
}
