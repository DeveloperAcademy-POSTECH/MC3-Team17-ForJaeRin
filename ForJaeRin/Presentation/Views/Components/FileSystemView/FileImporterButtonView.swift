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
    @EnvironmentObject var myData: MyData
    @State private var isImporting: Bool = false
    @Binding var step: Int
    
    var body: some View {
        
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .stroke(style: StrokeStyle(lineWidth: 2, dash: [5]))
                .foregroundColor(Color(hex: "2F2F2F"))
                .opacity(0.25)
                .background(Color.clear)
                .frame(width: 532, height: 431)
            
            VStack {
                Image("pdfLoadIcon")
                    .resizable()
                    .frame(width: 84, height: 58)
                Text("PDF 파일을 여기에 끌어서 추가할 수 있어요")
                    .padding(EdgeInsets(top: 24, leading: 0, bottom: 0, trailing: 0))
                    .foregroundColor(Color(hex: "000000"))
                    .opacity(0.5)
                Button(action: {
                    isImporting = true
                }, label: {
                    Text("PDF 파일 불러오기")
                })
                .padding(EdgeInsets(top: 24, leading: 0, bottom: 0, trailing: 0))
                .fileImporter(isPresented: $isImporting,
                              allowedContentTypes: [.pdf],
                              onCompletion: { result in
                    switch result {
                    case .success(let success):
                        print(success)
                        myData.url = success
                        step += 1
                    case .failure(let failure):
                        print(failure)
                    }
                })
            }
        }
    }
}

// struct FileImporterButtonView_Previews: PreviewProvider {
//    static var previews: some View {
//
//        FileImporterButtonView(step: $a)
//    }
// }
