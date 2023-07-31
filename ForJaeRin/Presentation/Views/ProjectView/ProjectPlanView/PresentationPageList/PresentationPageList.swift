//
//  PresentationPageList.swift
//  ForJaeRin
//
//  Created by Yun Dongbeom on 2023/07/14.
//

import SwiftUI

struct PresentationPageList: View {
    @EnvironmentObject var projectFileManager: ProjectFileManager
    @State var pdfDocumentPages: [PDFPage]
    @EnvironmentObject var myData: MyData
    @State var clickedKeywordIndex: Int?
    @FocusState var focusField: Int?
    @State var lastIndexes: [Int]
    @State private var isShowingFullScreenImage = false // 린 추가
    @State private var clickedListIndex = 0
    
    var body: some View {
        ZStack {
            let document = projectFileManager.pdfDocument!
            GeometryReader { geometry in
                ScrollView {
                    LazyVStack(spacing: 0) {
                        if myData.isOnboardingActive {
                            PresentationPageListOnboardingView(
                                conatainerWidth: geometry.size.width,
                                isOnboardingActive: $myData.isOnboardingActive)
                        }
                        ForEach(myData.images.indices, id: \.self) { index in
                            PresentationPageListItem(
                                containerWidth: geometry.size.width - 407,
                                groupIndex: document.findGroupIndex(pageIndex: index),
                                pageIndex: index,
                                pdfGroup: document.PDFGroups[document.findGroupIndex(pageIndex: index)],
                                clickedKeywordIndex: $clickedKeywordIndex,
                                focusField: _focusField,
                                lastIndexes: $lastIndexes,
                                clickedListIndex: $clickedListIndex,
                                isShowingFullScreenImage: $isShowingFullScreenImage
                            )
                        }
                    }.onReceive(projectFileManager.pdfDocument!.$PDFPages, perform: { newValue in
                            pdfDocumentPages = newValue
                    })
                }.frame(width: geometry.size.width, height: geometry.size.height)
                    .sheet(isPresented: $isShowingFullScreenImage) {
                        FullScreenImageView(
                            isPresented: $isShowingFullScreenImage,
                            pageIndex: clickedListIndex,
                            containerWidth: geometry.size.width
                        )
                    }
            }
            Button {
                if clickedKeywordIndex != nil {
                    deleteKeyword(index: clickedKeywordIndex!)
                    clickedKeywordIndex = nil
                }
            } label: {
                Text("제거를 위한")
                    .foregroundColor(Color(white: 0.5, opacity: 0.0001))
            }
            .buttonStyle(.plain)
            .keyboardShortcut(.delete, modifiers: [])
            .keyboardShortcut(KeyEquivalent.delete, modifiers: [])
        }
        .onChange(of: focusField) { newValue in
            if newValue != nil { clickedKeywordIndex = nil }
        }
    }
    
    private func deleteKeyword(index: Int) {
        withAnimation {
            if lastIndexes[index / 7] != 0 {
                myData.keywords[index / 7].remove(at: Int(index % 7))
                myData.keywords[index / 7].append("")
                lastIndexes[index / 7] -= 1
            }
        }
    }
}
