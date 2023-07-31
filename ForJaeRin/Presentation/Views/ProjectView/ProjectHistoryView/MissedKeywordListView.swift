//
//  MissedKeywordListView.swift
//  ForJaeRin
//
//  Created by Yun Dongbeom on 2023/07/27.
//

import SwiftUI

struct MissedKeywordListView: View {
    @ObservedObject var vm = ProjectHistoryVM()
    @EnvironmentObject var projectFileManager: ProjectFileManager
    
    var body: some View {
        VStack(spacing: 28) {
            Text("말한 키워드 확인하기")
                .systemFont(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
            HStack(spacing: 12) {
                ForEach(
                    Array(projectFileManager.pdfDocument!.PDFGroups.enumerated()),
                    id: \.0.self) { index, group in
                    keywordGroupList(pageIndexes: gettingPageIndex(group: group), index: index)
                }.frame(maxHeight: .infinity)
            }
            .frame(maxHeight: .infinity, alignment: .top)
        }
        .frame(maxWidth: .infinity, alignment: .topLeading)
    }
}

extension MissedKeywordListView {
    func keywordGroupList(pageIndexes: [Int], index: Int) -> some View {
        VStack(spacing: 0) {
            Rectangle()
                .frame(height: 20)
                .foregroundColor(GroupColor.allCases[index].color)
            VStack(spacing: 8) {
                ForEach(pageIndexes, id: \.self) { pageIndex in
                    ForEach(
                        projectFileManager.pdfDocument!
                            .PDFPages[pageIndex].keywords, id: \.self
                    ) { keyword in
                        Text(keyword)
                            .systemFont(.subTitle)
                            .multilineTextAlignment(.center)
                            .foregroundColor(
                                projectFileManager.practices![vm.practiceIndex].saidKeywords[pageIndex].contains(keyword)
                                ? index == 0
                                ? Color.primary500
                                : index == 6
                                ? Color.point500
                                : GroupColor.allCases[index].text
                                : .systemGray400
                            )
                            .padding(.horizontal, 8)
                            .padding([.top, .bottom], 9.5)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .inset(by: 0.5)
                                    .stroke(
                                        projectFileManager.practices![vm.practiceIndex]
                                            .saidKeywords[pageIndex].contains(keyword)
                                        ? index == 6
                                        ? Color.point500
                                        : GroupColor.allCases[index].text
                                        : Color.systemGray100,
                                        lineWidth: 1)
                            )
                            .cornerRadius(8)
                    }
                    if pageIndex != pageIndexes.last! {
                        GeometryReader { geometry in
                            Path { path in
                                let startPoint = CGPoint(x: 0, y: geometry.size.height / 2)
                                let endPoint = CGPoint(x: geometry.size.width, y: geometry.size.height / 2)
                                path.move(to: startPoint)
                                path.addLine(to: endPoint)
                            }
                            .stroke(style: StrokeStyle(lineWidth: 1, dash: [4]))
                            .foregroundColor(.systemGray400)
                        }.frame(height: 16)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .top)
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 6)
            .background(
                Rectangle()
                    .foregroundColor(Color.systemWhite)
            )
        }
        .cornerRadius(12)
        .frame(maxHeight: .infinity, alignment: .top)
        .cornerRadius(12)
    }
    
    func gettingPageIndex(group: PDFGroup) -> [Int] {
        var answer: [Int] = []
        for pageNumber in group.range.start...group.range.end {
            answer.append(pageNumber)
        }
        return answer
    }
}
