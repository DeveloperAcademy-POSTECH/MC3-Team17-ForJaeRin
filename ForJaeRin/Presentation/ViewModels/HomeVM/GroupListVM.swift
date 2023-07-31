//
//  GroupListVM.swift
//  ForJaeRin
//
//  Created by Yun Dongbeom on 2023/07/26.
//

import Foundation

class GroupListVM: ObservableObject {
    /// 해당 그룹 리스트뷰가 수정중인지(최초 제작 혹은 ellipsis를 통해 활성화됨
    @Published var isExpanded = false
    /// editMode가 켜지면 true, trash.fill 혹은 입력을 모두 하지 않고 취소를 누르면 false
    @Published var tempData = ["", "", "", "-1", "-1"]
    @Published var onDelete = false
    
    let GROUP_TITLE_FIELD_WIDTH: (editMode: CGFloat, nonEditMode: CGFloat) = (editMode: 137, nonEditMode: 173)
    
    let DELETE_BUTTON_INFO = (icon: "trash.fill" , label: "삭제하기")
    
    func resetTempData() {
        tempData = ["", "", "", "-1", "-1"]
    }
}
