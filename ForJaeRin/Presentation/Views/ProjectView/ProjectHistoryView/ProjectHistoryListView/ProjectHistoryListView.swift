//
//  ProjectHistoryListView.swift
//  ForJaeRin
//
//  Created by Yun Dongbeom on 2023/07/12.
//

import SwiftUI

// MARK: 프로젝트 연습 이력 리스트 뷰
struct ProjectHistoryListView: View {
    let currencyStyle = Decimal.FormatStyle.Currency(code: "USD")
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("연습 기록보기")
                .systemFont(.subTitle)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .border(.red, width: 2)
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
