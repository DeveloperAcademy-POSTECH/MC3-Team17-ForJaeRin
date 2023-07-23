//
//  ButtonView.swift
//  ForJaeRin
//
//  Created by 이용준의 Macbook on 2023/07/20.
//

import SwiftUI

struct GroupingAddButtonView: View {
    @Binding var groupData: [[String]]
    @Binding var somethingIsEdit: Bool
    @Binding var focusGroup: Int
    
    var body: some View {
        Button(action: {
            somethingIsEdit = true
            groupData.append(["", "", "", "-1", "-1"])
            focusGroup = groupData.count - 1
        }, label: {
            Image(systemName: "plus.circle.fill")
                .font(.system(size: 20))
                .foregroundColor(Color.primary500)
        })
    }
}
