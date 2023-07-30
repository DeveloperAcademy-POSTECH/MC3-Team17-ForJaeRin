//
//  ProjectHistoryListView.swift
//  ForJaeRin
//
//  Created by Yun Dongbeom on 2023/07/28.
//

import SwiftUI

struct ProjectHistoryDashboardView: View {
    @StateObject var vm = ProjectHistoryVM()
    @EnvironmentObject var myData: MyData
    @EnvironmentObject var projectFileManager: ProjectFileManager
    
    var body: some View {
        if myData.isHistoryDetailActive {
            ProjectHistoryView(vm: vm)
        } else {
            VStack(alignment: .leading, spacing: 0) {
                historyDashboardTitleView()
                historySummaryView()
                historyListView()
            }
            .padding(.bottom, .spacing700)
            .padding(.horizontal, .spacing900)
            .background(Color.detailLayoutBackground)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        }
    }
    
    private func calcPracticeTime(second: Int) -> String {
        DateManager.secondsToTime(seconds: second)
    }
    
    private func parseDateToTitle(fileName: String) -> String {
        var result = ""
        guard let dotIndex = fileName.lastIndex(of: "."),
              let slashIndex = fileName.lastIndex(of: "/") else {return result}
        
        let startIndex = fileName.index(after: slashIndex)
        let endIndex = fileName.index(before: dotIndex)
        let temp = fileName[startIndex...endIndex].split(separator: "at")
        
        let time = temp[1].split(separator: ":")[0] + ":" + temp[1].split(separator: ":")[1]
        var date = ""
        
        Array(temp[0].split(separator: "-").enumerated()).forEach { index, token in
            var _token = token
            
            if index == 0 {
                _token += "년 "
            } else if index == 1 {
                _token += "월 "
            } else {
                _token += "일"
            }
            date += _token
        }
        
        result = date + " " + time
        
        return result
    }
    
    private func requestKeywordsCount(keywords: [Keywords]) -> String {
        let saidKeywords = keywords.flatMap {$0}.count.description
        guard let pdfPages = projectFileManager.pdfDocument?.PDFPages else {return saidKeywords}
        let wholeKeywords = pdfPages.map {$0.keywords }.flatMap {$0}.count.description
        
        return "\(saidKeywords)/\(wholeKeywords)개"
    }
    
    // MARK: - 메타데이터에 데이터 추가 후 작업
    private func requestPracticeDate() -> String {
        guard let metadata = projectFileManager.projectMetadata else {return "잘못된 요청"}
        return DateManager.formatDateToString(date: metadata.presentationDate)
    }
    
    private func requestLimiedTime() -> String {
        guard let metadata = projectFileManager.projectMetadata else {return "잘못된 요청"}
        return "\((metadata.presentationTime / 60).description)분"
    }
    
    private func requestPracticeCount() -> String {
        guard let practices = projectFileManager.practices else {return "잘못된 요청"}
        
        return "\(practices.count)회"
    }
    
    private func requestSummaryData(index: Int) -> String {
        
        switch index {
        case 0:
            return requestPracticeDate()
        case 1:
            return requestLimiedTime()
        case 2:
            return requestPracticeCount()
        default:
            return "잘못된 요청입니다."
        }
    }
}

extension ProjectHistoryDashboardView {
    // MARK: - 타이틀
    private func historyDashboardTitleView() -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("\(myData.target)에게")
                .systemFont(.headline)
                .foregroundColor(Color.systemGray500)
            Text("\(myData.purpose)을 전달하기 위한 발표")
                .systemFont(.headline)
                .foregroundColor(Color.systemGray500)
        }
        .padding(.top, .spacing600)
        .padding(.bottom, .spacing500)
    }
    
    // MARK: - 발표 요약
    private func historySummaryView() -> some View {
        HStack(spacing: 80) {
            // MARK: - 발표 요약 아이템
            ForEach(Array(vm.SUMMARY_INFO_TITLES.enumerated()), id: \.1.self) { index, title in
                VStack(alignment: .leading) {
                    Text("\(title)")
                        .systemFont(.body)
                        .foregroundColor(Color.systemGray400)
                    Text(requestSummaryData(index: index))
                        .systemFont(.headline)
                        .foregroundColor(Color.systemGray500)
                }
            }
        }
        .padding(.bottom, .spacing700)
    }
    
    // MARK: - 기록 리스트
    private func historyListView() -> some View {
        VStack(alignment: .leading) {
            Text("연습 기록 다시보기")
                .systemFont(.headline)
                .foregroundColor(Color.systemGray500)
                .padding(.bottom, 24)
            /// 리스트
            VStack {
                historyListHeader()
                ScrollView(showsIndicators: false) {
                    if let practices = projectFileManager.practices {
                        ForEach(Array(practices.enumerated()), id: \.1.id) { index, practice in
                            historyListItem(index: index, practice: practice)
                                .onTapGesture {
                                    myData.isHistoryDetailActive = true
                                }
                        }
                    }
                }
            }
        }
        .padding(.top, 20)
        .padding(.horizontal, 24)
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity,
            alignment: .topLeading
        )
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.systemWhite)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        )
    }
    
    // MARK: - 기록 리스트 header
    private func historyListHeader() -> some View {
        HStack(spacing: 0) {
            Rectangle()
                .foregroundColor(Color.clear)
                .frame(maxWidth: 40, maxHeight: 24)
            Text("연습 일시")
                .systemFont(.caption1)
                .foregroundColor(Color.systemGray200)
                .frame(maxWidth: .infinity)
            Text("소요 시간")
                .systemFont(.caption1)
                .foregroundColor(Color.systemGray200)
                .frame(maxWidth: .infinity)
            Text("말한 키워드 개수")
                .systemFont(.caption1)
                .foregroundColor(Color.systemGray200)
                .frame(maxWidth: .infinity)
            Rectangle()
                .foregroundColor(Color.clear)
                .frame(maxWidth: 20, maxHeight: 24)
        }
        .frame(maxWidth: .infinity, maxHeight: 24)
        .padding(.bottom, 8)
        .border(width: 1, edges: [.bottom], color: Color.systemGray100)
    }
    
    // MARK: - 히스토리 리스트의 아이템
    private func historyListItem(index: Int, practice: Practice) -> some View {
        HStack(spacing: 0) {
            // index
            Text("\(index + 1)")
                .systemFont(.body)
                .bold()
                .foregroundColor(Color.systemGray200)
                .frame(maxWidth: 40, maxHeight: 24)
            // date
            Text("\(parseDateToTitle(fileName: practice.audioPath.description))")
                .systemFont(.body)
                .foregroundColor(Color.systemGray500)
                .frame(maxWidth: .infinity)
            // time
            Text("\(calcPracticeTime(second: practice.progressTime))")
                .systemFont(.body)
                .bold()
                .foregroundColor(Color.systemGray500)
                .frame(maxWidth: .infinity)
            // keyword
            Text(requestKeywordsCount(keywords: practice.saidKeywords))
                .systemFont(.body)
                .bold()
                .foregroundColor(Color.systemGray500)
                .frame(maxWidth: .infinity)
            Button {
                vm.isHistoryDetailActive.toggle()
            } label: {
                Image(systemName: "chevron.right")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(Color.systemGray200)
                    .frame(maxWidth: 8, maxHeight: 16)
            }
            .buttonStyle(.plain)
            .frame(maxWidth: 20, maxHeight: 24)
        }
        .padding(.vertical, 24)
        .frame(maxWidth: .infinity)
        .border(width: 1, edges: [.bottom], color: Color.systemGray100)
    }
}

struct ProjectHistoryDasyboardView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectHistoryListView()
    }
}
