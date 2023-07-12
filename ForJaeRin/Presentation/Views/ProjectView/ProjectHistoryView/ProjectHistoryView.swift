//
//  ProjectHistoryView.swift
//  ForJaeRin
//
//  Created by Yun Dongbeom on 2023/07/11.
//

import SwiftUI

struct ProjectHistoryView: View {
    var body: some View {
        VStack(spacing: 0) {
            ProjectSummaryView()
            ProjectHistoryListView()
        }
        .padding(32)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .border(.red, width: 2)
    }
}

struct ProjectHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectHistoryView()
    }
}
