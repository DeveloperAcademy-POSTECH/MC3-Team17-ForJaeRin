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
    @State private var isScaled = true
    
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .stroke(Color.primary300)
                    .background(Color.detailLayoutBackground)
                    .cornerRadius(50)
                    .frame(width: isScaled ? 96 : 48, height: isScaled ? 96 : 48)
                    .scaleEffect(isScaled ? 1.0 : 0.7)
                    .animation(Animation.easeInOut(duration: 0.8), value: isScaled)
                    .onAppear {
                       Timer.scheduledTimer(withTimeInterval: 0.6, repeats: true) { _ in
                           withAnimation {
                               isScaled.toggle()
                           }
                       }
                   }
                Circle()
                    .fill(Color.systemPrimary)
                    .frame(maxWidth: 48, maxHeight: 48)
                Image(systemName: "mic.fill")
                    .font(Font.system(size: 24))
                    .scaledToFit()
                    .foregroundColor(Color.systemWhite)
                    .frame(maxWidth: 48, maxHeight: 48)
                
            }
        }
        .frame(maxWidth: .infinity, maxHeight: 128)
    }
}

struct VoiceVisualizationView_Previews: PreviewProvider {
    static var previews: some View {
        VoiceVisualizationView()
    }
}
