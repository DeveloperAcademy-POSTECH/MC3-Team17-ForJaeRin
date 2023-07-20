//
//  GroupListView.swift
//  ForJaeRin
//
//  Created by 이용준의 Macbook on 2023/07/20.
//

import SwiftUI

struct GroupListView: View {
    
    @Binding var focusGroup: Int
    @State var index: Int
    @Binding var groupData: [[String]]
    /// 해당 그룹 리스트뷰가 수정중인지(최초 제작 혹은 ellipsis를 통해 활성화됨
    @State var editMode = true
    @State var isExpanded = false
    /// editMode가 켜지면 true, trash.fill 혹은 입력을 모두 하지 않고 취소를 누르면 false
    @Binding var somethingIsEdit: Bool
    
    var body: some View {
        if index < groupData.count {
            if editMode {
                VStack(alignment: .center) {
                    HStack {
                        ZStack(alignment: .leading) {
                            RoundedRectangle(cornerRadius: 6)
                                .stroke(.black.opacity(0.04), lineWidth: 1)
                                .frame(width: 173, height: 36)
                            TextField("그룹이름을 입력해주세요", text: $groupData[index][0])
                                .textFieldStyle(.plain)
                                .padding(.leading, 10)
                        }.frame(width: 173, height: 36)
                        /// 입력받은 데이터가 모두 있어야 trash.fill을 표시
                        if groupData[index][0] != ""
                            && groupData[index][1] != ""
                            && groupData[index][2] != ""
                            && groupData[index][3] != "-1"
                            && groupData[index][4] != "-1" {
                            Button(action: {
                                groupData.remove(at: index)
                                editMode = false
                                somethingIsEdit = false
                                focusGroup = -1
                            }, label: {
                                Image(systemName: "trash.fill")
                                    .frame(width: 28, height: 28)
                            }).buttonStyle(.plain)
                        }
                    }
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(.black.opacity(0.04), lineWidth: 1)
                            .frame(width: 173, height: 76)
                        VStack {
                            HStack {
                                Text("발표 시간")
                                TextField("0", text: $groupData[index][1])
                                Text("분")
                                TextField("0", text: $groupData[index][2])
                                Text("초")
                            }
                            HStack {
                                Text("페이지 번호")
                                Text("0 - 0")
                            }
                        }
                    }.frame(width: 173, height: 76)
                    HStack {
                        /// 입력받지 않은 데이터가 하나라도 있다면 groupData에서 remove
                        Button(action: {
                            focusGroup = -1
                            somethingIsEdit = false
                            editMode = false
                            if groupData[index][0] == ""
                                || groupData[index][1] == ""
                                || groupData[index][2] == ""
                                || groupData[index][3] == "-1"
                                || groupData[index][4] == "-1" {
                                groupData.remove(at: index)
                            }
                        }, label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 6)
                                    .fill(Color(red: 0.18, green: 0.18, blue: 0.18).opacity(0.25))
                                    .frame(width: 75, height: 38)
                                Text("취소")
                            }
                        }).buttonStyle(.plain)
                        /// 입력받지 않은게 하나라도 있으면 disabled
                        Button(action: {
                            editMode = false
                            focusGroup = -1
                            somethingIsEdit = false
                        }, label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 6)
                                    .fill(Color(red: 0.54, green: 0.43, blue: 1))
                                    .frame(width: 75, height: 38)
                                Text("완료")
                            }
                        }).buttonStyle(.plain)
                            .disabled(
                                groupData[index][0] == ""
                                    || groupData[index][1] == ""
                                    || groupData[index][2] == ""
                                    || groupData[index][3] == "-1"
                                    || groupData[index][4] == "-1"
                            )
                    }
                }
            } else {
                DisclosureGroup(isExpanded: $isExpanded, content: {
                    HStack {
                        Text("발표 시간")
                            .foregroundColor(.black.opacity(0.35))
                        Text("\(groupData[index][1])분 \(groupData[index][2])초")
                        Spacer()
                    }
                    HStack {
                        Text("페이지 번호")
                            .foregroundColor(.black.opacity(0.35))
                        Text("0 - 0")
                        Spacer()
                    }
                    
                }, label: {
                    HStack {
                        Text("\(groupData[index][0])")
                        Button(action: {
                            editMode = true
                            somethingIsEdit = true
                            focusGroup = index
                        }, label: {
                            Image(systemName: "ellipsis")
                                .frame(width: 23, height: 33)
                        }).buttonStyle(.plain)
                }
                })
                .font(.system(size: 17))
                .foregroundColor(.black.opacity(0.85))
                .accentColor(Color.green)
            }
        }
    }
}
