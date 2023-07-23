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
    @State private var pogPosition = CGPoint()
    @State private var isAnimationReady = false
    @State private var size = CGSize.zero {
        didSet {
            print("size", size)
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                HStack {
                    HStack(spacing: 32) {
                        Button {
                            print("Play.fill")
                            voiceManager.startRecording()
                        } label: {
                            Image(systemName: "play.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                                .foregroundColor(Color.systemGray200)
                        }
                        .buttonStyle(.plain)
                        .frame(width: 28, height: 28)
                        Button {
                            print("Pause")
                            voiceManager.stopRecording(index: 0)
                        } label: {
                            Image(systemName: "pause.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                                .foregroundColor(Color.systemGray500)
                        }
                        .buttonStyle(.plain)
                        .frame(width: 28, height: 28)
                        Button {
                            print("Play")
                            voiceManager.playRecording()
                        } label: {
                            Image(systemName: "pause.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                                .foregroundColor(Color.systemGray500)
                        }
                        .buttonStyle(.plain)
                        .frame(width: 28, height: 28)
                    }
                    .padding(.vertical, 18)
                    .padding(.horizontal, 28)
                    Spacer()
                    // timer
                    HStack {
                        // 진행시간
                        Text("\(voiceManager.timer)")
                            .font(Font.systemHeroTtile)
                            .fixedSize()
                        // 제한시간
                        Text("(2 : 00)")
                            .systemFont(.body)
                            .foregroundColor(Color.systemGray300)
                            .padding(.trailing, 8)
                            .fixedSize()
                    }
                }
                .padding(.vertical, 8)
                .padding(.horizontal, 16)
                .frame(maxWidth: 357, maxHeight: 80, alignment: .center)
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
                        //                                .inset(by: EdgeInsets(top: size.height / 2.0, leading: size.width / 2.0, bottom: size.height / 2.0, trailing: size.width / 2.0))
                        //
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
