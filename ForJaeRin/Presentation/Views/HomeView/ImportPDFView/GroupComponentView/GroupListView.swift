//
//  GroupListView.swift
//  ForJaeRin
//
//  Created by 이용준의 Macbook on 2023/07/20.
//

import SwiftUI
import Combine

struct GroupListView: View {
    /// ellipsis를 누르면 vm.tempData에 저장한다.
    /// groupIndex는 -1로 초기화해둔다.
    /// 취소 버튼 -> vm.tempData로 접근
    /// 완료 버튼 -> 새로 입력된 데이터로 접근
    /// 휴지통 버튼 -> 삭제
    /// 새로 추가할 때
    /// 취소 버튼 -> 삭제
    /// 완료 버튼 -> 저장
    /// 휴지통 버튼 -> 생성 안됨
    ///
    @ObservedObject var settingGroupVM: SettingGroupVM
    @EnvironmentObject var myData: MyData
    @StateObject var vm = GroupListVM()
    @FocusState var focusField: Bool
    var index: Int
    var resetAction: () -> Void
    
    var body: some View {
        if index < myData.groupData.count {
            if vm.editMode {
                editModeView()
            } else {
                nonEditModeView()
            }
        }
    }
}

extension GroupListView {
    // MARK: - editModeView
    private func editModeView() -> some View {
        VStack {
            editModeHeaderView()
            editModeBodyView()
            editModeFooterView()
        }
    }
    
    private func editModeHeaderView() -> some View {
        HStack(spacing: 4) {
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 6)
                    .fill(Color.textFieldBackground)
                    .frame(width: myData.checkIsGroupDataInit(index: index)
                           && vm.tempData != ["", "", "", "-1", "-1"]
                           ? vm.GROUP_TITLE_FIELD_WIDTH.editMode
                           : vm.GROUP_TITLE_FIELD_WIDTH.nonEditMode,
                            height: 36)
                    .background(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(Color.textFieldBorder, lineWidth: 1)
                    )
                TextField("그룹이름을 입력해주세요", text: $myData.groupData[index][0])
                    .focused($focusField)
                    .systemFont(.caption1)
                    .textFieldStyle(.plain)
                    .padding(.leading, 10)
            }.frame(width: myData.checkIsGroupDataInit(index: index)
                    && vm.tempData != ["", "", "", "-1", "-1"]
                    ? vm.GROUP_TITLE_FIELD_WIDTH.editMode
                    : vm.GROUP_TITLE_FIELD_WIDTH.nonEditMode,
                    height: 36)
            /// 입력받은 데이터가 모두 있고, vm.tempData가 ["", "", "", "", ""]가 아니어야 trash.fill을 표시
            if myData.checkIsGroupDataInit(index: index)
                && vm.tempData != ["", "", "", "-1", "-1"] {
                deleteGroupButtonView()
            }
        }
    }
    
    private func deleteGroupButtonView() -> some View {
        Button(action: {
            focusField = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                withAnimation {
                    myData.groupData.remove(at: index)
                    resetAction()
                    vm.editMode = false
                    settingGroupVM.somethingIsEdit = false
                    settingGroupVM.focusGroup = -1
                    vm.resetTempData()
                }
            }
        }, label: {
            Image(systemName: vm.DELETE_BUTTON_INFO.icon)
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
                .foregroundColor(Color.systemGray300)
                .frame(width: 28, height: 28)
        }).buttonStyle(.plain)
    }
    
    private func editModeBodyView() -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 6)
                .fill(Color.textFieldBackground)
                .frame(width: vm.GROUP_TITLE_FIELD_WIDTH.nonEditMode, height: 76)
                .background(
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(Color.textFieldBorder, lineWidth: 1)
                )
            VStack {
                HStack(spacing: 0) {
                    Text("발표 시간")
                        .systemFont(.caption1)
                        .multilineTextAlignment(.leading)
                    Spacer()
                    HStack(spacing: 4) {
                        ForEach(1...2, id: \.self) { _index in
                            timeTextFieldView(
                                text: $myData.groupData[index][_index],
                                label: _index == 1 ? "분" : "초"
                            )
                            .onAppear {
                                if _index == 2 {
                                    myData.groupData[index][_index] = "0"
                                }
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                HStack {
                    Text("페이지 번호")
                        .systemFont(.caption1)
                        .multilineTextAlignment(.leading)
                    Spacer()
                    Text("\(Int(myData.groupData[index][3])! + 1) - \(Int(myData.groupData[index][4])! + 1)")
                        .systemFont(.caption1)
                        .foregroundColor(Color.systemGray200)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 10)
        }
        .frame(width: vm.GROUP_TITLE_FIELD_WIDTH.nonEditMode, height: 76)
    }
    
    private func timeTextFieldView(text: Binding<String>, label: String) -> some View {
        HStack(spacing: 4) {
            TextField("0", text: text)
                .focused($focusField)
                .systemFont(.caption1)
                .textFieldStyle(.plain)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 4)
                .background(
                    RoundedRectangle(cornerRadius: 2)
                        .stroke(Color.primary400, lineWidth: 1)
                        .background(Color.primary100)
                )
                .frame(width: 18)
                .onReceive(Just(myData.groupData[index][2])) { newValue in
                    let filtered = newValue.filter { "0123456789".contains($0) }
                    if filtered != newValue {
                        self.myData.groupData[index][2] = filtered
                    }
                }
            Text(label)
                .onTapGesture {
                    print(myData.groupData)
                    print(vm.tempData)
                    focusField = false
                }
                .systemFont(.caption1)
        }
    }
    
    private func editModeFooterView() -> some View {
        HStack {
            cancelButtonView()
            doneButtonView()
        }
    }
    
    private func cancelButtonView() -> some View {
        /// 입력받지 않은 데이터가 하나라도 있다면 groupData에서 remove
        Button(action: {
            focusField = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                withAnimation {
                    myData.groupData.remove(at: index)
                    vm.editMode = false
                    settingGroupVM.somethingIsEdit = false
                    settingGroupVM.focusGroup = -1
                    if vm.tempData[0] != ""
                        || vm.tempData[1] != ""
                        || vm.tempData[2] != ""
                        || vm.tempData[3] != "-1"
                        || vm.tempData[4] != "-1" {
                        var answerIndex = 0
                        for alreadyData in myData.groupData {
                            if Int(alreadyData[3])! > Int(vm.tempData[3])! {
                                break
                            }
                            answerIndex += 1
                        }
                        myData.groupData.insert(vm.tempData, at: answerIndex)
                    }
                    resetAction()
                    vm.resetTempData()
                }
            }
        }, label: {
            ZStack {
                RoundedRectangle(cornerRadius: 6)
                    .fill(Color.systemGray200)
                    .frame(width: 75, height: 38)
                Text("취소")
                    .systemFont(.body)
                    .foregroundColor(Color.systemWhite)
            }
        }).buttonStyle(.plain)
    }
    
    private func doneButtonView() -> some View {
        /// 입력받지 않은게 하나라도 있으면 disabled
        Button(action: {
            withAnimation {
                var answerIndex = 0
                let addedData = myData.groupData[index]
                myData.groupData.remove(at: index)
                for alreadyData in myData.groupData {
                    if Int(alreadyData[3])! > Int(addedData[3])! {
                        break
                    }
                    answerIndex += 1
                }
                myData.groupData.insert(addedData, at: answerIndex)
                vm.editMode = false
                settingGroupVM.focusGroup = -1
                settingGroupVM.somethingIsEdit = false
                resetAction()
                vm.resetTempData()
            }
        }, label: {
            ZStack {
                RoundedRectangle(cornerRadius: 6)
                    .fill(Color.systemPrimary)
                    .frame(width: 75, height: 38)
                Text("완료")
                    .systemFont(.body)
                    .foregroundColor(Color.systemWhite)
            }
        }).buttonStyle(.plain)
            .disabled(
                !myData.checkIsGroupDataInit(index: index)
            )
    }
    
    // MARK: - nonEditModeView
    private func nonEditModeView() -> some View {
        DisclosureGroup(isExpanded: $vm.isExpanded, content: {
            noneEditModeInnerView()
        }, label: {
            nonEditModeOuterView()
        })
        .padding(.leading, 12)
        .padding(.bottom, 8)
        .systemFont(.caption1)
        .foregroundColor(Color.systemGray500)
    }
    
    private func nonEditModeOuterView() -> some View {
        HStack {
            Text("\(myData.groupData[index][0])")
                .systemFont(.caption1)
                .foregroundColor(Color.systemGray500)
                .padding(.leading, 8)
            Spacer()
            Button(action: {
                withAnimation {
                    vm.editMode = true
                    settingGroupVM.somethingIsEdit = true
                    settingGroupVM.focusGroup = index
                    vm.tempData = myData.groupData[index]
                    for dataIndex in 0..<settingGroupVM.groupIndex.count
                    where settingGroupVM.groupIndex[dataIndex] == index {
                        settingGroupVM.groupIndex[dataIndex] = -1
                    }
                }
            }, label: {
                Image(systemName: "ellipsis")
                    .foregroundColor(Color.systemGray200)
                    .frame(width: 23, height: 33)
                    .padding(.trailing, 20)
            }).buttonStyle(.plain)
        }
    }
    
    private func noneEditModeInnerView() -> some View {
        Group {
            HStack {
                Text("발표 시간")
                    .foregroundColor(Color.systemGray400)
                    .systemFont(.caption2)
                    .padding(.leading, 12)
                Spacer()
                Text("\(myData.groupData[index][1])분 \(myData.groupData[index][2])초")
                    .foregroundColor(.black)
                    .systemFont(.caption2)
                    .padding(.trailing, 24)
            }
            .padding(.vertical, 8)
            HStack {
                Text("페이지 번호")
                    .foregroundColor(Color.systemGray400)
                    .systemFont(.caption2)
                    .padding(.leading, 12)
                Spacer()
                Text("\(Int(myData.groupData[index][3])! + 1) - \(Int(myData.groupData[index][4])! + 1)")
                    .foregroundColor(.black)
                    .systemFont(.caption2)
                    .padding(.trailing, 24)
            }
        }
    }
}
