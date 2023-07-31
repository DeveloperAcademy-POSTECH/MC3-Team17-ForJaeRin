//
//  KeywordView.swift
//  ForJaeRin
//
//  Created by 이용준의 Macbook on 2023/07/20.
//

import SwiftUI

struct KeywordView: View {
    let containerWidth: CGFloat
    @EnvironmentObject var myData: MyData
    @State var pageNumber: Int
    @Binding var lastIndexes: [Int]
    @Binding var currentHeight: CGFloat
    
    @FocusState var focusField: Int?
    @Binding var clickedKeywordIndex: Int?
    
    var body: some View {
        var width = 0.0
        var height = 0.0
        return ZStack(alignment: .topLeading) {
            ForEach(myData.keywords[pageNumber].indices, id: \.self) { keywordIndex in
                if keywordIndex <= lastIndexes[pageNumber] {
                    KeywordFieldView(
                        newKeyword: $myData.keywords[pageNumber][keywordIndex],
                        focusField: _focusField,
                        index: keywordIndex,
                        pageIndex: pageNumber,
                        clickedKeywordIndex: $clickedKeywordIndex
                    )
                        .alignmentGuide(.leading) { item in
                            if abs(width - item.width) > containerWidth {
                                width = 0.0; height -= item.height + 16
                            }
                            let result = width
                            if lastIndexes[pageNumber] == 6
                                && keywordIndex == lastIndexes[pageNumber] {
                                width = 0
                            } else {
                                width -= item.width
                            }
                            return result
                        }
                        .alignmentGuide(.top) { _ in
                            let result = height
                            if lastIndexes[pageNumber] == 6
                                && keywordIndex == lastIndexes[pageNumber] {
                                height = 0
                            }
                            return result
                        }
                }
            }
            if lastIndexes[pageNumber] < 6 {
                Button(action: {
                    lastIndexes[pageNumber] += 1
                    focusField = 7 * pageNumber + lastIndexes[pageNumber]
                }, label: {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .foregroundColor(.primary400)
                        .frame(width: 20, height: 20)
                        .frame(width: 45, height: 45)
                })
                .buttonStyle(.plain)
                .alignmentGuide(.leading) { item in
                    if abs(width - item.width) > 407 {
                        width = 0.0; height -= item.height + 16
                    }
                    let result = width
                    width = 0
                    return result
                }
                .alignmentGuide(.top) { _ in
                    let result = height
                        height = 0
                    return result
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .onAppear {
            resetKeywords()
        }
        .background(Color(white: 0.5, opacity: 0.0001))
            .onTapGesture {
                focusField = nil
                clickedKeywordIndex = nil
            }
    }
    private func resetKeywords() {
        let tempList = myData.keywords[pageNumber]
        myData.keywords[pageNumber] = []
        for index in 0..<7 where tempList[index] != "" {
            myData.keywords[pageNumber].append(tempList[index])
        }
        for _ in myData.keywords[pageNumber].count..<7 {
            myData.keywords[pageNumber].append("")
        }
    }
}
