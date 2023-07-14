//
//  PresentationPageList.swift
//  ForJaeRin
//
//  Created by Yun Dongbeom on 2023/07/14.
//

import SwiftUI

struct PresentationPageList: View {
    @Binding var pdfDocument: PDFDocumentManager
    
    var body: some View {
        List {
            ForEach(0..<pdfDocument.PDFPages.count, id: \.self) { index in
                PresentationPageListItem(
                    groupIndex: pdfDocument.findGroupIndex(pageIndex: index),
                    pageIndex: index,
                    pdfGroup: pdfDocument.PDFGroups[pdfDocument.findGroupIndex(pageIndex: index)],
                    pdfPage: pdfDocument.PDFPages[index])
            }.onMove { fromIndex, toIndex in
                pdfDocument.PDFPages.move(fromOffsets: fromIndex, toOffset: toIndex)
            }
        }
    }
}

// struct PresentationPageList_Previews: PreviewProvider {
//    static var previews: some View {
//        PresentationPageList()
//    }
// }
