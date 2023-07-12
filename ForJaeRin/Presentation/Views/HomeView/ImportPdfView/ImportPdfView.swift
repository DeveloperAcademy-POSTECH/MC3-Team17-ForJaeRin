//
//  ImportPdfView.swift
//  ForJaeRin
//
//  Created by Yun Dongbeom on 2023/07/12.
//

import SwiftUI

struct ImportPdfView: View {
    @Binding var isSheetActive: Bool
    
    var body: some View {
        VStack {
            // header
            HStack {
                HStack {
                    Text("PDF 가져오기")
                    Text("페이지 카운트 1/4")
                }
                Spacer()
                Button {
                    print("닫기")
                    isSheetActive = false
                } label: {
                    Image(systemName: "xmark")
//                        .frame(width: 40, height: 40)
                }
            }
            .padding(8)
            // body
            VStack {
                Spacer()
                FileImporterButtonView()
                    .buttonStyle(AppButtonStyle())
                Spacer()
            }
            HStack {
                Spacer()
                Button {
                    print("next")
                } label: {
                    Text("다음")
                }
                .buttonStyle(AppButtonStyle(width: 80))
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            // footer
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }
}

struct ImportPdfView_Previews: PreviewProvider {
    static var previews: some View {
        @State var isSheetActive = false
        ImportPdfView(isSheetActive: $isSheetActive)
    }
}
