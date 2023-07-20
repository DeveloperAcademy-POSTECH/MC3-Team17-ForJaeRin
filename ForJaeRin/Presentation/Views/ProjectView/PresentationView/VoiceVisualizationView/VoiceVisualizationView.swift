//
//  VoiceVisualizationView.swift
//  ForJaeRin
//
//  Created by Yun Dongbeom on 2023/07/12.
//

import SwiftUI

/**
 VoiceManager / SpeechRecognizer와 함께 연동해서 음성 시각화
 */
// MARK: 현재 말하는 상태 시각화
struct VoiceVisualizationView: View {
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .fill(Color.systemPrimary)
                    .frame(maxWidth: 48, maxHeight: 48)
                Image(systemName: "mic.fill")
                    .font(Font.system(size: 24))
                    .scaledToFit()
                    .foregroundColor(Color.systemWhite)
                    .frame(maxWidth: 48, maxHeight: 48)
//                Circle()
                
            }
        }
        .frame(maxWidth: .infinity, maxHeight: 200)
        .border(.red, width: 2)
    }
}

struct VoiceVisualizationView_Previews: PreviewProvider {
    static var previews: some View {
        VoiceVisualizationView()
    }
}
