//
//  ProjectSummaryView.swift
//  ForJaeRin
//
//  Created by Yun Dongbeom on 2023/07/12.
//

import Charts
import SwiftUI

/*
 어떤 결과를 요약해서 보여줄 것인지, 정보 확인이 필요합니다.
 */
// MARK: - 프로젝트 연습 결과 요약 뷰
struct ProjectSummaryView: View {
    
    let data = [
        //[data 가져오기] 내가 말한 키워드 횟수
        (23.0, Color.primary500),
        //[data 가져오기] 말하지 못한 키워드 횟수 = 전체 키워드 갯수 - 내가 말한 키워드 횟수
        (11.0, Color.systemGray100),
    ]
    let groupName: [String] = ["Group 1", "Group 2", "Group 3", "Group 4", "Group 5", "Group 6", "Group 7"]
    //[data 가져오기] 그룹 갯수(0 포함이 되어 있어서 실제로 입력한 갯수+1로 들어감)
    var groupCount:Int = 6
    
    var body: some View {
        ZStack {
            Color.detailLayoutBackground
            GeometryReader { geometry in
                ScrollView {
                    VStack(spacing: 0) {
                        //MARK: 타이틀
                        VStack {
                            Text("첫번째 발표연습 기록")
                                .systemFont(.headline)
                                .padding(.top, 52)
                                .padding(.horizontal, 72)
                        }
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                        HStack(spacing: 28) {
                            //MARK: 키워드
                            ZStack (alignment: .topLeading){
                                Rectangle()
                                    .cornerRadius(10)
//                                    .frame(width: 432, height: 380)
                                    .frame(minWidth: 432, maxWidth: .infinity)
                                    .foregroundColor(Color.systemWhite)
                                
                                VStack (spacing: 42){
                                    Group{
                                        VStack (alignment: .leading, spacing: 8) {
                                            Text("키워드")
                                                .systemFont(.headline)
                                            Text("나의 키워드를 말한 횟수예요")
                                                .systemFont(.caption1)
                                                .foregroundColor(Color.systemGray400)
                                        }
                                        .padding(.top, 26)
                                        .padding(.leading, 26)
                                    }
                                    
                                    ZStack{
                                        PieChart(slices : data)
                                            .foregroundColor(Color.primary500)
                                            .frame(width: 200, height: 200)
                                        
                                        HStack (alignment: .bottom){
                                            //[data 가져오기] 내가 말한 키워드 횟수/전체 키워드 갯수
                                            Text("23/34")
                                                .systemFont(.headline)
                                                .foregroundColor(Color.systemGray500)
                                            Text("(개)")
                                                .systemFont(.body)
                                                .foregroundColor(Color.systemGray200)
                                                .padding(.leading, -8)
                                        }
                                    }
                                    .offset(x: 116, y: 0)
                                }
                            }
                            .frame(minWidth: 432, maxWidth: .infinity)
                            .border(.indigo, width: 2)
                            //연습 소요시간
                            ZStack (alignment: .topLeading){
                                Rectangle()
                                    .cornerRadius(10)
                                    .frame(maxWidth: (geometry.size.width - 144) / 3 * 2)
                                    .foregroundColor(Color.systemWhite)
                                HStack {
                                    VStack (alignment: .leading, spacing: 8) {
                                        Text("연습 소요시간")
                                            .systemFont(.headline)
                                        Text("설정한 시간 대비 실제 연습시간이에요")
                                            .systemFont(.caption1)
                                            .foregroundColor(Color.systemGray400)
                                    }
                                    .padding(.top, 26)
                                    .padding(.leading, 26)
                                    .padding(.trailing, 375)
                                    
                                    VStack (alignment: .trailing, spacing: 4)  {
                                        HStack {
                                            Rectangle()
                                                .cornerRadius(6)
                                                .frame(width: 19, height: 19)
                                                .foregroundColor(Color.systemGray200)
                                            
                                            Text("목표 시간")
                                                .systemFont(.caption1)
                                                .foregroundColor(Color.systemGray500)
                                        }
                                        
                                        HStack {
                                            Rectangle()
                                                .cornerRadius(6)
                                                .frame(width: 19, height: 19)
                                                .foregroundColor(Color.systemPrimary)
                                            
                                            Text("소요 시간")
                                                .systemFont(.caption1)
                                            .foregroundColor(Color.systemGray500)                            }
                                    }
                                    .padding(.top, 38)
                                    .padding(.leading, 10)
                                }
                                HStack (alignment: .center) {
                                    //[data 가져오기]
                                    //사용자가 설정한 그룹 발표 시간 중 가장 최대값 : maxTime
                                    //y에 사용자가 설정한 그룹 발표 시간 : hopeTime
                                    //y에 들어갈 수식(goalGraph) : 200*(hopeTime/(maxTime+(maxTime*1/4)))
                                    //y에 사용자가 실제로 말한 그룹 발표 시간 : realTime
                                    
                                    Group {
                                        //[data 가져오기] 그룹명 가져오기, realGroup&maxTime&hopeTime&realTime 값 가져오기
                                        GroupChartView(
                                            groupName: "그룹 1",
                                            realGroup: 1,
                                            maxTime: 80,
                                            hopeTime: 60,
                                            realTime: 70
                                        )
                                        GroupChartView(
                                            groupName: "그룹 2",
                                            realGroup: -1,
                                            maxTime: 80,
                                            hopeTime: 70,
                                            realTime: 50
                                        )
                                        GroupChartView(
                                            groupName: "그룹 3",
                                            realGroup: 0,
                                            maxTime: 80,
                                            hopeTime: 35,
                                            realTime: 35
                                        )
                                        GroupChartView(
                                            groupName: "그룹 4",
                                            realGroup: 1,
                                            maxTime: 80,
                                            hopeTime: 80,
                                            realTime: 90
                                        )
                                        GroupChartView(
                                            groupName: "그룹 5",
                                            realGroup: 0,
                                            maxTime: 80,
                                            hopeTime: 70,
                                            realTime: 70
                                        )
                                    }
                                }
                                .border(.indigo, width: 2)
                                .padding(.top, 100)
                            }
                            .border(.indigo, width: 2)
                            .frame(maxWidth: geometry.size.width / 3 * 2)
                        }
                        .padding(.top, 80)
                        .padding(.horizontal, 72)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .border(.mint, width: 2)
                        //MARK: 구간 별 다시듣기
                        
                        //MARK: 한 눈에 보기
                            VStack {
                                    HStack (spacing: 12){
                                        ForEach(0...groupCount, id: \.self) { value in
                                            GroupView(group: groupName[value])
                                                .frame(maxHeight: .infinity, alignment: .topLeading)
                                        }
                                    }
                                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                                    .padding(.bottom, 52)
                                    .padding(.top, 56)
                                }
                            .frame(maxWidth: .infinity, maxHeight: 800, alignment: .topLeading)
                            .border(.indigo, width: 2)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                }
                .frame(maxWidth: geometry.size.width, maxHeight: geometry.size.height, alignment: .topLeading)
                .onAppear {
                    print(geometry.size)
                }
                .border(.red, width: 2)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .border(.green, width: 2)
    }
}




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

// MARK: - 그룹 차트
struct GroupChartView: View {
    var groupName: String
    var realGroup: Int
    
    var maxTime: Int
    var hopeTime: Int
    var realTime: Int
    
    var body: some View {
        Group {
            VStack (spacing: 0){
                HStack (spacing: 0){
                    
                    if realGroup > 0
                    {
                        Image(systemName: "plus")
                            .frame(width: 16, height: 16)
                            .padding(.trailing, 2)
                            .foregroundColor(Color.systemPrimary)
                        
                        //임의로 적어둔"01:00" 부분에 RealGroup 변수 값이 들어가야 할 듯
                        Text("01:00")
                            .systemFont(.caption1)
                            .foregroundColor(Color.systemPrimary)
                    } else if realGroup < 0 {
                        Image(systemName: "minus")
                            .frame(width: 16, height: 16)
                            .padding(.trailing, 2)
                            .foregroundColor(Color.systemGray200)
                        
                        //임의로 적어둔 "00:20" 부분에 RealGroup 변수 값이 들어가야 할 듯
                        Text("00:20")
                            .systemFont(.caption1)
                            .foregroundColor(Color.systemGray200)
                    } else {
                    //임의로 적어둔 "00:00" 부분에 RealGroup 변수 값이 들어가야 할 듯
                    Text("00:00")
                        .systemFont(.caption1)
                        .foregroundColor(Color.systemGray200)
                    }
                }
                
                if realGroup > 0
                {
                    ZStack{
                        Rectangle()
                            .frame(width: 78, height: 219)
                            .foregroundColor(Color.primary100)
                            .cornerRadius(6)
                            .opacity(100)
                            .padding(.top, 8)
                            .padding(.bottom, 5)
                        
                        StyleDetailsChart(maxTime: maxTime, hopeTime: hopeTime, realTime: realTime)
                    }
                } else {
                    ZStack{
                        Rectangle()
                            .frame(width: 78, height: 219)
                            .foregroundColor(Color.primary100)
                            .cornerRadius(6)
                            .opacity(0)
                            .padding(.top, 8)
                            .padding(.bottom, 5)
                        
                        StyleDetailsChart(maxTime: maxTime, hopeTime: hopeTime, realTime: realTime)
                    }
                }
                
                if realGroup > 0
                {
                    Text(groupName)
                        .systemFont(.caption2)
                        .foregroundColor(Color.systemGray500)
                } else {
                    Text(groupName)
                        .systemFont(.caption2)
                        .foregroundColor(Color.systemGray300)
                }
            }
        }
    }
}


// MARK: - 막대 그래프

struct StyleDetailsChart: View {
    var maxTime: Int
    var hopeTime: Int
    var realTime: Int

    var body: some View {
        HStack {
            VStack {
                
                CustomBarChart1(data: [
                    //[data 가져오기]
                    //사용자가 설정한 그룹 발표 시간 중 가장 최대값 : maxTime
                    //y에 사용자가 설정한 그룹 발표 시간 : hopeTime
                    //y에 들어갈 수식(goalGraph) : 200*(hopeTime/(maxTime+(maxTime*1/4)))
                    (x: "Cachapa", y: Int(Double(200) * (Double(hopeTime) / (Double(maxTime) + (Double(maxTime) * 0.15)))))
                ])
            }
            .frame(width: 18, height: 200, alignment: .bottom)
            
            VStack {
                CustomBarChart2(data: [
                    //[data 가져오기]
                    //y에 사용자가 실제로 말한 그룹 발표 시간 : realTime
                    //y에 들어갈 수식(realGraph) : hopeTime-realTime
                    (x: "Cachapa", y: Int(Double(200) * (Double(realTime) / (Double(maxTime) + (Double(maxTime) * 0.15)))))
                ])
            }
            .frame(width: 18, height: 200, alignment: .bottom)
        }
    }
}

struct CustomBarChart1: View {
    let data: [(x: String, y: Int)]
    
    var body: some View {
        ZStack (alignment: .bottomLeading) {
            Rectangle()
                .frame(width: 18, height: CGFloat(data[0].y))
                //오퍼시티 없는 색 버전으로 수정 필요
                .foregroundColor(Color.systemGray200)
                .cornerRadius(6)
            Rectangle()
                .frame(width: 18, height: 6)
                //오퍼시티 없는 색 버전으로 수정 필요
                .foregroundColor(Color.systemGray200)
            ForEach(data, id: \.x) { datum in
            }
        }
    }
}

struct CustomBarChart2: View {
    let data: [(x: String, y: Int)]
    
    var body: some View {
        ZStack (alignment: .bottomLeading) {
            Rectangle()
                .frame(width: 18, height: CGFloat(data[0].y))
                .foregroundColor(Color.systemPrimary)
                .cornerRadius(6)
            Rectangle()
                .frame(width: 18, height: 6)
                .foregroundColor(Color.systemPrimary)
            ForEach(data, id: \.x) { datum in
            }
        }
    }
}

// MARK: - 원 그래프

struct PieChart: View {
    @State var slices: [(Double, Color)]
    
    var body: some View {
        Canvas { context, size in
            //도넛 모양
            let donut = Path { path in
                path.addEllipse(in: CGRect(origin: .zero, size: size))
                path.addEllipse(in: CGRect(x: size.width * 0.1, y: size.height * 0.1, width: size.width * 0.8, height: size.height * 0.8))
            }
            context.clip(to: donut, style: .init(eoFill: true))
            
            let total = slices.reduce(0) { $0 + $1.0 }
            context.translateBy(x: size.width * 0.5, y: size.height * 0.5)
            var pieContext = context
            pieContext.rotate(by: .degrees(-90))
            let radius = min(size.width, size.height)

            var startAngle = Angle.zero
            for (value, color) in slices {
                let angle = Angle(degrees: 360 * (value / total))
                let endAngle = startAngle + angle
                let path = Path { path in
                    path.move(to: .zero)
                    path.addArc(center: .zero, radius: radius, startAngle: startAngle + Angle(degrees: 0), endAngle: endAngle, clockwise: false)
                    path.closeSubpath()
                }
                pieContext.fill(path, with: .color(color))
                startAngle = endAngle
            }
        }
        .aspectRatio(1, contentMode: .fit)
    }
}

struct ProjectSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectSummaryView()
    }
}
