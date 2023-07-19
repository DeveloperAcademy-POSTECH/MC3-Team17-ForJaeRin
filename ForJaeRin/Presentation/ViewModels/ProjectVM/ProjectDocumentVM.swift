//
//  ProjectDocumentVM.swift
//  ForJaeRin
//
//  Created by Yun Dongbeom on 2023/07/19.
//

import Foundation

enum Tabs {
    case practice
    case record
    
    var tabName: String {
        switch self {
        case .practice:
            return "연습하기"
        case .record:
            return "연습 기록보기"
        }
    }
    
    var iconName: String {
        switch self {
        case .practice:
            return "folder.fill"
        case .record:
            return "doc.richtext.fill"
        }
    }
}

class ProjectDocumentVM: ObservableObject {
    let mainTabs: [Tabs] = [.practice, .record]
    @Published var isLeftSidebarActive = true
}
