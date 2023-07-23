//
//   ProjectFlowView.swift
//  ForJaeRin
//
//  Created by 박보경 on 2023/07/20.
//
import SwiftUI

struct CustomDashLine: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let dashes: [CGFloat] = [6, 3] // 각 점선과 공백의 길이
        path.addRect(CGRect(x: 0, y: rect.height / 2, width: rect.width, height: 0)) // 보이지 않는 선을 그려서 점선 스타일을 적용
        return path
            .strokedPath(StrokeStyle(lineWidth: 1, dash: dashes, dashPhase: 0)) // 보이지 않는 선에 점선 스타일을 적용
    }
}

struct CustomRoundedRectangle: Shape {
    var cornerRadius: CGFloat
    var isFirstRectangle: Bool
    var isLastRectangle: Bool

    func path(in rect: CGRect) -> Path {
        var path = Path()

        let minX = rect.minX
        let minY = rect.minY
        let maxX = rect.maxX
        let maxY = rect.maxY

        path.move(to: CGPoint(x: minX + (isFirstRectangle ? cornerRadius : 0), y: minY))
        path.addLine(to: CGPoint(x: maxX - (isLastRectangle ? cornerRadius : 0), y: minY))
        path.addArc(center: CGPoint(x: maxX - (isLastRectangle ? cornerRadius : 0), y: minY + (isLastRectangle ? cornerRadius : 0)), radius: isLastRectangle ? cornerRadius : 0, startAngle: Angle.degrees(270), endAngle: Angle.degrees(0), clockwise: false)
        path.addLine(to: CGPoint(x: maxX, y: maxY - (isLastRectangle ? cornerRadius : 0)))
        path.addArc(center: CGPoint(x: maxX - (isLastRectangle ? cornerRadius : 0), y: maxY - (isLastRectangle ? cornerRadius : 0)), radius: isLastRectangle ? cornerRadius : 0, startAngle: Angle.degrees(0), endAngle: Angle.degrees(90), clockwise: false)
        path.addLine(to: CGPoint(x: minX + (isFirstRectangle ? cornerRadius : 0), y: maxY))
        path.addArc(center: CGPoint(x: minX + (isFirstRectangle ? cornerRadius : 0), y: maxY - (isFirstRectangle ? cornerRadius : 0)), radius: isFirstRectangle ? cornerRadius : 0, startAngle: Angle.degrees(90), endAngle: Angle.degrees(180), clockwise: false)
        path.addLine(to: CGPoint(x: minX, y: minY + (isFirstRectangle ? cornerRadius : 0)))
        path.addArc(center: CGPoint(x: minX + (isFirstRectangle ? cornerRadius : 0), y: minY + (isFirstRectangle ? cornerRadius : 0)), radius: isFirstRectangle ? cornerRadius : 0, startAngle: Angle.degrees(180), endAngle: Angle.degrees(270), clockwise: false)
        path.closeSubpath()

        return path
    }
}



struct GraphGroupView: View {
    @Binding var selectedRectangleIndex: Int?

    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<7, id: \.self) { index in
                let cornerRadius: CGFloat = (index == 0 || index == 6) ? 8 : 0
                let isFirstRectangle = index == 0
                let isLastRectangle = index == 6
                CustomRoundedRectangle(cornerRadius: cornerRadius, isFirstRectangle: isFirstRectangle, isLastRectangle: isLastRectangle)
                    .frame(width: 180, height: 40)
                    .foregroundColor(getColor(for: index))
                    .opacity(selectedRectangleIndex == index ? 1 : 0.3)
                    .overlay(selectedRectangleIndex == index ? getImage(for: index) : nil)
                    .onTapGesture {
                        if selectedRectangleIndex != index {
                            selectedRectangleIndex = index
                        }
                    }
            }
        }
    }

    func getColor(for index: Int) -> Color {
        switch index {
        case 0:
            return .groupPurple
        case 1:
            return .groupYellow
        case 2:
            return .groupGreen
        case 3:
            return .groupPink
        case 4:
            return .groupOrange
        case 5:
            return .groupBlue
        case 6:
            return .groupGray
        default:
            return .groupPurple
        }
    }

    func getIconColor(for index: Int) -> Color {
        switch index {
        case 0:
            return .groupPurpleText
        case 1:
            return .groupYellowText
        case 2:
            return .groupGreenText
        case 3:
            return .groupPinkText
        case 4:
            return .groupOrangeText
        case 5:
            return .groupBlueText
        case 6:
            return .groupGrayText
        default:
            return .groupPurpleText
        }
    }

    func getImage(for index: Int) -> some View {
        let symbolName = "checkmark.circle.fill" // 사용할 SF Symbol 이름을 변경하시면 됩니다.
        let symbolColor = getIconColor(for: index)

        return Image(systemName: symbolName)
            .foregroundColor(symbolColor)
    }
}



struct ProjectFlowView: View {
    @State private var selectedRectangleIndex: Int? = 0
    @State private var rowCount: Int = 15
    @State private var groupNames: [String] = ["그룹1", "그룹2", "그룹3", "그룹4", "그룹5", "그룹6", "그룹7"]
    let texts: [String] = ["차이", "개발자", "안녕하세요", "디자이너", "충전기", "어쩌라고", "반가워요"]

    var body: some View {
        ZStack(alignment: .leading) {
            Color.detailLayoutBackground
            VStack(spacing: 36) {
                Spacer()
                ZStack(alignment: .center) {
                    Rectangle()
                        .foregroundColor(.systemWhite)
                        .cornerRadius(12)
                    VStack(alignment: .leading, spacing: 8) {
                        Text("그룹 별 키워드 확인하기")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.systemGray500)
                        Text("원하는 그룹을 클릭하면 키워드를 확인할 수 있어요 ")
                            .font(.system(size: 14, weight: .regular))
                            .foregroundColor(.systemGray300)
                            .padding(.bottom, 28)
                        GraphGroupView(selectedRectangleIndex: $selectedRectangleIndex)
                        HStack(spacing: 148) {
                            ForEach(groupNames, id: \.self) { groupName in
                                Text(groupName)
                                    .systemFont(.caption2)
                                    .foregroundColor(.systemGray300)
                            }
                        }
                        .padding(.leading, 70)
                    }
                }
                .frame(width: 1320, height: 244)
                .padding(.horizontal, 36)
                .padding(.bottom, 10)
                VStack {
                    Rectangle()
                        .frame(width: 1320, height: 20)
                        .foregroundColor(selectedRectangleIndex != nil ? getColor(for: selectedRectangleIndex!) : .groupPurple)
                        .alignmentGuide(.top) { _ in 0 }
                    ScrollView {
                        VStack(spacing: 0) {
                            ForEach(0..<rowCount, id: \.self) { index in
                                VStack(spacing: 0) {
                                    HStack(spacing: 20) {
                                        Text("\(index + 1)")
                                            .foregroundColor(.systemGray400)
                                            .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                                        ForEach(texts, id: \.self) { text in
                                            Text(text)
                                                .systemFont(.subTitle)
                                                .foregroundColor(.systemGray400)
                                                .padding(.vertical, 20)
                                                .padding(.horizontal, 50)
                                                .background(RoundedRectangle(cornerRadius: 4).stroke())
                                        }
                                    }
                                    .frame(width: 1300, height: 108, alignment: .leading)
                                    .background(Color.clear)
                                    if index < rowCount - 1 {
                                        CustomDashLine()
                                            .frame(height: 1)
                                            .foregroundColor(.systemGray200)
                                            .padding(.horizontal, 8)
                                    }
                                }
                            }
                        }
                    }
                }
                .frame(width: 1320)
                .border(.red, width: 2)
                .background(Color.systemWhite)
                .cornerRadius(20)
                Spacer()
            }
//            .padding(.horizontal, 96)
        }
        .frame(maxWidth: .infinity)
        .border(.green, width: 2)
    }
    func getColor(for index: Int) -> Color {
        switch index {
        case 0:
            return .groupPurple
        case 1:
            return .groupYellow
        case 2:
            return .groupGreen
        case 3:
            return .groupPink
        case 4:
            return .groupOrange
        case 5:
            return .groupBlue
        case 6:
            return .groupGray
        default:
            return .groupPurple
        }
    }
}


struct ProjectFlowView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectFlowView()
    }
}
