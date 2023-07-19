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
                .font(.system(size: 18, weight: .semibold))
                .frame(
                    width: newKeyword == "" ?
                    "키워드 입력".widthOfString(fontStyle: NSFont.systemFont(ofSize: 18, weight: .semibold)) :
                        newKeyword.widthOfString(fontStyle: NSFont.systemFont(ofSize: 18, weight: .semibold)))
                .foregroundColor(Color(red: 0.54, green: 0.43, blue: 1))
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .inset(by: 0.5)
                        .stroke(!colorDeep ?
                            Color(red: 0.18, green: 0.18, blue: 0.18).opacity(0.1) :
                                    Color(red: 0.54, green: 0.43, blue: 1), lineWidth: 1)
                        .background(!colorDeep ? .clear : Color(red: 0.67, green: 0.62, blue: 1).opacity(0.1))
                )
                .onTapGesture(count: 1) {
                    print("텍스트필드")
                }
        } else {
            Text("\(newKeyword)")
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(Color(red: 0.54, green: 0.43, blue: 1))
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .inset(by: 0.5)
                        .stroke(!colorDeep ?
                            Color(red: 0.18, green: 0.18, blue: 0.18).opacity(0.1) :
                                    Color(red: 0.54, green: 0.43, blue: 1), lineWidth: 1)
                        .background(!colorDeep ? .clear : Color(red: 0.67, green: 0.62, blue: 1).opacity(0.1))
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

