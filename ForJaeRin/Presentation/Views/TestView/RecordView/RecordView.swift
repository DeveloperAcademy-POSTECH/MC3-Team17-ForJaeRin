//
//  RecordView.swift
//  ForJaeRin
//
//  Created by Yun Dongbeom on 2023/07/10.
//

import SwiftUI

struct RecordView: View {
    var body: some View {
        HStack {
            Button {
                VoiceManager.shared.startRecording()
            } label: {
                Text("야 레코딩 시작해")
            }
            Button {
                VoiceManager.shared.stopRecording(index: 0)
            } label: {
                Text("야 레코딩 끝내")
            }
            Button {
                VoiceManager.shared.playRecording()
            } label: {
                Text("야 녹음한거 재생해봐")
            }
        }
    }
}

struct RecordView_Previews: PreviewProvider {
    static var previews: some View {
        RecordView()
    }
}
