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
    @EnvironmentObject var voiceManager: VoiceManager
    @EnvironmentObject var vm: PresentationVM
    
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .stroke(Color.primary300)
                    .background(Color.detailLayoutBackground)
                    .cornerRadius(100)
                    .frame(maxWidth: vm.voiceScaleSize, maxHeight: vm.voiceScaleSize)
                Circle()
                    .fill(Color.systemPrimary)
                    .frame(maxWidth: vm.VOICE_SCALE_SIZE.min, maxHeight: vm.VOICE_SCALE_SIZE.min)
                Image(systemName: vm.VOICE_VISUALIZATION_ICON_INFO.icon)
                    .font(Font.system(size: 24))
                    .scaledToFit()
                    .foregroundColor(Color.systemWhite)
                    .frame(maxWidth: vm.VOICE_SCALE_SIZE.min, maxHeight: vm.VOICE_SCALE_SIZE.min)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: 128)
        .onChange(of: voiceManager.average) { newValue in
            // MARK: 음성이 변할 때 마다 사이즈 변환
            vm.normalizeSoundLevel(level: newValue)
        }
    }
}

struct VoiceVisualizationView_Previews: PreviewProvider {
    static var previews: some View {
        VoiceVisualizationView()
    }
}
