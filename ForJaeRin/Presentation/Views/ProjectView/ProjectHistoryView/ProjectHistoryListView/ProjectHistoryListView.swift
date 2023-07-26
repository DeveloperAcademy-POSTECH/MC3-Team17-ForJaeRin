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
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("첫번째 발표연습 기록")
                .systemFont(.headline)
            listenAgain()
                .frame(maxWidth: .infinity, maxHeight: 252)
                .background(Color.systemWhite)
                .cornerRadius(12)
        }
        .padding(.horizontal, 72)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .border(.blue, width: 2)
    }
}

extension ProjectHistoryListView {
    // MARK: 구간별 다시듣기
    private func listenAgain() -> some View {
        VStack(alignment: .leading, spacing: 36) {
            VStack(alignment: .leading, spacing: 8) {
                Text("구간 별 다시듣기")
                    .font(.systemHeadline)
                    .foregroundColor(.systemGray500)
                Text("원하는 그룹을 클릭하면 그 그룹부터 다시 들을 수 있어요")
                    .font(.systemCaption1)
                    .foregroundColor(.systemGray400)
            }
            .border(.red)
            .padding([.top, .leading], 28)
            HStack(alignment: .top, spacing: 20) {
                Image(systemName: "arrowtriangle.forward.fill")
                    .frame(width: 17.88, height: 20)
                    .foregroundColor(.systemGray500)
                    .padding(.top, 53)
                GeometryReader { geometry in
                    let wholeWidthSize = geometry.size.width // 전체 width
                    ZStack {
                        VStack(spacing: 8) {
                            HStack {
                                Text("00:00")
                                    .font(.systemCaption1)
                                    .foregroundColor(.systemGray300)
                                Spacer()
                                Text(vm.secondsToTime(seconds: projectFileManager.practices![0].progressTime))
                                    .font(.systemCaption1)
                                    .foregroundColor(.systemGray300)
                            }
                            speechGroupBlockView(wholeWidthSize: wholeWidthSize)
                            speechGroupTextView(wholeWidthSize: wholeWidthSize)
                        }
                        .padding(.top, 25)
                        markerView()
                    }.onTapGesture(coordinateSpace: .local) { location in
                        print("Tapped at \(location)")
                        print(Double(location.x) / Double(wholeWidthSize) * Double(projectFileManager.practices![0].progressTime))
                        replayVoiceManager.playRecording(
                            audioPath: AppFileManager.shared.directoryPath.appendingPathComponent(gettingAudioPath(path: projectFileManager.practices![0].audioPath),
                            conformingTo: .mpeg4Audio), time: Double(location.x) / Double(wholeWidthSize) * Double(projectFileManager.practices![0].progressTime))
                    }
                }
            }.border(.red)
            .padding(.horizontal, 28)
        }
    }
    private func markerView() -> some View {
        VStack(alignment: .center, spacing: 1) {
            Text("07:26")
                .font(Font.custom(Pretendard.semibold.fontName, size: 14))
            ZStack(alignment: .top) {
                Image(systemName: "arrowtriangle.down.fill")
                    .frame(width: 16, height: 15.55)
                    .foregroundColor(.systemGray500)
                Rectangle()
                    .frame(width: 2, height: 56)
                    .foregroundColor(.systemGray500)
                    .padding(.top, 4)
            }
        }
    }
    
    func gettingAudioPath(path: URL) -> String {
        let sourceURL = path
        let pdfName = path.absoluteString.components(separatedBy: "/").last!
        return pdfName
    }
    
    private func speechGroupBlockView(wholeWidthSize: CGFloat) -> some View {
        HStack(spacing: 0) {
            ForEach(
                Array(
                    projectFileManager.practices![0]
                        .speechRanges.enumerated()), id: \.0.self) { index, speechRange in
                    let size = vm.calcGroupBlockSize(
                        percent: getGroupVolumn(index: index),
                        whole: wholeWidthSize)
                            Rectangle()
                                .fill(GroupColor.allCases[speechRange.group].color)
                                .frame(maxWidth: size, maxHeight: 20, alignment: .center)
                            if index != projectFileManager.practices![0]
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
                    projectFileManager.practices![0]
                        .speechRanges.enumerated()), id: \.0.self) { index, speechRange in
                    let size = vm.calcGroupBlockSize(
                        percent: getGroupVolumn(index: index),
                        whole: wholeWidthSize
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
        let whole = projectFileManager.practices![0].progressTime // 전체 발표 길이
        var part = 0
        if index == projectFileManager.practices![0].speechRanges.count - 1 {
            part = projectFileManager.practices![0].progressTime -
            projectFileManager.practices![0].speechRanges[index].start
        } else {
            part = projectFileManager.practices![0].speechRanges[index + 1].start -
            projectFileManager.practices![0].speechRanges[index].start
        }
        return CGFloat(Double(part * 100) / Double(whole))
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
