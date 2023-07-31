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
            if !settingGroupVM.editModes.isEmpty && settingGroupVM.editModes[index] {
                editModeView()
                    .padding(.top, index == 0 ? 8 : 0)
            } else {
                nonEditModeView()
            }
        }
    }
}

extension GroupListView {
    // MARK: - editModeView
    private func editModeView() -> some View {
        ZStack(alignment: .topTrailing) {
            VStack(spacing: 8) {
                ZStack {
                    Rectangle()
                        .foregroundColor(.clear)
                        .background(Color.textFieldBackground)
                        .cornerRadius(6)
                        .overlay(
                            RoundedRectangle(cornerRadius: 6)
                                .inset(by: 0.5)
                                .stroke(Color.textFieldBorder, lineWidth: 1)
                        )
                    VStack(spacing: 12) {
                        editModeHeaderView()
                        Rectangle()
                            .fill(Color.systemGray100)
                            .frame(height: 1)
                        editModeBodyView()
                    }
                    .padding(.horizontal, .spacing100)
                    .padding(.vertical, .spacing150)
                }.frame(height: 120)
                editModeFooterView()
            }
            if vm.tempData != ["", "", "", "-1", "-1"] {
                deleteGroupButtonView()
                    .offset(x: 5.0, y: -5.0)
            }
        }
    }
    
    private func editModeHeaderView() -> some View {
        TextField("그룹이름을 입력해주세요", text: $myData.groupData[index][0])
            .foregroundColor(.systemBlack)
            .focused($focusField)
            .systemFont(.caption1)
            .textFieldStyle(.plain)
    }
    
    private func deleteGroupButtonView() -> some View {
        Button(action: {
            focusField = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                myData.groupData.remove(at: index)
                resetAction()
                settingGroupVM.editModes.remove(at: index)
                vm.resetTempData()
            }
        }, label: {
            Image(systemName: "xmark.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
                .foregroundColor(Color.primary500)
        }).buttonStyle(.plain)
    }
    
    private func editModeBodyView() -> some View {
        VStack(spacing: 12) {
            HStack(spacing: 0) {
                Text("페이지 번호")
                    .systemFont(.caption1)
                    .foregroundColor(.systemBlack)
                Spacer()
                Text("\(Int(myData.groupData[index][3])! + 1) - \(Int(myData.groupData[index][4])! + 1)" + " 번")
                    .systemFont(.caption1)
                    .foregroundColor(Color.systemGray200)
            }
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
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    private func timeTextFieldView(text: Binding<String>, label: String) -> some View {
        HStack(spacing: 4) {
            ZStack(alignment: .trailing) {
                RoundedRectangle(cornerRadius: 2)
                    .stroke(Color.primary400, lineWidth: 1)
                    .background(Color.primary100)
                    .frame(width: 25, height: 20)
                TextField("00", text: text)
                    .fixedSize()
                    .focused($focusField)
                    .systemFont(.caption1)
                    .textFieldStyle(.plain)
                    .multilineTextAlignment(.center)
                    .onReceive(Just(myData.groupData[index][2])) { newValue in
                        let filtered = newValue.filter { "0123456789".contains($0) }
                        if filtered != newValue {
                            self.myData.groupData[index][2] = filtered
                        }
                    }
                    .onReceive(Just(myData.groupData[index][1])) { newValue in
                        let filtered = newValue.filter { "0123456789".contains($0) }
                        if filtered != newValue {
                            self.myData.groupData[index][1] = filtered
                        }
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
                myData.groupData.remove(at: index)
                settingGroupVM.editModes.remove(at: index)
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
                    settingGroupVM.editModes.insert(false, at: answerIndex)
                }
                resetAction()
                vm.resetTempData()
            }
        }, label: {
            ZStack {
                RoundedRectangle(cornerRadius: 6)
                    .fill(Color.systemGray200)
                Text("취소")
                    .systemFont(.body)
                    .foregroundColor(Color.systemWhite)
            }.frame(height: 38)
        }).buttonStyle(.plain)
    }
    
    private func doneButtonView() -> some View {
        /// 입력받지 않은게 하나라도 있으면 disabled
        Button(action: {
            if myData.groupData[index][1] == "" {
                myData.groupData[index][1] = "0"
            } else if myData.groupData[index][2] == "" {
                myData.groupData[index][2] = "0"
            }
            var answerIndex = 0
            let addedData = myData.groupData[index]
            myData.groupData.remove(at: index)
            settingGroupVM.editModes.remove(at: index)
            for alreadyData in myData.groupData {
                if Int(alreadyData[3])! > Int(addedData[3])! {
                    break
                }
                answerIndex += 1
            }
            myData.groupData.insert(addedData, at: answerIndex)
            settingGroupVM.editModes.insert(false, at: answerIndex)
            resetAction()
            vm.resetTempData()
        }, label: {
            ZStack {
                RoundedRectangle(cornerRadius: 6)
                    .fill(Color.systemPrimary)
                Text("완료")
                    .systemFont(.body)
                    .foregroundColor(Color.systemWhite)
            }.frame(height: 38)
        }).buttonStyle(.plain)
            .disabled(
                !myData.checkIsGroupDataInit(index: index)
                || myData.groupData[index][2].count > 2
            )
    }
    
    // MARK: - nonEditModeView
    private func nonEditModeView() -> some View {
        DisclosureGroup(isExpanded: $vm.isExpanded, content: {
            noneEditModeInnerView()
        }, label: {
            nonEditModeOuterView()
        })
        .foregroundColor(Color.systemGray500)
        .padding(.leading, 8)
        .padding(.trailing, 17)
    }
    
    private func nonEditModeOuterView() -> some View {
        HStack {
            Text("\(myData.groupData[index][0])")
                .systemFont(.caption1)
                .foregroundColor(Color.systemGray500)
            Spacer()
            Button(action: {
                if !settingGroupVM.editModes.contains(true) {
                    settingGroupVM.editModes[index] = true
                    vm.tempData = myData.groupData[index]
                    for dataIndex in 0..<settingGroupVM.groupIndex.count
                    where settingGroupVM.groupIndex[dataIndex] == index {
                        settingGroupVM.groupIndex[dataIndex] = -1
                    }
                }
            }, label: {
                Image(systemName: "ellipsis")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(Color.systemGray200)
                    .frame(width: 15)
                    .frame(width: 15, height: 36)
                    .background(Color(white: 0.5, opacity: 0.0001))
            }).buttonStyle(.plain)
        }.frame(height: 36)
            .padding(.leading, 8)
    }
    
    private func noneEditModeInnerView() -> some View {
        VStack(spacing: 16) {
            HStack {
                Text("페이지 번호")
                    .foregroundColor(Color.systemGray400)
                    .systemFont(.caption2)
                Spacer()
                Text("\(Int(myData.groupData[index][3])! + 1) - \(Int(myData.groupData[index][4])! + 1)")
                    .foregroundColor(.black)
                    .systemFont(.caption2)
            }
            HStack {
                Text("발표 시간")
                    .foregroundColor(Color.systemGray400)
                    .systemFont(.caption2)
                Spacer()
                Text("\(myData.groupData[index][1])분 \(myData.groupData[index][2])초")
                    .foregroundColor(.black)
                    .systemFont(.caption2)
            }
        }.padding(.top, 13)
    }
}
