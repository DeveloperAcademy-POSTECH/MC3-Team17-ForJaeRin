//
//  ButtonView.swift
//  ForJaeRin
//
//  Created by 이용준의 Macbook on 2023/07/20.
//

import SwiftUI

struct GroupingAddButtonView: View {
    @ObservedObject var vm: SettingGroupVM
    @EnvironmentObject var myData: MyData
    
    var body: some View {
        Button(action: {
            vm.editModes.append(true)
            myData.groupData.append(["", "", "", "-1", "-1"])
        }, label: {
            if myData.groupData.isEmpty {
                ZStack {
                    VStack(spacing: 13) {
                        Image(systemName: "plus")
                            .resizable()
                            .foregroundStyle(Color.primary500)
                            .frame(width: 20, height: 20)
                        Text("최소 3개, 최대 7개의\n그룹을 만들어 보세요")
                            .systemFont(.caption1)
                            .foregroundColor(.systemGray300)
                    }
                }
                .frame(maxWidth: .infinity, minHeight: 124)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .foregroundColor(.primary100)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                )
                
            } else {
                Image(systemName: "plus")
                    .resizable()
                    .foregroundStyle(Color.primary500)
                    .frame(width: 20, height: 20)
                    .frame(maxWidth: .infinity)
                    .frame(maxWidth: .infinity, minHeight: 57)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .foregroundColor(.primary200)
                    )
            }
        })
        .disabled(vm.editModes.contains(true))
    }
}
