//
//  PresentationPDFView.swift
//  ForJaeRin
//
//  Created by Yun Dongbeom on 2023/07/12.
//

import SwiftUI

/**
 프레젠테이션과 키워드 뷰 간 연동 필요
 키보드 바인딩 필요
 */

// MARK: PDF뷰를 가져와서 연습모드에 띄울 뷰
struct PresentationPDFView: View {
    let pdfUrl = Bundle.main.url(forResource: "sample", withExtension: "pdf")!
    
    var body: some View {
        VStack {
            PDFKitView(url: pdfUrl, pageNumber: 0)
        }
    }
}

struct PresentationPDFView_Previews: PreviewProvider {
    static var previews: some View {
        PresentationPDFView()
    }
}
