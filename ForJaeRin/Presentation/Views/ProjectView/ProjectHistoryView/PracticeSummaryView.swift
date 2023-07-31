//
//  PracticeSummaryView.swift
//  ForJaeRin
//
//  Created by Yun Dongbeom on 2023/07/27.
//

import SwiftUI
import Pretendard

struct PracticeSummaryView: View {
    
    @ObservedObject var vm: ProjectHistoryVM
    @EnvironmentObject var projectFileManager: ProjectFileManager
    @State var slices: [(Double, Color)]
    @State var practiceTimeResults: [PracticeTimeResult] = []
    @State var maxTime = 0
    
    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 28) {
                keywordSuccessView()
                    .frame(maxWidth: (geometry.size.width - 28) * 0.37, maxHeight: .infinity)
                practiceTimeResultView()
                    .frame( maxWidth: .infinity, maxHeight: .infinity)
            }
            .frame(maxWidth: geometry.size.width, minHeight: 380, maxHeight: geometry.size.height)
        }
    }
}

extension PracticeSummaryView {
    private func keywordSuccessView() -> some View {
        VStack {
            VStack(alignment: .leading, spacing: 8) {
                Text("키워드 달성도")
                    .systemFont(.headline)
                Text("내가 설정한 키워드를 말한 횟수예요")
                    .systemFont(.body)
                    .foregroundColor(Color.systemGray400)
            }
            .frame(
                maxWidth: .infinity,
                alignment: .topLeading
            )
            ZStack {
                pieChartView()
                HStack(alignment: .lastTextBaseline, spacing: 0) {
                    Text("\(Int(slices[0].0))/\(Int(slices[1].0) + Int(slices[0].0))")
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
                    .systemFont(.body)
                    .foregroundColor(Color.systemGray400)
                    .padding(.bottom, 4)
                HStack(spacing: 10) {
                    ForEach(Array(practiceTimeResults.enumerated()), id: \.1.self) { index, info in
                        compareTimeGrpahView(practiceTimeResult: info, index: index)
                    }
                }
                .frame(
                    maxWidth: .infinity,
                    maxHeight: .infinity,
                    alignment: .center
                )
            }
            .frame(
                maxWidth: .infinity,
                maxHeight: .infinity,
                alignment: .topLeading
            )
        }
        .onAppear {
            gettingGroupSpeechTime()
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
            Text(vm.intToTime(second: practiceTimeResult.realTime
                              - practiceTimeResult.hopeTime))
                .font(practiceTimeResult.realTime > practiceTimeResult.hopeTime
                      ? Font.custom(Pretendard.semibold.fontName, size: 14)
                      : .systemCaption1)
                .foregroundColor(practiceTimeResult.realTime > practiceTimeResult.hopeTime
                                 ? Color.systemPrimary : Color.systemGray300)
                .bold(practiceTimeResult.realTime > practiceTimeResult.hopeTime)
                .padding(.bottom, 7)
            ZStack {
                // MARK: 배경
                RoundedRectangle(cornerRadius: 4)
                    .foregroundColor(
                        practiceTimeResult.realTime > practiceTimeResult.hopeTime
                        ? Color.primary100
                        : Color.clear
                    )
                    .cornerRadius(4)
                HStack(alignment: .bottom, spacing: 8) {
                    // MARK: 계획
                    RoundedCornerView(topLeft: 4, topRight: 4)
                        .foregroundColor(Color.systemGray200)
                        .frame(
                            minWidth: 4,
                            maxWidth: .infinity,
                            maxHeight: CGFloat(Double(practiceTimeResult.hopeTime)
                                            * Double(192) / Double(maxTime))
                    )
                    // MARK: 실제
                    RoundedCornerView(topLeft: 4, topRight: 4)
                        .foregroundColor(Color.systemPrimary)
                        .frame(
                            minWidth: 4,
                            maxWidth: .infinity,
                            maxHeight: CGFloat(Double(practiceTimeResult.realTime)
                                            * Double(192) / Double(maxTime))
                        )
                }
                .padding(.horizontal, 13)
                .frame(
                    maxWidth: .infinity,
                    maxHeight: .infinity,
                    alignment: .bottom
                )
            }
            .frame(maxHeight: 200)
            .padding(.bottom, 12)
            Text("\(practiceTimeResult.groupName)")
                .systemFont(.caption2)
                .foregroundColor(Color.systemGray300)
        }
        .frame(maxWidth: 76, maxHeight: .infinity)
    }
    
    private func gettingGroupSpeechTime() {
        for group in projectFileManager.pdfDocument!.PDFGroups {
            practiceTimeResults.append(
                PracticeTimeResult(groupName: group.name, hopeTime: group.setTime, realTime: 0)
            )
            if maxTime < group.setTime {
                maxTime = group.setTime
            }
        }
        for (index, speech) in projectFileManager.practices![vm.practiceIndex].speechRanges.enumerated() {
            var groupTime = 0
            if index == projectFileManager.practices![vm.practiceIndex].speechRanges.count - 1 {
                groupTime = projectFileManager.practices![vm.practiceIndex].progressTime
                - projectFileManager.practices![vm.practiceIndex].speechRanges[index].start
                practiceTimeResults[speech.group].realTime += groupTime
            } else {
                groupTime = projectFileManager.practices![vm.practiceIndex].speechRanges[index + 1].start
                - projectFileManager.practices![vm.practiceIndex].speechRanges[index].start
                practiceTimeResults[speech.group].realTime += groupTime
            }
            if maxTime < groupTime {
                maxTime = groupTime
            }
        }
        print(practiceTimeResults)
        print(maxTime)
    }
}
