//
//  ContentView.swift
//  ForJaeRin
//
//  Created by Yun Dongbeom on 2023/07/06.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("rin 수정2222")
            Image("test_landscape")
                .resizable()
            SampleView()
            // MARK: 파일시스템을 테스트하기 위한 버튼
            FileSystemView()
        }
        .padding()
        .onAppear {
            VoiceManager.requestMicrophonePermission()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
