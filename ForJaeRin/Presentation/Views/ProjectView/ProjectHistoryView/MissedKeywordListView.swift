//
//  MissedKeywordListView.swift
//  ForJaeRin
//
//  Created by Yun Dongbeom on 2023/07/27.
//

import SwiftUI

struct MissedKeywordListView: View {
    let groupKeyword1: [Keywords] = [["차이", "디테일"], ["디자이너", "개발자"], ["소통", "잘", "전달"]]
    let groupKeyword2: [Keywords] = [["소통", "방법"]]
    let groupKeyword3: [Keywords] = [["HIG", "타이포그래피짱짱맨안녕하세요반가워요짱짱"], ["가독성"], ["자동", "사이즈", "일관된", "개발자"]]
    let groupKeyword4: [Keywords] = [["스타일", "가이드", "폰트"], ["이름이어려워요", "컬러", "아이콘"]]
    let groupKeyword5: [Keywords] = [["프로토타입", "코멘트", "귀찮", "쉽게"]]
    let groupKeyword6: [Keywords] = [["스타일", "케이스", "지정", "편리", "효율적"], ["공유"]]
    let groupKeyword7: [Keywords] = [["결론적", "Xcode", "디테일"]]
    
    //[data 가져오기] 그룹 내 키워드들을 사용자가 말했는지 여부 (true : 키워드 말함, false : 말하지 못함)
    let groupKeyword1Feedback: [[Bool]] = [[true, true], [true, true], [false, false, true]]
    let groupKeyword2Feedback: [[Bool]] = [[false, true]]
    let groupKeyword3Feedback: [[Bool]] = [[true, false], [true], [true, false, true, true]]
    let groupKeyword4Feedback: [[Bool]] = [[true, true, true], [true, false, true]]
    let groupKeyword5Feedback: [[Bool]] = [[false, true, true, true]]
    let groupKeyword6Feedback: [[Bool]] = [[true, true, true, false, true], [true]]
    let groupKeyword7Feedback: [[Bool]] = [[true, false, true]]
    
    @State var groupKeywords: [[Keywords]] = []
    @State var groupKeywordFeedback: [[[Bool]]] = []
    
    var body: some View {
        VStack(spacing: 28) {
            Text("놓친 키워드 확인하기")
                .systemFont(.headline)
                .frame(maxWidth: .infinity, alignment: .topLeading)
            HStack(spacing: 12) {
                ForEach(Array(groupKeywords.enumerated()), id: \.1.self) { index, keywords in
                    keywordGroupList(keywordsList: keywords, index: index)
                }
            }
            .frame(maxHeight: .infinity, alignment: .top)
        }
        .frame(maxWidth: .infinity, alignment: .topLeading)
        .onAppear {
            groupKeywords = [
                groupKeyword1,
                groupKeyword2,
                groupKeyword3,
                groupKeyword4,
                groupKeyword5,
                groupKeyword6,
                groupKeyword7
            ]
            groupKeywordFeedback = [
                groupKeyword1Feedback,
                groupKeyword2Feedback,
                groupKeyword3Feedback,
                groupKeyword4Feedback,
                groupKeyword5Feedback,
                groupKeyword6Feedback,
                groupKeyword7Feedback
            ]
        }
    }
}

extension MissedKeywordListView {
    func keywordGroupList(keywordsList: [Keywords], index: Int) -> some View {
        VStack(spacing: 0) {
            Rectangle()
                .frame(height: 20)
                .foregroundColor(GroupColor.allCases[index].color)
            VStack(spacing: 0) {
                ForEach(Array(keywordsList.enumerated()), id:\.1.self) { _index, keywords in
                    VStack {
                        ForEach(Array(keywords.enumerated()), id: \.1.self) { __index, keyword in
                            Text(keyword)
                                .systemFont(.subTitle)
                                .multilineTextAlignment(.center)
                                .fixedSize(horizontal: false, vertical: true)
                                .padding(.vertical, 10)
                                .padding(.horizontal, 11)
                                .foregroundColor(
                                    groupKeywordFeedback[index][_index][__index]
                                         ? GroupColor.allCases[index].text
                                         : Color.systemGray400
                                )
                                .background(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(
                                            groupKeywordFeedback[index][_index][__index]
                                            ? GroupColor.allCases[index].text
                                            : Color.systemGray100,
                                            lineWidth: 1
                                        )
                                )
                                .cornerRadius(8)
                        }
                        if _index < (keywordsList.count-1) {
                            Rectangle()
                                .strokeBorder(style: StrokeStyle(lineWidth: 1, dash: [5]))
                                .foregroundColor(Color.systemGray200)
                                .frame(maxWidth: .infinity, maxHeight: 1)
                                .padding(.vertical, 8)
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .top)
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 6)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .foregroundColor(Color.systemWhite)
            )
            .cornerRadius(12)
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .cornerRadius(12)
    }
}

// struct MissedKeywordListView_Previews: PreviewProvider {
//    static var previews: some View {
//        MissedKeywordListView()
//    }
// }
