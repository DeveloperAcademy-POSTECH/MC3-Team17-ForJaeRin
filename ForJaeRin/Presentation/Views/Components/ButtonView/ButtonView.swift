//
//  ButtonView.swift
//  ForJaeRin
//
//  Created by Yun Dongbeom on 2023/07/10
//

import SwiftUI

/**
 커스텀 버튼을 작성하였는데,
 사용 관련해서는 UI디자인 나오면 어떻게 할지 이야기 한번 더 나누어보아야 할 것 같습니다.
 */
// MARK: 커스텀 버튼 - 모디파이어만 사용할지 고민중
struct ButtonView: View {
    var labelName: String = "임시버튼"
    var style = 0
    var completion: () -> Void
    var label: (_ name: String) -> Label<Text, Image>
    
    var body: some View {
        Button {
            completion()
        } label: {
            if style == 0 {
                label(labelName).labelStyle(.titleOnly)
            } else {
                label(labelName).labelStyle(.titleAndIcon)
            }
        }
    }
}

extension ButtonView {
    init(_ labelName: String) {
        
        func initCompletion() {
            print("Hello World")
        }
        
        func initLabel(_ name: String) -> Label<Text, Image> {
            Label(labelName, systemImage: "bolt.fill")
        }
        
        self.labelName = labelName
        self.style = 0
        self.completion = initCompletion
        self.label = initLabel
    }
    
    init(_ labelName: String, completion: @escaping () -> Void) {
        
        func initLabel(_ name: String) -> Label<Text, Image> {
            Label(labelName, systemImage: "bolt.fill")
        }
        
        self.labelName = labelName
        self.style = 0
        self.completion = completion
        self.label = initLabel
    }
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView {
            print("dididi")
        } label: { name in
            Label(name, systemImage: "bolt.fill")
        }
    }
}
