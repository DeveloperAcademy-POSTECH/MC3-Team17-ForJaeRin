//
//  SelectProjectView.swift
//  ForJaeRin
//
//  Created by Yun Dongbeom on 2023/07/11.
//

/**
 파일이 없다면 새 프로젝트 생성 버튼 클릭
 파일이 있다면 새 프로젝트 생성하기 or 히스토리 내에서 원하는 프로젝트 선택
 */

import SwiftUI

struct SelectProjectView: View {
    var body: some View {
        VStack {
            ButtonView(style: 1) {
                print("hello")
            } label: { name in
                Label(name, systemImage: "bolt.fill")
            }
            ButtonView(labelName: "Hello World") {
                print("hello")
            } label: { name in
                Label( name, systemImage: "bolt.fill")
            }

            ButtonView("World!") {
                print("World!!")
            }
            Button {
                print("GGG")
            } label: {
                Label("내 버튼!", systemImage: "bolt.fill")
            }
            ButtonView(style: 1) {
                print("GGG")
            } label: { _ in
                Label("내 버튼!", systemImage: "bolt.fill")
            }

        }
    }
}

struct SelectProjectView_Previews: PreviewProvider {
    static var previews: some View {
        SelectProjectView()
    }
}
