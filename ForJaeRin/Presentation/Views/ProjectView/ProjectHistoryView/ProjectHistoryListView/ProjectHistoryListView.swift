//
//  ProjectHistoryListView.swift
//  ForJaeRin
//
//  Created by Yun Dongbeom on 2023/07/12.
//

import Foundation
import SwiftUI
import Pretendard

// MARK: 프로젝트 연습 이력 리스트 뷰
struct ProjectHistoryListView: View {
    @StateObject var vm = ProjectHistoryVM()
    @EnvironmentObject var replayVoiceManager: VoiceManager
    @EnvironmentObject var projectFileManager: ProjectFileManager
    /// 음성 재생될 시점(초)
    @State var currentTime: CGFloat = 0.0
    /// 음성 재생중
    @State var playing: Bool = false
    /// 녹음을 재생하면 시간이 흐름
    @State var timer: Timer?
    /// marker의 위치
    @State private var location: CGPoint = CGPoint(x: 0, y: 50)
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            listenAgain()
                .frame(maxWidth: .infinity)
                .background(Color.systemWhite)
                .cornerRadius(12)
        }
        .onChange(of: currentTime, perform: { _ in
            if currentTime >= CGFloat(projectFileManager.practices!.last!.progressTime) {
                timer?.invalidate()
                playing = false
                currentTime = CGFloat(projectFileManager.practices!.last!.progressTime)
            } else if currentTime < 0 {
                currentTime = 0.0
            }
        })
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }
}

extension ProjectHistoryListView {
    // MARK: 구간별 다시듣기
    /// 재생 중이라면,
    /// Tap -> 정지, currentTime 이동, 재생
    /// Drag and Drop
    /// Drag 시작 -> 정지
    /// Drop -> currentTime 이동, 재생
    /// Drop 위치 잘 판별할 것(x축)
    /// 정지 중이라면,
    /// currentTime만 옮긴다.(Tap, Drag and Drop 모두)
    
    private func listenAgain() -> some View {
        VStack(alignment: .leading, spacing: 36) {
            // 텍스트
            VStack(alignment: .leading, spacing: 8) {
                Text("구간 별 다시듣기")
                    .font(.systemHeadline)
                    .foregroundColor(.systemGray500)
                Text("원하는 그룹을 클릭하면 그 그룹부터 다시 들을 수 있어요")
                    .systemFont(.body)
                    .foregroundColor(.systemGray400)
            }
            .padding([.top, .leading], 28)
            HStack(alignment: .top, spacing: 16) {
                // 재생 및 일시정지 버튼
                Button {
                    if playing {
                        replayVoiceManager.pauseRecording()
                        timer?.invalidate()
                    } else {
                        playVoice(time: currentTime)
                    }
                    playing.toggle()
                } label: {
                    Image(systemName: playing ? "pause.fill" : "play.fill")
                        .resizable()
                        .frame(width: 16, height: 20)
                        .foregroundColor(.systemGray500)
                        .padding(.top, 53)
                }.buttonStyle(.plain)
                    .keyboardShortcut(.space, modifiers: []) 
            Text("00:00")
                .font(.systemCaption1)
                .foregroundColor(.systemGray300)
                .padding(.top, 53)
                GeometryReader { geometry in
                    let wholeWidthSize = geometry.size.width // 전체 width
                    ZStack(alignment: .topLeading) {
                        VStack(spacing: 8) {
                            speechGroupBlockView(wholeWidthSize: wholeWidthSize)
                            /// Tap
                            /// 재생중이라면, 정지 후 currentTime 이동 후 재생
                            /// 정지중이라면, currentTime 이동
                                .onTapGesture(coordinateSpace: .local) { location in
                                    if playing {
                                        replayVoiceManager.pauseRecording()
                                        timer?.invalidate()
                                        currentTime = locationToTime(
                                            location: location.x,
                                            size: wholeWidthSize
                                        )
                                        playVoice(time: currentTime)
                                    } else {
                                        currentTime = locationToTime(
                                            location: location.x,
                                            size: wholeWidthSize
                                        )
                                    }
                            }
                            speechGroupTextView(wholeWidthSize: wholeWidthSize)
                        }.padding(.top, 53)
                        markerView()
                            .padding(.bottom, 17)
                            .position(x: timeToOffset(time: currentTime, size: wholeWidthSize), y: 50)
                        /// Gesture
                        /// 재생중이라면, .onChanged에 정지
                            .gesture(
                                DragGesture()
                                    .onChanged { value in
                                        if playing {
                                            replayVoiceManager.pauseRecording()
                                            timer?.invalidate()
                                            self.location.x = value.location.x
                                            currentTime = locationToTime(
                                                location: value.location.x,
                                                size: wholeWidthSize
                                            )
                                        } else {
                                            self.location.x = value.location.x
                                            currentTime = locationToTime(
                                                location: value.location.x,
                                                size: wholeWidthSize
                                            )
                                        }
                                    }
                                    .onEnded { _ in
                                        if playing {
                                            playVoice(time: currentTime)
                                        }
                                    }
                            )
                    }
                }
                Text(vm.secondsToTime(seconds: projectFileManager.practices!.last!.progressTime))
                    .font(.systemCaption1)
                    .foregroundColor(.systemGray300)
                    .padding(.top, 53)
            }
            .frame(maxHeight: 131)
            .padding(.horizontal, 28)
        }
    }
    
    private func markerView() -> some View {
        VStack(alignment: .center, spacing: 1) {
            Text(vm.secondsToTime(seconds: Int(currentTime)))
                .font(Font.custom(Pretendard.semibold.fontName, size: 14))
                .frame(height: 20)
            ZStack(alignment: .top) {
                Image(systemName: "arrowtriangle.down.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 12)
                    .foregroundColor(.systemGray500)
                Rectangle()
                    .frame(width: 2, height: 56)
                    .foregroundColor(.systemGray500)
                    .padding(.top, 4)
            }
        }
    }
    
    private func speechGroupBlockView(wholeWidthSize: CGFloat) -> some View {
        HStack(spacing: 0) {
            ForEach(
                Array(
                    projectFileManager.practices!.last!
                        .speechRanges.enumerated()), id: \.0.self) { index, speechRange in
                    let size = vm.calcGroupBlockSize(
                        percent: getGroupVolumn(index: index),
                        whole: blankCount(size: wholeWidthSize)
                    )
                            /// 색은 currentTime에 따라
                            Rectangle()
                                .fill(checkMarkerPosition(index: index)
                                      ? GroupColor.allCases[speechRange.group].color : .systemGray100)
                                .frame(maxWidth: size, maxHeight: 20, alignment: .center)
                            if index != projectFileManager.practices!.last!
                                .speechRanges.count - 1 {
                                Rectangle()
                                    .fill(Color.systemWhite)
                                    .frame(maxWidth: 4, maxHeight: 20, alignment: .center)
                            }
            }
        }
        .cornerRadius(8)
        .frame(maxWidth: wholeWidthSize)
        
    }
    private func speechGroupTextView(wholeWidthSize: CGFloat) -> some View {
        HStack(spacing: 4) {
            ForEach(
                Array(
                    projectFileManager.practices!.last!
                        .speechRanges.enumerated()), id: \.0.self) { index, speechRange in
                    let size = vm.calcGroupBlockSize(
                        percent: getGroupVolumn(index: index),
                        whole: blankCount(size: wholeWidthSize)
                        )
                VStack {
                    Text((projectFileManager.pdfDocument?.PDFGroups[speechRange.group].name)!)
                        .font(.systemCaption2)
                        .foregroundColor(.systemGray300)
                }
                .frame(maxWidth:size, alignment: .center)
            }
        }
        .frame(maxWidth: wholeWidthSize)
    }
    
    private func getGroupVolumn(index: Int) -> CGFloat {
        let whole = projectFileManager.practices!.last!.progressTime // 전체 발표 길이
        var part = 0
        if index == projectFileManager.practices!.last!.speechRanges.count - 1 {
            part = projectFileManager.practices!.last!.progressTime -
            projectFileManager.practices!.last!.speechRanges[index].start
        } else {
            part = projectFileManager.practices!.last!.speechRanges[index + 1].start -
            projectFileManager.practices!.last!.speechRanges[index].start
        }
        return CGFloat(Double(part * 100) / Double(whole))
    }
    
    private func timeToOffset(time: CGFloat, size: CGFloat) -> CGFloat {
        return Double(time) * Double(size) / Double(projectFileManager.practices!.last!.progressTime)
    }
    
    private func blankCount(size: CGFloat) -> CGFloat {
        return size - 4 * (CGFloat(projectFileManager.practices!.last!.speechRanges.count) - 1)
    }
    
    private func locationToTime(location: CGFloat, size: CGFloat) -> CGFloat {
        return Double(projectFileManager.practices!.last!.progressTime) * Double(location) / Double(size)
    }
    
    private func playVoice(time: CGFloat) {
        replayVoiceManager.playRecording(audioPath: AppFileManager.shared.directoryPath
            .appendingPathComponent(vm.gettingAudioPath(path: projectFileManager.practices!.last!.audioPath),
                                    conformingTo: .mpeg4Audio), time: time)
        timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { _ in
            if playing {
                currentTime += 0.05
            }
        }
    }
    
    private func checkMarkerPosition(index: Int) -> Bool {
        if index == projectFileManager.practices!.last!.speechRanges.count - 1 {
            return CGFloat(projectFileManager.practices!.last!
                    .speechRanges[index].start) <= currentTime
            && currentTime <= CGFloat(projectFileManager.practices!.last!.progressTime)
        }
        return CGFloat(projectFileManager.practices!.last!
            .speechRanges[index].start) <= currentTime
        && currentTime <= CGFloat(projectFileManager.practices!.last!
            .speechRanges[index + 1].start)
    }
}

struct ProjectHistoryListView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectHistoryListView()
    }
}

struct Purchase: Identifiable {
    let price: Decimal
    let id = UUID()
}
