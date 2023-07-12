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
    @State private var pogPosition = CGPoint()
    @State private var size = CGSize.zero
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
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
                    Spacer()
                    // timer
                    HStack {
                        // 진행시간
                        Text("01 : 00")
                        // 제한시간
                        Text("02 : 00")
                    }
                }
                .padding(8)
                .frame(maxWidth: 400, maxHeight: 80, alignment: .center)
                .background(Color.gray)
                .border(.blue)

            }
            .background(GeometryReader {
                Color.clear
                    .preference(key: ViewSizeKey.self, value: $0.frame(in: .local).size)
            })
            .onPreferenceChange(ViewSizeKey.self) {
                self.size = $0
            }
            .position(pogPosition)
            .animation(.linear, value: pogPosition)
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
