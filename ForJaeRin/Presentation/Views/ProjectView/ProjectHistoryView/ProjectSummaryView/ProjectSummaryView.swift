//
//  ProjectSummaryView.swift
//  ForJaeRin
//
//  Created by Yun Dongbeom on 2023/07/12.
//

import SwiftUI

/**
 어떤 결과를 요약해서 보여줄 것인지, 정보 확인이 필요합니다.
 */
// MARK: 프로젝트 연습 결과 요약 뷰
struct ProjectSummaryView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("연습 요약보기")
        }
        .frame(maxWidth: .infinity, maxHeight: 252)
        .border(.red, width: 2)
    }
}

struct ProjectSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectSummaryView()
    }
}
