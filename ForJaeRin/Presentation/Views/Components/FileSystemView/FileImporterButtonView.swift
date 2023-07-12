//
//  OpenFileDialogView.swift
//  ForJaeRin
//
//  Created by Yun Dongbeom on 2023/07/12.
//

import SwiftUI

/**
 파일 시스템과 관련된 클래스와 연동해서, PDF파일 경로를 들고 있는 것이 좋을 것 같습니다.
 */
// MARK: PDF를 불러오기 위한 View
struct FileImporterButtonView: View {
    
    @State private var isImporting: Bool = false
    
    var body: some View {
        Button(action: {
            isImporting = true
        }, label: {
            Text("PDF 파일 불러오기")
        })
        .fileImporter(isPresented: $isImporting,
                      allowedContentTypes: [.pdf],
            onCompletion: { result in
            switch result {
            case .success(let success):
                print(success)
//                let newImage = createImage(imageFile: success)
            case .failure(let failure):
                print(failure)
            }
        })
    }
}

struct FileImporterButtonView_Previews: PreviewProvider {
    static var previews: some View {
        FileImporterButtonView()
    }
}
