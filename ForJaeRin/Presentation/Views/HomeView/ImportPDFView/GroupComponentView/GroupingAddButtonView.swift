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
            vm.somethingIsEdit = true
            myData.groupData.append(["", "", "", "-1", "-1"])
            vm.focusGroup = myData.groupData.count - 1
        }, label: {
            Image(systemName: "plus.circle.fill")
                .font(.system(size: 20))
                .foregroundColor(Color.primary500)
        })
    }
}
