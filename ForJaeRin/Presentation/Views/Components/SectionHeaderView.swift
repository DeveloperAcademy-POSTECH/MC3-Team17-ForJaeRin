//
//  SectionHeaderView.swift
//  ForJaeRin
//
//  Created by Yun Dongbeom on 2023/07/29.
//

import SwiftUI

/// 컨테이너의 상단 - 헤더에 해당하는 반복적인 레이아웃에 사용되는 뷰입니다.
/// 구성은 타이틀 .headline, 서브타이틀 .body로 구성되어 있고 서브타이틀은 옵션입니다.
struct SectionHeaderView: View {
    var info: SectionHeaderInfo = (title: "타이틀", subTitle: nil)
    
    var body: some View {
        VStack(alignment: .leading, spacing: .spacing100) {
            Text(info.title)
                .font(.systemHeadline)
                .foregroundColor(Color.systemGray500)
            if let subTitle = info.subTitle {
                Text(subTitle)
                    .foregroundColor(Color.systemGray300)
                    .font(.body)
            }
        }
        .multilineTextAlignment(.leading)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct SectionHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        SectionHeaderView()
    }
}
