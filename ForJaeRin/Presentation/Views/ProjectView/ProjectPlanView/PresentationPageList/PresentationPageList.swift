//
//  PresentationPageList.swift
//  ForJaeRin
//
//  Created by Yun Dongbeom on 2023/07/14.
//

import SwiftUI

struct PresentationPageList: View {
    @EnvironmentObject var projectFileManager: ProjectFileManager
    
    var pdfDocument: PDFDocumentManager {
        didSet {
            print(pdfDocument.PDFPages)
        }
    }
    
    @State var pdfDocumentPages: [PDFPage] {
        didSet {
            print(pdfDocumentPages)
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(showsIndicators: false) {
                List {
                    PresentationPageListOnboardingView()
                    ForEach(Array(pdfDocumentPages.enumerated()), id: \.element.id) { index, _ in
                        PresentationPageListItem(
                            groupIndex: pdfDocument.findGroupIndex(pageIndex: index),
                            pageIndex: index,
                            pdfGroup: pdfDocument.PDFGroups[pdfDocument.findGroupIndex(pageIndex: index)],
                            pdfPage: pdfDocument.PDFPages[index])
                    }.onMove { fromIndex, toIndex in
                        pdfDocument.PDFPages.move(fromOffsets: fromIndex, toOffset: toIndex)
                    }
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
                .onReceive(projectFileManager.pdfDocument!.$PDFPages, perform: { newValue in
                    print(newValue)
                    pdfDocumentPages = newValue
                })
                .frame(width: geometry.size.width, height: geometry.size.height)
            }
        }
    }
}
