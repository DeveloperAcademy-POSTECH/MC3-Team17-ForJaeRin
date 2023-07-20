//
//  SettingGroupView.swift
//  ForJaeRin
//
//  Created by 이재혁 on 2023/07/18.
//

import SwiftUI
// .background(GroupColor.allCases[index].color)

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
    
    var body: some View {
        HStack {
            /// PDF뷰
            LazyVGrid(columns: columns) {
                ForEach(0..<11) { index in
                    TempPDFView(
                        index: index
                    ).opacity(groupIndex[index] == -1 ? 1.0 : 0.3)
                }
            }.frame(width: 603)
            /// 그룹이 보이는 우측 부분
            VStack {
                ForEach(groupData.indices, id: \.self) {index in
                    /// 그룹 리스트
                    GroupListView(
                        focusGroup: $focusGroup,
                        index: index,
                        groupData: $groupData,
                        somethingIsEdit: $somethingIsEdit
                    )
                }
                /// 그룹 추가 버튼
                GroupingAddButtonView(
                    groupData: $groupData,
                    somethingIsEdit: $somethingIsEdit,
                    focusGroup: $focusGroup
                )
                .padding(.top, 34)
                .buttonStyle(.plain)
                /// 수정 혹은 추가 중이면 클릭 불가
                .disabled(somethingIsEdit)
                if groupData.isEmpty {
                    Text("새 그룹을 생성해주세요")
                        .font(.system(size: 15))
                        .foregroundColor(.black.opacity(0.35))
                }
                Spacer()
            }.frame(width: 205)
        }
    }
    
    /// PDF를 탭할 때마다 선택 가능한 인덱스 리스트를 반환
    func tapAvailable() -> [Int] {
        return []
    }
}
