//
//  KeywordFieldView.swift
//  ForJaeRin
//
//  Created by 이용준의 Macbook on 2023/07/20.
//

import SwiftUI

struct KeywordFieldView: View {
    
    @EnvironmentObject var myData: MyData
    /// 텍스트필드의 키워드 전달
    @Binding var newKeyword: String
    /// 찐한 색 !
    @State var colorDeep = false
    /// focus 조절
    @FocusState var focusField: Int?
    /// 해당 키워드의 인덱스
    var index: Int
    var pageIndex: Int
    @Binding var lastIndexes: [Int]
    
    @Binding var clickedKeywordIndex: Int?
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack(alignment: .topTrailing) {
                TextField("키워드 입력", text: $newKeyword)
                    .focused($focusField, equals: 7 * pageIndex + index)
                .fixedSize()
                .textFieldStyle(PlainTextFieldStyle())
                .systemFont(.subTitle)
                .foregroundColor(.primary500)
                .padding(.leading, 16)
                .padding(.trailing, 12.5)
                .padding(.vertical, 12)
                .background(
                    RoundedRectangle(cornerRadius: 5)
                        .inset(by: 0.5)
                        .stroke(
                            $focusField.wrappedValue == 7 * pageIndex + index
                            || clickedKeywordIndex == 7 * pageIndex + index
                            ? Color.systemPrimary
                            : Color.systemGray100, lineWidth: 1)
                        .background(
                            $focusField.wrappedValue == 7 * pageIndex + index
                            || clickedKeywordIndex == 7 * pageIndex + index
                            ? Color.primary100
                            : Color(white: 0.5, opacity: 0.0001))
                        .onTapGesture {
                            $focusField.wrappedValue = nil
                            clickedKeywordIndex = 7 * pageIndex + index
                        }
                )
                .onSubmit {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                        focusField = nil
                    }
                }
                if clickedKeywordIndex == 7 * pageIndex + index {
                    Button {
                        if clickedKeywordIndex != nil {
                            deleteKeyword(index: clickedKeywordIndex!)
                            clickedKeywordIndex = nil
                        }
                    } label: {
                        Image("DeleteKey")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20)
                    }.buttonStyle(.plain)
                        .offset(x: 10, y: -10)
                }
            }
        }
    }
    
    private func deleteKeyword(index: Int) {
        withAnimation {
            myData.keywords[index / 7].remove(at: Int(index % 7))
            myData.keywords[index / 7].append("")
            if lastIndexes[index / 7] != 0 {
                lastIndexes[index / 7] -= 1
            }
        }
    }
}
