//
//  ImportPdfView.swift
//  ForJaeRin
//
//  Created by Yun Dongbeom on 2023/07/12.
//

import SwiftUI

/**
 1. 창에서 기본 상단 x(닫기)버튼을 누를 시, 초기 화면으로 되돌아감
 2. 파일 추가하기 버튼 누르기 -> PDF 파일 가져오기 Finder Open
 3. 프로젝트 생성 - 세부 내용 작성(발표제목 / 발표 목적 / 발표 대상 / 발표 예정 소요시간)
 4. 스크립트 입력 기능 - 각 PDF 페이지 별 키워드 및 스크립트 작성
 5. 발표자료 그룹화 기능 - PDF 그룹화하기
 
 각 스텝별로 하위 뷰를 생성하여 작업하면 좋을 것 같습니다.
 
 */
// MARK: 새 프로젝트를 생성하기 위한 시트뷰
struct ImportPDFView: View {
    @Binding var isSheetActive: Bool
    @Binding var step: Int {
        didSet {
            if step > 3 {
                isSheetActive = false
            }
        }
    }
    
    var body: some View {
        VStack {
            // header
            HStack {
                HStack {
                    Text("PDF 가져오기")
                    Text("페이지 카운트 \(step)/4")
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
                Button {
                    print("prev")
                    if step > 0 {
                        step -= 1
                    }
                } label: {
                    Text("이전")
                }
                .buttonStyle(AppButtonStyle(width: 80))
                Spacer()
                Button {
                    print("next")
                    step += 1
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

struct ImportPDFView_Previews: PreviewProvider {
    static var previews: some View {
        @State var isSheetActive = false
        @State var step = 0
        ImportPDFView(isSheetActive: $isSheetActive, step: $step)
    }
}
