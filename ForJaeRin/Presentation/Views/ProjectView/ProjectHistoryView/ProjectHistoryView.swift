//
//  ProjectHistoryView.swift
//  ForJaeRin
//
//  Created by Yun Dongbeom on 2023/07/11.
//

import SwiftUI

/**
 프로젝트의 연습 이력을 조회하는 뷰입니다.
 연습 이력에서 제공하는 정보는 다음과 같습니다.
 - 키워드 발화 완료 여부
 - 소요시간 - 전체 / 그룹별
 - 음성 다시듣기 (후순위)
    - 키워드 선택 -> 해당 부분 음성 다시듣기
 */
// MARK: 프로젝트 연습 이력 관리(피드백)를 위한 페이지 뷰
struct ProjectHistoryView: View {
    let data = [
        //[data 가져오기] 내가 말한 키워드 횟수
        (23.0, Color.primary500),
        //[data 가져오기] 말하지 못한 키워드 횟수 = 전체 키워드 갯수 - 내가 말한 키워드 횟수
        (11.0, Color.systemGray100)
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            GeometryReader { geometry in
                ScrollView {
                    VStack(alignment: .leading, spacing: 0) {
                        Text("첫번째 발표연습 기록")
                            .systemFont(.headline)
                            .padding(.bottom, 80)
                        PracticeSummaryView(slices: data)
                            .frame(minHeight: 380)
                        ProjectHistoryListView()
                            .frame(minHeight: 252)
                            .environmentObject(VoiceManager.shared)
                        MissedKeywordListView()
                    }
                    .padding(.vertical, 50)
                    .padding(.horizontal, 72)
                    .frame(
                        maxWidth: .infinity,
                        maxHeight: .infinity,
                        alignment: .topLeading
                    )
                }
                .frame(
                    maxWidth: geometry.size.width,
                    maxHeight: geometry.size.height,
                    alignment: .topLeading
                )
            }
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity
        )
        .background(Color.detailLayoutBackground)
    }
}

struct ProjectHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectHistoryView()
    }
}
