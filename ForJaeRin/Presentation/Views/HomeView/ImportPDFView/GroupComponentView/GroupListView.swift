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
    @Binding var groupIndex: [Int]
    
    var body: some View {
        if index < groupData.count {
            if editMode {
                VStack(alignment: .center) {
                    HStack(spacing: 4) {
                        ZStack(alignment: .leading) {
                            RoundedRectangle(cornerRadius: 6)
                                .fill(.black.opacity(0.01))
                                .frame(width: groupData[index][0] != ""
                                        && groupData[index][1] != ""
                                        && groupData[index][2] != ""
                                        && groupData[index][3] != "-1"
                                        && groupData[index][4] != "-1" ? 141 : 173,
                                        height: 36)
                            RoundedRectangle(cornerRadius: 6)
                                .stroke(.black.opacity(0.04), lineWidth: 1)
                                .frame(width: groupData[index][0] != ""
                                        && groupData[index][1] != ""
                                        && groupData[index][2] != ""
                                        && groupData[index][3] != "-1"
                                        && groupData[index][4] != "-1" ? 141 : 173,
                                        height: 36)
                            TextField("그룹이름을 입력해주세요", text: $groupData[index][0])
                                .font(.system(size: 14))
                                .textFieldStyle(.plain)
                                .padding(.leading, 10)
                        }.frame(width: groupData[index][0] != ""
                                && groupData[index][1] != ""
                                && groupData[index][2] != ""
                                && groupData[index][3] != "-1"
                                && groupData[index][4] != "-1" ? 141 : 173,
                                height: 36)
                        /// 입력받은 데이터가 모두 있어야 trash.fill을 표시
                        if groupData[index][0] != ""
                            && groupData[index][1] != ""
                            && groupData[index][2] != ""
                            && groupData[index][3] != "-1"
                            && groupData[index][4] != "-1" {
                            Button(action: {
                                for tmpindex in 0..<groupIndex.count {
                                    if groupIndex[tmpindex] == index {
                                        groupIndex[tmpindex] = -1
                                    } else if groupIndex[tmpindex] > index {
                                        groupIndex[tmpindex] -= 1
                                    }
                                }
                                for tmpindex in Int(groupData[index][3])!...Int(groupData[index][4])! {
                                    groupIndex[tmpindex] = -1
                                }
                                groupData.remove(at: index)
                                editMode = false
                                somethingIsEdit = false
                                focusGroup = -1
                            }, label: {
                                Image(systemName: "trash.fill")
                                    .frame(width: 28, height: 28)
                                    .foregroundColor(Color.systemGray300)
                            }).buttonStyle(.plain)
                        }
                    }
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 6)
                            .fill(.black.opacity(0.01))
                            .frame(width: 173, height: 76)
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(.black.opacity(0.04), lineWidth: 1)
                            .frame(width: 173, height: 76)
                        VStack {
                            HStack(spacing: 0) {
                                // MARK: 여기부터 !
                                Text("발표 시간")
                                    .font(.system(size: 14))
                                    .padding(.leading, 9)
                                Spacer()
                                TextField("0", text: $groupData[index][1])
                                    .font(.system(size: 14))
                                    .textFieldStyle(.plain)
                                    .frame(width: 17)
                                Text("분")
                                    .font(.system(size: 14))
                                TextField("0", text: $groupData[index][2])
                                    .font(.system(size: 14))
                                    .textFieldStyle(.plain)
                                    .frame(width: 17)
                                Text("초")
                                    .font(.system(size: 14))
                                    .padding(.trailing, 9)
                            }
                            HStack {
                                Text("페이지 번호")
                                    .font(.system(size: 14))
                                    .padding(.leading, 9)
                                Spacer()
                                Text("\(Int(groupData[index][3])! + 1) - \(Int(groupData[index][4])! + 1)")
                                    .font(.system(size: 14))
                                    .foregroundColor(.black.opacity(0.25))
                                    .padding(.trailing, 9)
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
                                    .font(.system(size: 16))
                                    .foregroundColor(Color.white)
                            }
                        }).buttonStyle(.plain)
                        /// 입력받지 않은게 하나라도 있으면 disabled
                        Button(action: {
                            editMode = false
                            focusGroup = -1
                            somethingIsEdit = false
                            for tmpindex in Int(groupData[index][3])!...Int(groupData[index][4])! {
                                groupIndex[tmpindex] = index
                            }
                            print(groupIndex)
                        }, label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 6)
                                    .fill(Color(red: 0.54, green: 0.43, blue: 1))
                                    .frame(width: 75, height: 38)
                                Text("완료")
                                    .font(.system(size: 16))
                                    .foregroundColor(Color.white)
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
                            .foregroundColor(.black.opacity(0.5))
                            .font(.system(size: 12))
                            .padding(.leading, 12)
                        
                        Spacer()
                        Text("\(groupData[index][1])분 \(groupData[index][2])초")
                            .foregroundColor(.black)
                            .font(.system(size: 12))
                            .padding(.trailing, 24)
                    }.padding(.top, 13)
                    HStack {
                        Text("페이지 번호")
                            .foregroundColor(.black.opacity(0.5))
                            .font(.system(size: 12))
                            .padding(.leading, 12)
                        Spacer()
                        Text("\(Int(groupData[index][3])! + 1) - \(Int(groupData[index][4])! + 1)")
                            .foregroundColor(.black)
                            .font(.system(size: 12))
                            .padding(.trailing, 24)
                    }.padding(.top, 16)
                    
                }, label: {
                    HStack {
                        Text("\(groupData[index][0])")
                            .foregroundColor(.black.opacity(0.85))
                            .font(.system(size: 14))
                            .padding(.leading, 8)
                        Spacer()
                        Button(action: {
                            editMode = true
                            somethingIsEdit = true
                            focusGroup = index
                        }, label: {
                            Image(systemName: "ellipsis")
                                .frame(width: 23, height: 33)
                                .padding(.trailing, 20)
                        }).buttonStyle(.plain)
                }
                })
                .padding(.leading, 12)
                .font(.system(size: 17))
                .foregroundColor(.black.opacity(0.85))
                .accentColor(Color.green)
            }
        }
    }
}
