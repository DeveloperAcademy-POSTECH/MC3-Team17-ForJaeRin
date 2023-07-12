//
//  AudioControllerView.swift
//  ForJaeRin
//
//  Created by Yun Dongbeom on 2023/07/12.
//

import SwiftUI

/**
 VoiceManager / SpeechRecognizer와 함께 연동해서 음성 저장
 */
// MARK: 연습모드 기록을 위한 오디오 컨트롤러
struct AudioControllerView: View {
    var body: some View {
        HStack {
            HStack {
                Button {
                    print("Play")
                } label: {
                    Text("Play")
                }
                Button {
                    print("Pause")
                } label: {
                    Text("Pause")
                }
                Button {
                    print("stop")
                } label: {
                    Text("stop")
                }
            }
            .border(.blue)
        }
        .frame(maxWidth: .infinity, maxHeight: 64, alignment: .center)
        .border(.blue)
    }
}

struct AudioControllerView_Previews: PreviewProvider {
    static var previews: some View {
        AudioControllerView()
    }
}
