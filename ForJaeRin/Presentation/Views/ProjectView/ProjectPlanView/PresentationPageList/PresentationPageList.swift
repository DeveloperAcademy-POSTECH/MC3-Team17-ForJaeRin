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
    @State var isOnboardingActive = true
    
    @EnvironmentObject var myData: MyData
    
    var body: some View {
        GeometryReader { geometry in
            let document = projectFileManager.pdfDocument!
            ScrollView {
                List {
                    if isOnboardingActive {
                        PresentationPageListOnboardingView(isOnboardingActive: $isOnboardingActive)
                    }
                    ForEach(myData.images.indices, id: \.self) { index in
                        PresentationPageListItem(
                            groupIndex: document.findGroupIndex(pageIndex: index),
                            pageIndex: index,
                            pdfGroup: document.PDFGroups[document.findGroupIndex(pageIndex: index)]
                            // pdfPage: document.PDFPages[index]
                        )
                    }.onMove { fromIndex, toIndex in
                        document.PDFPages.move(fromOffsets: fromIndex, toOffset: toIndex)
                    }
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
                .onReceive(projectFileManager.pdfDocument!.$PDFPages, perform: { newValue in
                    pdfDocumentPages = newValue
                })
            }
        }
    }
}
