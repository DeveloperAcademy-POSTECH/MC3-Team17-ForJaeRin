//
//  SettingGroupView.swift
//  ForJaeRin
//
//  Created by 이재혁 on 2023/07/18.
//

import SwiftUI

struct SettingGroupView: View {
    
    /// [그룹 이름, 그룹 할당 분, 그룹 할당 초, 그룹 최소 인덱스, 그룹 최대 인덱스]
    @State var groupData: [[String]] = []
    /// 각 PDF별 그룹 번호
    @State var groupIndex = Array(repeating: -1, count: 11)
    var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
    /// 현재 보고 있는 그룹 번호(-1은 안 보고 있음)
    @State var focusGroup = -1
    /// 현재 수정 혹은 추가 중이면 true(focusGroup이 0이상)
    @State var somethingIsEdit = false
    /// 클릭한 PDF 인덱스
    /// somethingIsEdit이 false로 변하면 tapHistory를 초기화해야한다.
    @State var tapHistory: [Int] = []
    
    var body: some View {
        HStack {
            Spacer()
            ScrollView(showsIndicators: false) {
                Spacer()
                /// PDF뷰
                LazyVGrid(columns: columns, spacing: 9) {
                    ForEach(0..<11) { index in
                        TempPDFView(
                            /// groupData에 그룹 최소 인덱스와 최대 인덱스 사이에 속해야 한다.
                            index: index,
                            hilight:
//                                index % 2 == 0
                                focusGroup != -1 &&
                                Int(groupData[focusGroup][3])! <= index &&
                                index <= Int(groupData[focusGroup][4])!
                        )
                        .opacity(tapAvailable().contains(index) ? 1.0 : 0.3)
                        .onTapGesture {
                            /// 탭은 somegthingIsEdit이고, 해당 index가 tapable해야 가능하다.
                            if somethingIsEdit && tapAvailable().contains(index) {
                                /// tapHistory의 길이는 0 -> 1 -> 2 -> 1 -> 2 ...
                                if tapHistory.count == 2 {
                                    tapHistory = []
                                }
                                tapHistory.append(index)
                                print(tapHistory)
                                /// focusGroup의 groupData는 tapHistory로 관리된다
                                groupData[focusGroup][3] = String(tapHistory.min()!)
                                groupData[focusGroup][4] = String(tapHistory.max()!)
                            }
                        }
                    }
                }
                .frame(width: 585)
                Spacer()
            }
            Spacer()
            /// 그룹이 보이는 우측 부분
            ZStack {
                Rectangle()
                    .foregroundColor(.clear)
                    .background(Color(red: 0.98, green: 0.98, blue: 0.99))
                    .frame(width: 205)
                VStack {
                    ForEach(groupData.indices, id: \.self) {index in
                        /// 그룹 리스트
                        GroupListView(
                            focusGroup: $focusGroup,
                            index: index,
                            groupData: $groupData,
                            somethingIsEdit: $somethingIsEdit,
                            groupIndex: $groupIndex
                        )
                    }
                    .padding(.top, 20)
                    /// 그룹 추가 버튼
                    GroupingAddButtonView(
                        groupData: $groupData,
                        somethingIsEdit: $somethingIsEdit,
                        focusGroup: $focusGroup
                    )
                    .padding(.top, 34)
                    .buttonStyle(.plain)
                    /// 수정 혹은 추가 중이면 클릭 불가
                    .disabled(somethingIsEdit || !groupIndex.contains(-1))
                    if groupData.isEmpty {
                        Text("아이콘을 클릭해\n그룹을 추가해주세요")
                            .multilineTextAlignment(.center)
                            .font(.system(size: 15))
                            .foregroundColor(.black.opacity(0.35))
                            .padding(.top, 8)
                    }
                    Spacer()
                }.frame(width: 205)
            }.padding(.bottom, 0)
        }
        .padding(.top, 30)
        .onChange(of: somethingIsEdit) {newValue in
            if newValue == false {
                tapHistory = []
            }
        }
    }
    
    /// PDF를 탭할 때마다 선택 가능한 인덱스 리스트를 반환
    /// 선택 가능한 인덱스란 ?
    /// tapHistory가 비어있다면 groupIndex가 -1인 애들
    /// tapHistory가 한 개라면 groupIndex를 탐색하며 양쪽으로 -1인 애들
    /// tapHistory가 두 개라면 groupIndexrk -1인 애들
    func tapAvailable() -> [Int] {
        var answer: [Int] = []
        if tapHistory.count == 1 {
            for index in tapHistory[0]..<groupIndex.count {
                if groupIndex[index] == -1 {
                    answer.append(index)
                } else {
                    break
                }
            }
            for index in stride(from: tapHistory[0], to: -1, by: -1) {
                if groupIndex[index] == -1 {
                    answer.append(index)
                } else {
                    break
                }
            }
        } else {
            for index in 0..<groupIndex.count {
                if groupIndex[index] == -1 {
                    answer.append(index)
                }
            }
        }
        return answer
    }
}
