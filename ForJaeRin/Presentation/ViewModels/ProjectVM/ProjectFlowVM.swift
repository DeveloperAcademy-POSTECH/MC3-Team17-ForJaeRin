//
//  ProjectFlowVM.swift
//  ForJaeRin
//
//  Created by Yun Dongbeom on 2023/07/23.
//

import Foundation

class ProjectFlowVM: ObservableObject {
    @Published var selectedGroup = 0
    
    let TOP_TEXT_INFO: SectionHeaderInfo = (
        title: "그룹 별 키워드 확인하기",
        subTitle: "원하는 그룹을 클릭하면 키워드를 확인할 수 있어요"
    )
    
    let ICON_NAME = "checkmark.circle.fill"
    
    func calcGroupBlockSize(percent: CGFloat, whole: CGFloat) -> CGFloat {
        percent * (whole / 100)
    }
}
