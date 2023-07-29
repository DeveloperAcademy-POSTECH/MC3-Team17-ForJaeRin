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
    
    var body: some View {
        let document = projectFileManager.pdfDocument!
        ScrollView {
                if myData.isOnboardingActive {
                    PresentationPageListOnboardingView(isOnboardingActive: $myData.isOnboardingActive)
                }
                ForEach(myData.images.indices, id: \.self) { index in
                    PresentationPageListItem(
                        groupIndex: document.findGroupIndex(pageIndex: index),
                        pageIndex: index,
                        pdfGroup: document.PDFGroups[document.findGroupIndex(pageIndex: index)]
                    )
                }
            .onReceive(projectFileManager.pdfDocument!.$PDFPages, perform: { newValue in
                pdfDocumentPages = newValue
            })
        }
    }
}
