//
//  PresentationPDFView.swift
//  ForJaeRin
//
//  Created by Yun Dongbeom on 2023/07/12.
//

import SwiftUI

struct PresentationPDFView: View {
    let pdfUrl = Bundle.main.url(forResource: "sample", withExtension: "pdf")!
    
    var body: some View {
        VStack {
            PDFKitView(url: pdfUrl)
        }
    }
}

struct PresentationPDFView_Previews: PreviewProvider {
    static var previews: some View {
        PresentationPDFView()
    }
}
