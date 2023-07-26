//
//  GroupView.swift
//  ForJaeRin
//
//  Created by Yun Dongbeom on 2023/07/26.
//

import SwiftUI

// MARK: - 그룹 한 눈에 보기
struct GroupView: View {
    
    let group: String
    //[data 가져오기] 그룹 내 키워드들 텍스트 가져와야 함
    let groupKeyword1: [String] = ["차이", "디테일", "디자이너", "개발자", "소통", "잘", "전달"]
    let groupKeyword2: [String] = ["소통", "방법"]
    let groupKeyword3: [String] = ["HIG", "타이포그래피짱짱맨안녕하세요반가워요짱짱", "가독성", "자동", "사이즈", "일관된", "개발자"]
    let groupKeyword4: [String] = ["스타일", "가이드", "폰트", "이름이어려워요", "컬러", "아이콘"]
    let groupKeyword5: [String] = ["프로토타입", "코멘트", "귀찮", "쉽게"]
    let groupKeyword6: [String] = ["스타일", "케이스", "지정", "편리", "효율적", "공유"]
    let groupKeyword7: [String] = ["결론적", "Xcode", "디테일"]
    
    //[data 가져오기] 그룹 내 키워드들을 사용자가 말했는지 여부 (true : 키워드 말함, false : 말하지 못함)
    let groupKeyword1Feedback: [Bool] = [true, true, true, true, false, false, true]
    let groupKeyword2Feedback: [Bool] = [false, true]
    let groupKeyword3Feedback: [Bool] = [true, false, true, true, false, true, true]
    let groupKeyword4Feedback: [Bool] = [true, true, true, true, false, true]
    let groupKeyword5Feedback: [Bool] = [false, true, true, true]
    let groupKeyword6Feedback: [Bool] = [true, true, true, false, true, true]
    let groupKeyword7Feedback: [Bool] = [true, false, true]
    
    func color(for group: String) -> Color {
        switch group {
        case "Group 1":
            return .groupPurple
        case "Group 2":
            return .groupYellow
        case "Group 3":
            return .groupGreen
        case "Group 4":
            return .groupPink
        case "Group 5":
            return .groupOrange
        case "Group 6":
            return .groupBlue
        case "Group 7":
            return .groupGray
        default:
            return .systemGray300
        }
    }
    
    func colortext(for group: String) -> Color {
        switch group {
        case "Group 1":
            return .groupPurpleText
        case "Group 2":
            return .groupYellowText
        case "Group 3":
            return .groupGreenText
        case "Group 4":
            return .groupPinkText
        case "Group 5":
            return .groupOrangeText
        case "Group 6":
            return .groupBlueText
        case "Group 7":
            return .groupGrayText
        default:
            return .systemGray500
        }
    }
    
    func grouptext(for group: String) -> [String] {
        switch group {
        case "Group 1":
            return groupKeyword1
        case "Group 2":
            return groupKeyword2
        case "Group 3":
            return groupKeyword3
        case "Group 4":
            return groupKeyword4
        case "Group 5":
            return groupKeyword5
        case "Group 6":
            return groupKeyword6
        case "Group 7":
            return groupKeyword7
        default:
            return []
        }
    }
    
    func groupKeywordCount(for group: String) -> Int {
        switch group {
        case "Group 1":
            return groupKeyword1.count
        case "Group 2":
            return groupKeyword2.count
        case "Group 3":
            return groupKeyword3.count
        case "Group 4":
            return groupKeyword4.count
        case "Group 5":
            return groupKeyword5.count
        case "Group 6":
            return groupKeyword6.count
        case "Group 7":
            return groupKeyword7.count
        default:
            return 0
        }
    }
    
    func groupKeywordFeedback (for group: String) -> [Bool] {
        switch group {
        case "Group 1":
            return groupKeyword1Feedback
        case "Group 2":
            return groupKeyword2Feedback
        case "Group 3":
            return groupKeyword3Feedback
        case "Group 4":
            return groupKeyword4Feedback
        case "Group 5":
            return groupKeyword5Feedback
        case "Group 6":
            return groupKeyword6Feedback
        case "Group 7":
            return groupKeyword7Feedback
        default:
            return []
        }
    }
    
    // 키워드 갯수에 따라 사각형의 높이를 계산하는 함수
    //if 페이지가 2장 이상일 경우에 구분선이 추가되는데, 위에서 계산한 minHeight에 32*(페이지 갯수-1)만큼 더해주면 될 듯. 그리고 구분선 추가
    func calculateRectangleHeight(keywordCount: Int) -> CGFloat {
        return CGFloat(20 + 8 + 40 * groupKeywordCount(for: group) + 8 * (groupKeywordCount(for: group)-1) + 8)
    }
    
    var body: some View {
        ZStack (alignment: .topLeading) {
            Rectangle()
                .cornerRadius(12)
                .frame(
                    minWidth: 160,
                    maxWidth: .infinity,
                    minHeight: calculateRectangleHeight(keywordCount: groupKeywordCount(for: group)),
                    maxHeight: calculateRectangleHeight(keywordCount: groupKeywordCount(for: group)))
                .foregroundColor(Color.systemWhite)
            VStack {
                ZStack(alignment: .bottom) {
                    Rectangle()
                        .cornerRadius(12)
                        .frame(minWidth: 160, maxWidth: .infinity, minHeight: 20, maxHeight: 20)
                        .foregroundColor(color(for: group))
                    
                    Rectangle()
                        .frame(minWidth: 160, maxWidth: .infinity, minHeight: 10, maxHeight: 10)
                        .foregroundColor(color(for: group))
                }
                
                //키워드 감싸는 사각형 (true면 기본 호출 & false면 피드백 호출)
                VStack (spacing: 8){
                    ForEach(Array(zip(grouptext(for: group), groupKeywordFeedback(for: group))), id: \.0) { keyword, feedback in
                        ZStack {
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(feedback ? Color.systemGray100 : colortext(for: group), lineWidth: 1)
                                .frame(minWidth: 20, maxWidth: .infinity, minHeight: 40, maxHeight: 40)
                                .background(Color.systemWhite)
                            VStack {
                                Text(keyword)
                                    .padding(.horizontal, 10)
                                    .frame(minWidth: 40, maxWidth: .infinity, minHeight: 40, maxHeight: 40)
                                    .foregroundColor(feedback ? Color.systemGray400 : colortext(for: group))
                                    .font(.systemSubtitle)
                            }
                        }
                        .padding(.horizontal, 6)
                    }
                    .fixedSize()
                }
                
            }
            .frame(minHeight: 80, maxHeight: .infinity)
        }
        .frame(maxHeight: .infinity)
    }
}
