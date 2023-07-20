//
//  KeywordListItem.swift
//  ForJaeRin
//
//  Created by Yun Dongbeom on 2023/07/20.
//

import SwiftUI

struct KeywordListItem: View {
    var pdfPage: PDFPage
    let FONT_STYLE = NSFont.systemFont(ofSize: 18, weight: .semibold)
    var sidebarWidth: CGFloat
    @State var alignedKeywords: [Keywords] = []
    @State var keywordSizes: [CGFloat] = []
    var isSelected: Bool
    
    var body: some View {
            VStack(spacing: 12) {
                ForEach(alignedKeywords, id: \.self) { keywords in
                    HStack(spacing: 0) {
                        ForEach(keywords, id: \.self) { keyword in
                            keywordView(keyword: keyword)
                        }
                    }
                    .frame(maxWidth: sidebarWidth - 24)
                }
            }
            .frame(
                maxWidth: sidebarWidth - 24,
                alignment: .center
            )
            .padding(.vertical, 24)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(isSelected
                     ? Color.detailLayoutBackground
                     : Color.clear
                )
            )
            .onAppear {
                projectInit()
            }
    }
    private func projectInit() {
        var line = 0
        var prevSize: CGFloat = 0
        pdfPage.keywords.forEach { keyword in
            let size = keyword.widthOfString(fontStyle: FONT_STYLE) + 32
            prevSize += size
            if prevSize >= sidebarWidth {
                prevSize = 0
                line += 1
                alignedKeywords.append([])
                alignedKeywords[line].append(keyword)
            } else if prevSize <= sidebarWidth - 48 {
                if alignedKeywords.isEmpty {
                    alignedKeywords.append([])
                    alignedKeywords[line].append(keyword)
                } else {
                    alignedKeywords[line].append(keyword)
                }
            }
        }
    }
}

extension KeywordListItem {
    private func keywordView(keyword: String) -> some View {
        let fontStyle = isSelected
        ? FONT_STYLE
        : NSFont.systemFont(ofSize: 14, weight: .regular)
        
        return Text(keyword)
            .padding(.vertical, 12)
            .padding(.horizontal, 16)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.systemGray100, lineWidth: 1)
                    .background(.clear)
                    .frame(width: keyword.widthOfString(fontStyle: fontStyle) + 32)
            )
            .foregroundColor(isSelected ? Color.systemPrimary : Color.systemGray300
            )
            .systemFont(isSelected ? .subTitle : .caption1)
            .frame(width: keyword.widthOfString(fontStyle: fontStyle) + 32)
    }
}

struct KeywordListItem_Previews: PreviewProvider {
    static var previews: some View {
        @State var isSelected = true
        let pdfPage = PDFPage(keywords: ["HIG", "타이포그래피", "가독성", "자동", "사이즈", "일관된", "개발자"], script: "안중요하죠?")
        
        KeywordListItem(pdfPage: pdfPage, sidebarWidth: 302, isSelected: isSelected)
    }
}
