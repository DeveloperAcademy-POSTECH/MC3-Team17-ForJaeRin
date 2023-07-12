//
//  PDFView.swift
//  ForJaeRin
//
//  Created by Yun Dongbeom on 2023/07/12.
//

import SwiftUI
import PDFKit

struct PDFKitView: NSViewRepresentable {
    typealias NSViewType = PDFView
    let url: URL // new variable to get the URL of the document
    
    func makeNSView(context: NSViewRepresentableContext<PDFKitView>) -> PDFView {
        // Creating a new PDFVIew and adding a document to it
        let pdfView = PDFView()
        pdfView.document = PDFDocument(url: self.url)
        return pdfView
    }
    
    func updateNSView(_ uiView: PDFView, context: NSViewRepresentableContext<PDFKitView>) {
        // we will leave this empty as we don't need to update the PDF
    }
}

struct PDFView_Previews: PreviewProvider {
    static var previews: some View {
        let pdfUrl = Bundle.main.url(forResource: "sample", withExtension: "pdf")!
        
        PDFKitView(url: pdfUrl)
            .scaledToFill()
    }
}
