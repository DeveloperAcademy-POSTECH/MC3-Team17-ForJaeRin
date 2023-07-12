//
//  OpenFileDialogView.swift
//  ForJaeRin
//
//  Created by Yun Dongbeom on 2023/07/12.
//

import SwiftUI

struct FileImporterButtonView: View {
    
    @State private var isImporting: Bool = false
    
    var body: some View {
        Button(action: {
            isImporting = true
        }, label: {
            Text("PDF 파일 불러오기")
        })
        .fileImporter(isPresented: $isImporting,
                      allowedContentTypes: [.png, .jpeg, .tiff, .pdf],
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
