//
//  PresentationTimerView.swift
//  ForJaeRin
//
//  Created by Yun Dongbeom on 2023/07/12.
//

import SwiftUI

/**
 연습모드 실행 시 설정한 시간과 실행 시간 측정
 */
// MARK: 연습모드 타이머
struct PresentationTimerView: View {
    @EnvironmentObject var voiceManager: VoiceManager
    @EnvironmentObject var projectFileManamger: ProjectFileManager
    @EnvironmentObject var vm: PresentationVM
    @EnvironmentObject var speechRecognizer: SpeechRecognizer
    
    // MARK: 컨트롤러 위치 조정을 위한 local state
    @State private var pogPosition = CGPoint()
    @State private var isAnimationReady = false
    @State private var size = CGSize.zero
    @State private var isPlay = false
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                HStack {
                    audioButonContainer()
                    Spacer()
                    timerContainer()
                }
                .padding(.vertical, 8)
                .padding(.horizontal, .spacing150)
                .frame(
                    maxWidth: vm.AUDIO_CONTROLLER_SIZE.width,
                    maxHeight: vm.AUDIO_CONTROLLER_SIZE.height
                )
                .background(Color.systemWhite.opacity(0.6))
                .background(.ultraThinMaterial)
                .cornerRadius(10)
                .shadow(color: Color.systemBlack.opacity(0.25), radius: 20, x: 0, y: 8)
                .onAppear {
                    pogPosition = CGPoint(x: geometry.size.width / 2, y: geometry.size.height - 60)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        self.isAnimationReady = true
                    }
                }
                .onChange(of: geometry.size) { newValue in
                    print(geometry.size)
                    print(pogPosition)
                    print(newValue)
                    pogPosition = CGPoint(x: newValue.width / 2, y: newValue.height - 60)
                }
            }
            .background(GeometryReader {
                Color.clear
                    .preference(key: ViewSizeKey.self, value: $0.frame(in: .local).size)
            })
            .onPreferenceChange(ViewSizeKey.self) {
                self.size = $0
            }
            .position(pogPosition)
            .animation(.linear, value: isAnimationReady ? pogPosition : nil)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        let rect = geometry.frame(in: .local)
                        if rect.contains(value.location) {
                            self.pogPosition = value.location
                        }
                    }
                    .onEnded { value in
                        print(value.location)
                    }
            )
        }
    }
}

extension PresentationTimerView {
    private func audioButonContainer() -> some View {
        HStack(spacing: 32) {
            audioControllButton(info: vm.AUDIO_PLAY_BUTTON_INFO) {
                if !isPlay {
                    isPlay = true
                    voiceManager.startRecording(title: projectFileManamger.projectMetadata!.projectName)
                    speechRecognizer.startTranscribing()
                    vm.practice.speechRanges.append(SpeechRange(start: voiceManager.countSec, group: 0))
                }
            }
            audioControllButton(info: vm.AUDIO_PAUSE_BUTTON_INFO) {
                speechRecognizer.stopTranscribing()
                voiceManager.stopRecording(index: 0)
                isPlay = false
            }
            // MARK: 현재 저장한 음성을 듣기 위한 테스트 버튼
//            audioControllButton(info: vm.AUDIO_PLAY_BUTTON_INFO) {
//                voiceManager.playRecording()
//            }
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 32)
    }
    
    private func audioControllButton(
        info: (icon: String, label: String),
        action: @escaping () -> Void) -> some View {
        Button {
            action()
        } label: {
            Image(systemName: info.icon)
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
                .foregroundColor(Color.systemGray500)
        }
        .buttonStyle(.plain)
        .frame(width: 28, height: 28)
    }
    
    private func timerContainer() -> some View {
        let wholeTime = voiceManager.covertSecToMinAndHour(
            seconds: projectFileManamger.projectMetadata!.presentationTime
        )
        let progressTime = voiceManager.timer
        
        return HStack {
            // 진행시간
            Text("\(progressTime)")
                .font(Font.systemHeroTtile)
                .fixedSize()
            // 제한시간
            Text("(\(wholeTime))")
                .systemFont(.body)
                .foregroundColor(Color.systemGray300)
                .padding(.trailing, 8)
                .fixedSize()
        }
    }
}

    struct PresentationTimerView_Previews: PreviewProvider {
        static var previews: some View {
            PresentationTimerView()
        }
    }
    
    struct ViewSizeKey: PreferenceKey {
        static var defaultValue = CGSize.zero
        static func reduce(value: inout Value, nextValue: () -> Value) {
            value = nextValue()
        }
    }
