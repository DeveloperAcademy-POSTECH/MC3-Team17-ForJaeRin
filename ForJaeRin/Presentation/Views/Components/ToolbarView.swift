//
//  ToolbarView.swift
//  ForJaeRin
//
//  Created by Yun Dongbeom on 2023/07/13.
//

import SwiftUI

struct ToolbarView: CustomizableToolbarContent {
    var body: some CustomizableToolbarContent {

        ToolbarItem(id: "font", placement: .secondaryAction) {
            VStack {
                Button {
                    // increase font
                } label: {
                    Label("Increase font size", systemImage: "textformat.size.larger")
                }
            }
            .frame(width: 40, height: 40)
               .background(Color.gray)
               .cornerRadius(20)
       }
    }
}
