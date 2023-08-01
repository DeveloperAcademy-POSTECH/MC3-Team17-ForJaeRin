//
//  SettingGroupView.swift
//  ForJaeRin
//
//  Created by 이재혁 on 2023/07/18.
//

import SwiftUI
import Pretendard

struct SettingGroupView: View {
    @EnvironmentObject var myData: MyData
    @EnvironmentObject var projectFileManager: ProjectFileManager
    /// [그룹 이름, 그룹 할당 분, 그룹 할당 초, 그룹 최소 인덱스, 그룹 최대 인덱스]
    @StateObject var vm = SettingGroupVM()
    
    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            GeometryReader { geometry in
                let sidebarWidth = (geometry.size.width - 80) * 0.3
                HStack(spacing: 0) {
                    pptGridListView(
                        width: geometry.size.width - sidebarWidth,
                        height: geometry.size.height
                    )
                    groupInspectorView(
                        width: sidebarWidth,
                        height: geometry.size.height
                    )
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .trailing)
        .border(width: 1, edges: [.bottom], color: Color.systemGray100)
        .onAppear {
            resetGroupIndex()
            vm.editModes = Array(repeating: false, count: myData.groupData.count)
        }
        .onChange(of: vm.editModes) {newValue in
            if !newValue.contains(true) {
                vm.tapHistory = []
            }
            print(vm.editModes)
        }
    }
    /// PDF를 탭할 때마다 선택 가능한 인덱스 리스트를 반환
    /// 선택 가능한 인덱스란 ?
    /// tapHistory가 비어있다면 groupIndex가 -1인 애들
    /// tapHistory가 한 개라면 groupIndex를 탐색하며 양쪽으로 -1인 애들
    /// tapHistory가 두 개라면 groupIndexrk -1인 애들
    private func tapAvailable() -> [Int] {
        var answer: [Int] = []
        if vm.tapHistory.count == 1 {
            for index in vm.tapHistory[0]..<vm.groupIndex.count {
                if vm.groupIndex[index] == -1 {
                    answer.append(index)
                } else {
                    break
                }
            }
            for index in stride(from: vm.tapHistory[0], to: -1, by: -1) {
                if vm.groupIndex[index] == -1 {
                    answer.append(index)
                } else {
                    break
                }
            }
        } else {
            for index in 0..<vm.groupIndex.count where vm.groupIndex[index] == -1 {
                answer.append(index)
            }
        }
        return answer
    }
    
    private func resetGroupIndex() {
        vm.groupIndex = Array(repeating: -1, count: myData.images.count)

        for eachGroup in 0..<myData.groupData.count {
            for contentIndex in Int(myData.groupData[eachGroup][3])!...Int(myData.groupData[eachGroup][4])! {
                vm.groupIndex[contentIndex] = eachGroup
            }
        }
    }
}

extension SettingGroupView {
    // MARK: - 좌측 뷰
    private func pptGridListView(width:CGFloat, height: CGFloat) -> some View {
        VStack(spacing: 0) {
            if myData.isGroupSettingOnboardingActive {
                onboardingView()
                    .padding(.horizontal, .spacing500)
            }
            ScrollView(showsIndicators: false) {
                /// PDF뷰
                LazyVGrid(columns: vm.columns, spacing: .spacing100) {
                    ForEach(0..<myData.images.count, id:\.self) { index in
                        TempPDFView(
                            /// groupData에 그룹 최소 인덱스와 최대 인덱스 사이에 속해야 한다.
                            index: index,
                            imgSize: vm.calcCardWidth(containerWidth: width - 80),
                            hilight:
                                vm.editModes.contains(true) &&
                            Int(myData.groupData[getFocusedGroup()][3])! <= index &&
                            index <= Int(myData.groupData[getFocusedGroup()][4])!
                        )
                        .environmentObject(vm)
                        .onTapGesture {
                            /// 탭은 somegthingIsEdit이고, 해당 index가 tapable해야 가능하다.
                            if tapAvailable().contains(index) {
                                if !vm.editModes.contains(true) {
                                    myData.groupData.append(["", "", "", "-1", "-1"])
                                    vm.editModes.append(true)
                                }
                                /// tapHistory의 길이는 0 -> 1 -> 2 -> 1 -> 2 ...
                                if vm.tapHistory.count == 2 {
                                    vm.tapHistory = []
                                }
                                vm.tapHistory.append(index)
                                if vm.tapHistory.count == 2 && vm.tapHistory.min()! == vm.tapHistory.max()! {
                                    vm.tapHistory.removeLast()
                                }
//                                print(vm.tapHistory)
                                /// focusGroup의 groupData는 tapHistory로 관리된다
                                myData.groupData[getFocusedGroup()][3] = String(vm.tapHistory.min()!)
                                myData.groupData[getFocusedGroup()][4] = String(vm.tapHistory.max()!)
                            }
                        }
                    }
                }
                .padding(.vertical, .spacing400)
                .padding(.horizontal, .spacing500)
                .frame(maxWidth: .infinity)
            }
            .frame(maxWidth: width, maxHeight: height)
        }
    }
    
    private func onboardingView() -> some View {
        ZStack(alignment: .topTrailing) {
            HStack(spacing: .spacing200) {
                VStack {
                    ForEach(0...1, id: \.self) { index in
                        HStack(spacing: .spacing100) {
                            RoundedRectangle(cornerRadius: 4)
                            .stroke(Color.systemPrimary, lineWidth: 2)
                            .background(Color.primary200)
                            .background(
                                Image(systemName: "checkmark.circle.fill")
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(Color.systemPrimary)
                            )
                            .frame(width: 69, height: 52)
                            RoundedRectangle(cornerRadius: 4)
                                .stroke(index == 0 ? Color.systemPrimary : Color.clear, lineWidth: 4)
                            .background(Color.primary200)
                            .frame(width: 69, height: 52)
                            .cornerRadius(4)
                            RoundedRectangle(cornerRadius: 4)
                            .stroke(index == 0 ? Color.systemPrimary : Color.clear, lineWidth: 4)
                            .background(Color.primary200)
                            .frame(width: 69, height: 52)
                            .cornerRadius(4)
                        }
                    }
                }
                VStack(spacing: 12) {
                    VStack(alignment: .leading, spacing: 4) {
                        HStack(spacing: 0) {
                            Text("발표의 흐름 파악")
                                .foregroundColor(GroupColor.groupPurple.text)
                                .systemFont(.caption1)
                                .bold()
                                .multilineTextAlignment(.leading)
                            Text("을 돕기 위해")
                                .foregroundColor(GroupColor.groupPurple.text)
                                .systemFont(.caption1)
                                .multilineTextAlignment(.leading)
                        }
                        .frame(alignment: .leadingLastTextBaseline)
                        Text("연관성 있는 슬라이드끼리 그룹화 해보세요!")
                            .foregroundColor(GroupColor.groupPurple.text)
                            .systemFont(.caption1)
                    }
                    .frame(alignment: .leading)
                    Text("* 지금 설정한 그룹은 나중에도 수정 가능해요!")
                        .foregroundColor(Color.systemGray400)
                        .systemFont(.caption2)
                }
                .frame(alignment: .leading)
            }
            .frame(maxWidth: .infinity)
            
            Button {
                myData.isGroupSettingOnboardingActive = false
            } label: {
                Image(systemName: "xmark")
                    .foregroundColor(Color.systemPrimary)
                    .frame(width: 16, height: 16)
            }
            .buttonStyle(.plain)
            .offset(x: 12, y: -12)
        }
        .padding(.vertical, .spacing300)
        .padding(.horizontal, .spacing400)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.systemPrimary)
                .foregroundColor(Color.primary200)
                .background(Color.init(hex: "#EAE7FF"))
                .cornerRadius(12)
                .frame(maxWidth: .infinity)
        )
        .frame(maxWidth: .infinity)
    }
    
    // MARK: - 우측 뷰
    private func groupInspectorView(width:CGFloat, height: CGFloat) -> some View {
        ZStack(alignment: .top) {
            Rectangle()
                .foregroundColor(Color.sub50)
                .frame(minWidth: width, minHeight: height)
            VStack(spacing: 0) {
                leftTimeView()
                    .padding(.horizontal, .spacing150)
                    .padding(.bottom, 8)
                ScrollView(showsIndicators: false) {
                    ForEach(myData.groupData.indices, id: \.self) {index in
                        /// 그룹 리스트
                        GroupListView(settingGroupVM: vm, index: index, resetAction: resetGroupIndex)
                            .padding(.horizontal, .spacing150)
                            .padding(.top, 8)
                    }
                    /// 그룹 추가 버튼
                    if  myData.groupData.count < 7 {
                        GroupingAddButtonView(vm: vm)
                        .padding(.horizontal, .spacing150)
                        .buttonStyle(.plain)
                        .padding(.top, myData.groupData.isEmpty ? .spacing200 : .spacing100)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }.frame(maxWidth: width, maxHeight: .infinity)
    }
    
    private func leftTimeView() -> some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Spacer()
                VStack {
                    Text("설정 시간")
                        .systemFont(.caption2)
                        .foregroundColor(.systemGray300)
                    Spacer()
                    Text(String(format: "%02d", myDataTimeConvert())+":00")
                        .font(Font.custom(Pretendard.semibold.fontName, size: 20))
                        .foregroundColor(.systemBlack)
                }
                Spacer()
                Rectangle()
                    .fill(Color.systemGray100)
                    .frame(maxWidth: 0.5, maxHeight: .infinity)
                Spacer()
                VStack {
                    Text("남은 시간")
                        .systemFont(.caption2)
                        .foregroundColor(.systemGray300)
                    Spacer()
                    Text(leftTimeCalculator())
                        .font(Font.custom(Pretendard.semibold.fontName, size: 20))
                        .foregroundColor(leftTimeCalculator().first != "-"
                                         ? .systemBlack : Color(hex: "FF0000"))
                        .opacity(leftTimeCalculator().first != "-" ? 1.0 : 0.6)
                }
                Spacer()
            }
            .frame(height: 46)
            .padding(.vertical, .spacing400)
            Rectangle()
                .foregroundColor(Color.systemGray100)
                .frame(height: 1)
        }
    }
    
    func getFocusedGroup() -> Int {
        var answer = -1
        for groupIndex in vm.editModes.indices where vm.editModes[groupIndex] {
            answer = groupIndex
        }
        return answer
    }
    
    func leftTimeCalculator() -> String {
        var answer = myDataTimeConvert() * 60
        for groupIndex in 0..<myData.groupData.count {
            var minute = 0
            var second = 0
            if myData.groupData[groupIndex][1] != "" {
                minute = Int(myData.groupData[groupIndex][1].filter { "0123456789".contains($0) })!
            }
            if myData.groupData[groupIndex][2] != "" {
                second = Int(myData.groupData[groupIndex][2].filter { "0123456789".contains($0) })!
            }
            answer -= minute * 60 + second
        }
        if answer >= 0 {
            return DateManager.secondsToTime(seconds: answer)
        } else {
            return DateManager.intToTime(second: answer)
        }
    }
    
    func myDataTimeConvert() -> Int {
        let temp = myData.time
        return Int(temp.dropLast())!
    }
}
