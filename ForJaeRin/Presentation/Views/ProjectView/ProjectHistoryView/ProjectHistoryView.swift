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
    var body: some View {
        VStack(spacing: 0) {
            ProjectSummaryView()
//                ProjectHistoryListView()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct ProjectHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectHistoryView()
    }
}
