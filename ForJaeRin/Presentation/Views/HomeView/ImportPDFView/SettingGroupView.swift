//
//  SettingGroupView.swift
//  ForJaeRin
//
//  Created by 이재혁 on 2023/07/18.
//

import SwiftUI

struct SettingGroupView: View {
    @EnvironmentObject var myData: MyData
    /// [그룹 이름, 그룹 할당 분, 그룹 할당 초, 그룹 최소 인덱스, 그룹 최대 인덱스]
    @StateObject var vm = SettingGroupVM()
    
    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            GeometryReader { geometry in
                HStack(spacing: 0) {
                    pptGridListView(
                        width: geometry.size.width - vm.SIDEBAR_WIDTH,
                        height: geometry.size.height
                    )
                    groupInspectorView(
                        width: vm.SIDEBAR_WIDTH,
                        height: geometry.size.height
                    )
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .trailing)
        .border(width: 1, edges: [.bottom], color: Color.systemGray100)
        .onAppear {
            resetGroupIndex()
        }
        .onChange(of: vm.somethingIsEdit) {newValue in
            if newValue == false {
                vm.tapHistory = []
            }
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
        ScrollView(showsIndicators: false) {
            /// PDF뷰
            LazyVGrid(columns: vm.columns, spacing: vm.CARD_GAP) {
                ForEach(0..<myData.images.count, id:\.self) { index in
                    TempPDFView(
                        /// groupData에 그룹 최소 인덱스와 최대 인덱스 사이에 속해야 한다.
                        index: index,
                        imgSize: vm.calcCardWidth(containerWidth: width - 80),
                        hilight:
                            vm.focusGroup != -1 &&
                        Int(myData.groupData[vm.focusGroup][3])! <= index &&
                        index <= Int(myData.groupData[vm.focusGroup][4])!
                    )
                    .opacity(tapAvailable().contains(index) ? 1.0 : 0.3)
                    .onTapGesture {
                        /// 탭은 somegthingIsEdit이고, 해당 index가 tapable해야 가능하다.
                        if vm.somethingIsEdit && tapAvailable().contains(index) {
                            /// tapHistory의 길이는 0 -> 1 -> 2 -> 1 -> 2 ...
                            if vm.tapHistory.count == 2 {
                                vm.tapHistory = []
                            }
                            vm.tapHistory.append(index)
                            print(vm.tapHistory)
                            /// focusGroup의 groupData는 tapHistory로 관리된다
                            myData.groupData[vm.focusGroup][3] = String(vm.tapHistory.min()!)
                            myData.groupData[vm.focusGroup][4] = String(vm.tapHistory.max()!)
                        }
                    }
                }
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 40)
            .frame(maxWidth: .infinity)
        }
        .frame(maxWidth: width, maxHeight: height)
    }
    
    // MARK: - 우측 뷰
    private func groupInspectorView(width:CGFloat, height: CGFloat) -> some View {
        ScrollView(showsIndicators: false) {
            ZStack(alignment: .top) {
                Rectangle()
                    .foregroundColor(Color.sub50)
                    .frame(minWidth: width, minHeight: height)
                VStack(spacing: 0) {
                    ForEach(myData.groupData.indices, id: \.self) {index in
                        /// 그룹 리스트
                        GroupListView(settingGroupVM: vm, index: index, resetAction: resetGroupIndex)
                    }
                    /// 그룹 추가 버튼
                    if  myData.groupData.count < 7 {
                        GroupingAddButtonView(vm: vm)
                        .padding(.top, 4)
                        .buttonStyle(.plain)
                        /// 수정 혹은 추가 중이면 클릭 불가
                        .disabled(vm.somethingIsEdit || !vm.groupIndex.contains(-1))
                    }
                    if myData.groupData.isEmpty {
                        Text("아이콘을 클릭해\n그룹을 추가해주세요")
                            .systemFont(.caption1)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.black.opacity(0.35))
                            .padding(.top, 8)
                    }
                    Spacer()
                }
                .padding(.top, 34)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .frame(maxWidth: width, maxHeight: .infinity)
    }
}
