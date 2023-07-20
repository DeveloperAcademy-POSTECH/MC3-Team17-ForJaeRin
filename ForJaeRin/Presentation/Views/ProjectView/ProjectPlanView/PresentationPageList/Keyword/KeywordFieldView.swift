//
//  KeywordFieldView.swift
//  ForJaeRin
//
//  Created by 이용준의 Macbook on 2023/07/20.
//

import SwiftUI

struct KeywordFieldView: View {
    @Binding var newKeyword: String
    @State var colorDeep = false
    @State var availableEdit = false
    @FocusState private var focusedField: Bool
    let FONT_STYLE = NSFont.systemFont(ofSize: 18, weight: .semibold)
    
    var body: some View {
        if availableEdit || newKeyword.isEmpty {
            TextField("키워드 입력", text: $newKeyword,
                      onEditingChanged: { isEditing in
                          if isEditing {
                              focusedField = true
                              availableEdit = true
                              colorDeep = true
                          } else {
                              print("지금 !")
                              colorDeep = false
                              availableEdit = false
                          }
            })
                .focused($focusedField)
                .textFieldStyle(PlainTextFieldStyle())
                .systemFont(.subTitle)
                .frame(
                    width: newKeyword == "" ?
                    "키워드 입력".widthOfString(fontStyle: FONT_STYLE) + 16 :
                        newKeyword.widthOfString(fontStyle: FONT_STYLE) + 16)
                .foregroundColor(Color(red: 0.54, green: 0.43, blue: 1))
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .inset(by: 0.5)
                        .stroke(!colorDeep ? Color.systemGray100 : Color.systemPrimary, lineWidth: 1)
                        .background(!colorDeep ? .clear : Color.primary100)
                )
                .onTapGesture(count: 1) {
                    print("텍스트필드")
                }
        } else {
            Text("\(newKeyword)")
                .systemFont(.subTitle)
                .foregroundColor(Color.systemPrimary)
                .padding(.horizontal, 24)
                .padding(.vertical, 12)
                .fixedSize()
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .inset(by: 0.5)
                        .stroke(!colorDeep ? Color.systemGray100 : Color.systemPrimary, lineWidth: 1)
                        .background(!colorDeep ? .clear : Color.primary100)
                )
                .onTapGesture(count: 2) {
                    focusedField = true
                    colorDeep = true
                    availableEdit = true
                }
                .onTapGesture(count: 1) {
                    print("텍스트")
                }
        }
    }
}
