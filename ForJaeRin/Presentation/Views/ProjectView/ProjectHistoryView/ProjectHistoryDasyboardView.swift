//
//  ProjectHistoryListView.swift
//  ForJaeRin
//
//  Created by Yun Dongbeom on 2023/07/28.
//

import SwiftUI

struct ProjectHistoryDasyboardView: View {
    @StateObject var vm = ProjectHistoryVM()
    @EnvironmentObject var projectFileManager: ProjectFileManager
    
    var body: some View {
        
        if vm.isHistoryDetailActive {
            ProjectHistoryView(vm: vm)
        } else {
            VStack(alignment: .leading, spacing: 0) {
                historyDashboardTitleView()
                historySummaryView()
                historyListView()
            }
            .padding(.bottom, 50)
            .padding(.horizontal, 72)
            .background(Color.detailLayoutBackground)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        }
    }
    
    private func requestSummaryData(index: Int) -> String {
        switch index {
        case 0:
            return "00년 00월 00일"
        case 1:
            return "00시간 00분"
        case 2:
            return "00회"
        default:
            return "잘못된 요청입니다."
        }
    }
}

extension ProjectHistoryDasyboardView {
    // MARK: - 타이틀
    private func historyDashboardTitleView() -> some View {
        Text("{발표대상}에게 {발표목적}을 전달하기 위한 발표")
            .systemFont(.headline)
            .foregroundColor(Color.systemGray500)
            .padding(.vertical, 50)
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
        .padding(.bottom, 80)
    }
    
    // MARK: - 기록 리스트 링크
    private func historyListView() -> some View {
        VStack(alignment: .leading) {
            Text("연습 기록 다시보기")
                .systemFont(.headline)
                .foregroundColor(Color.systemGray500)
                .padding(.bottom, 24)
            /// 리스트
            VStack {
                historyListHeaer()
                ScrollView(showsIndicators: false) {
                    if let practices = projectFileManager.practices {
                        ForEach(Array(practices.enumerated()), id: \.1.id) { index, practice in
                            historyListItem(index: index, practice: practice)
                        }
                        ForEach(Array(practices.enumerated()), id: \.1.id) { index, practice in
                            historyListItem(index: index, practice: practice)
                        }
                        ForEach(Array(practices.enumerated()), id: \.1.id) { index, practice in
                            historyListItem(index: index, practice: practice)
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
    
    private func historyListHeaer() -> some View {
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
    
    private func historyListItem(index: Int, practice: Practice) -> some View {
        HStack(spacing: 0) {
            // index
            Text("\(index + 1)")
                .systemFont(.body)
                .bold()
                .foregroundColor(Color.systemGray200)
                .frame(maxWidth: 40, maxHeight: 24)
            // date
            Text("\(practice.audioPath)")
                .systemFont(.body)
                .foregroundColor(Color.systemGray500)
                .frame(maxWidth: .infinity)
            // time
            Text("\(practice.progressTime)")
                .systemFont(.body)
                .bold()
                .foregroundColor(Color.systemGray500)
                .frame(maxWidth: .infinity)
            // keyword
            Text("\(practice.saidKeywords.count)")
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
