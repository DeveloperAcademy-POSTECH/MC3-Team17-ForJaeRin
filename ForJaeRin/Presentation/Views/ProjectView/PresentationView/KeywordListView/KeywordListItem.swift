//
//  KeywordListItem.swift
//  ForJaeRin
//
//  Created by Yun Dongbeom on 2023/07/20.
//

import SwiftUI

struct KeywordListItem: View {
    
    @EnvironmentObject var vm: PresentationVM
    var pdfPage: PDFPage
    var sidebarWidth: CGFloat
    @State var alignedKeywords: [Keywords] = [[]]
    @State var keywordSizes: [CGSize]
    @State var index: Int
    var isSelected: Bool
    
    var body: some View {
        ZStack {
            ZStack {
                ForEach(enteredKeywords().indices, id: \.self) { count in
                    if enteredKeywords()[count] != "" {
                        Text(enteredKeywords()[count])
                            .foregroundColor(.clear)
                            .systemFont(.subTitle)
                            .padding(.vertical, 12)
                            .padding(.horizontal, 16)
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(.clear)
                                    .background(.clear)
                            )
                            .saveSize(in: $keywordSizes[count])
                    }
                }
            }
            VStack(spacing: 4) {
                ForEach(alignedKeywords, id: \.self) { keywords in
                    HStack(spacing: 0) {
                        ForEach(keywords, id: \.self) { keyword in
                            keywordView(keyword: keyword)
                        }
                    }.frame(maxWidth: sidebarWidth - 24)
                }
            }
        }.frame(
            maxWidth: sidebarWidth - 24,
            alignment: .center
        )
        .padding(.vertical, 24)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .foregroundColor(isSelected
                 ? Color.detailLayoutBackground
                 : Color.clear
            )
        )
        .onChange(of: keywordSizes) { _ in
            projectInit()
        }
    }
    
    private func enteredKeywords() -> [String] {
        var newKeywords: [String] = []
        for eachKeyword in pdfPage.keywords where eachKeyword != "" {
            newKeywords.append(eachKeyword)
        }
        return newKeywords
    }
    
    private func projectInit() {
        var width = 0.0
        var line = 0
        for _index in 0..<keywordSizes.count {
            if width + keywordSizes[_index].width > sidebarWidth - 24 {
                width = keywordSizes[_index].width
                line += 1
                alignedKeywords.append([])
            } else {
                width += keywordSizes[_index].width
            }
            alignedKeywords[line].append(enteredKeywords()[_index])
        }
    }
}

extension KeywordListItem {
    private func keywordView(keyword: String) -> some View {
        @State var springAnimation = false
        
        return Text(keyword)
            .padding(.vertical, 12)
            .padding(.horizontal, 16)
            .scaleEffect(vm.practice.saidKeywords[index].contains(keyword) ? 1.1 : 1)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.systemGray100, lineWidth: 2.5)
                    .background(isSelected
                                ? vm.practice.saidKeywords[index].contains(keyword)
                                ? Color.primary200 : .clear
                                : vm.practice.saidKeywords[index].contains(keyword)
                                ? Color.primary100 : .clear)
            )
            .foregroundColor(isSelected
                             ? Color.systemPrimary
                             : vm.practice.saidKeywords[index].contains(keyword)
                             ? Color.primary400 : Color.systemGray300)
            .systemFont(isSelected ? .subTitle : .caption1)
            .cornerRadius(5)
            .animation(.interpolatingSpring(stiffness: 170, damping: 8),
                       value: vm.practice.saidKeywords[index].contains(keyword))
    }
}
