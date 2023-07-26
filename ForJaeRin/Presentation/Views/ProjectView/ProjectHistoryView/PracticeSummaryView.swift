//
//  PracticeSummaryView.swift
//  ForJaeRin
//
//  Created by Yun Dongbeom on 2023/07/27.
//

import SwiftUI

struct PracticeSummaryView: View {
    @State var slices: [(Double, Color)]
    @State var selectedTimeInfoIndex = -1
    @State var practiceTimeResults: [PracticeTimeResult] = [
        PracticeTimeResult(groupName: "그룹 1", hopeTime: 80, realTime: 70),
        PracticeTimeResult(groupName: "그룹 2", hopeTime: 35, realTime: 50),
        PracticeTimeResult(groupName: "그룹 3", hopeTime: 70, realTime: 90),
        PracticeTimeResult(groupName: "그룹 3", hopeTime: 70, realTime: 90),
        PracticeTimeResult(groupName: "그룹 3", hopeTime: 70, realTime: 90),
        PracticeTimeResult(groupName: "그룹 3", hopeTime: 70, realTime: 90),
        PracticeTimeResult(groupName: "그룹 3", hopeTime: 70, realTime: 90)
    ]
    
    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 28) {
                keywordSuccessView()
                    .frame(maxWidth: geometry.size.width / 3 * 1 - 56, maxHeight: .infinity)
                    .border(.red, width: 2)
                practiceTimeResultView()
                    .frame( maxWidth: .infinity, maxHeight: .infinity)
                    .border(.red, width: 2)
            }
            .onAppear {
                print(geometry.size)
            }
            .padding(.bottom, 28)
            .frame(maxWidth: geometry.size.width, minHeight: 380, maxHeight: geometry.size.height)
            .border(.red, width: 2)
        }
    }
}

extension PracticeSummaryView {
    private func keywordSuccessView() -> some View {
        VStack {
            VStack(alignment: .leading, spacing: 8) {
                Text("키워드발화 달성도")
                    .systemFont(.headline)
                Text("내가 설정한 키워드를 말한 횟수예요")
                    .systemFont(.caption1)
                    .foregroundColor(Color.systemGray400)
            }
            .frame(
                maxWidth: .infinity,
                alignment: .topLeading
            )
            ZStack {
                pieChartView()
                HStack(alignment: .lastTextBaseline, spacing: 0) {
                    Text("23/34")
                        .systemFont(.headline)
                    Text("(개)")
                        .systemFont(.body)
                        .foregroundColor(Color.systemGray200)
                }
            }
            .padding(24)
            .frame(
                maxWidth: .infinity,
                maxHeight: .infinity
            )
        }
        .padding(28)
        .background(
            RoundedRectangle(cornerSize: CGSize(width: 12, height: 12))
                .fill(Color.systemWhite)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        )
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .cornerRadius(12)
    }
    
    private func pieChartView() -> some View {
        Canvas { context, size in
            // 도넛 모양
            let donut = Path { path in
                path.addEllipse(in: CGRect(origin: .zero, size: size))
                path.addEllipse(
                    in: CGRect(
                        x: size.width * 0.1,
                        y: size.height * 0.1,
                        width: size.width * 0.8,
                        height: size.height * 0.8
                    )
                )
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
                    path.addArc(
                        center: .zero,
                        radius: radius,
                        startAngle: startAngle + Angle(degrees: 0),
                        endAngle: endAngle,
                        clockwise: false
                    )
                    path.closeSubpath()
                }
                pieContext.fill(path, with: .color(color))
                startAngle = endAngle
            }
        }
        .aspectRatio(1, contentMode: .fit)
    }
    
    private func practiceTimeResultView() -> some View {
        VStack {
            VStack(alignment: .leading, spacing: 8) {
                Text("연습 소요시간")
                    .systemFont(.headline)
                Text("설정한 시간 대비 실제 연습시간이에요")
                    .systemFont(.caption1)
                    .foregroundColor(Color.systemGray400)
                HStack(spacing: 10) {
                    ForEach(Array(practiceTimeResults.enumerated()), id: \.1.self) { index, info in
                        compareTimeGrpahView(practiceTimeResult: info, index: index)
                    }
                }
                .frame(
                    maxWidth: .infinity,
                    maxHeight: .infinity
                )
            }
            .frame(
                maxWidth: .infinity,
                maxHeight: .infinity,
                alignment: .topLeading
            )
        }
        .padding(28)
        .background(
            RoundedRectangle(cornerSize: CGSize(width: 12, height: 12))
                .fill(Color.systemWhite)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        )
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity,
            alignment: .topLeading
        )
        .cornerRadius(12)
    }
    
    private func compareTimeGrpahView(practiceTimeResult: PracticeTimeResult, index: Int) -> some View {
        VStack(spacing: 0) {
            Text((practiceTimeResult.hopeTime - practiceTimeResult.realTime).description)
                .systemFont(.caption1)
                .foregroundColor(Color.systemPrimary)
                .bold(selectedTimeInfoIndex == index)
                .padding(.bottom, 8)
            ZStack {
                // MARK: 배경
                RoundedRectangle(cornerRadius: 4)
                    .foregroundColor(Color.primary100)
                    .cornerRadius(4)
                HStack(alignment: .bottom) {
                    // MARK: 계획
                    RoundedCornerView(topLeft: 4, topRight: 4)
                        .foregroundColor(Color.systemGray200)
                        .frame(
                            minWidth: 4,
                            maxWidth: .infinity,
                            maxHeight: CGFloat(practiceTimeResult.hopeTime
                        )
                    )
                    // MARK: 실젠
                    RoundedCornerView(topLeft: 4, topRight: 4)
                        .foregroundColor(Color.systemPrimary)
                        .frame(
                            minWidth: 4,
                            maxWidth: .infinity,
                            maxHeight: CGFloat(practiceTimeResult.realTime)
                        )
                }
                .padding(.top, 8)
                .padding(.horizontal, 16)
                .frame(
                    maxWidth: .infinity,
                    maxHeight: .infinity,
                    alignment: .bottom
                )
            }
            .frame(maxWidth: 76)
            Text("\(practiceTimeResult.groupName)")
                .systemFont(.caption2)
                .foregroundColor(Color.systemGray300)
                .padding(.top, 12)
        }
    }
}

struct PracticeTimeResult: Hashable {
    var groupName: String
    var hopeTime: Int
    var realTime: Int
}

// struct PracticeSummaryView_Previews: PreviewProvider {
//    static var previews: some View {
//        PracticeSummaryView()
//    }
// }
