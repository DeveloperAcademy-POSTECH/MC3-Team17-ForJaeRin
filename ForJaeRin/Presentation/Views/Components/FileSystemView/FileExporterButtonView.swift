//
//  SaveFileDialogView.swift
//  ForJaeRin
//
//  Created by Yun Dongbeom on 2023/07/12.
//

import SwiftUI

/**
 재배열 된 PDF를 내보내기 하기 위해 사용될 버튼입니다. - 후순위
 
 프로젝트를 저장하는 방식에 대해서 작성한 프로젝트를 파일로 저장하는 방법을 사용하면 좋을 것 같은데, macOS 경험이 없어서 어렵네요.
 참고 링크 - Building a Document-Based App with SwiftUI
 - https://developer.apple.com/documentation/swiftui/building_a_document-based_app_with_swiftui
 */
// MARK: 파일을 내보내기 위한 View
struct FileExporterButtonView: View {
    @State private var isPublishing: Bool = false
        
    var body: some View {
        Button(action: {
            isPublishing = true
        }, label: {
            Text("Publish")
        })
//        .fileExporter(isPresented: $isPublishing, documents: [], contentType: .pdf) { result in
//            switch result {
//            case .success(let success):
//                print(success)
//            case .failure(let failure):
//                print(failure)
//            }
//        }
    }
}

struct FileExporterButtonView_Previews: PreviewProvider {
    static var previews: some View {
        FileExporterButtonView()
    }
}
