//
//  ProjectSummaryView.swift
//  ForJaeRin
//
//  Created by Yun Dongbeom on 2023/07/12.
//

import SwiftUI

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
