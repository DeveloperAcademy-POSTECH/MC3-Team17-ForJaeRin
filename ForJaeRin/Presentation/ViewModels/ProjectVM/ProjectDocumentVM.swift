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
            return "연습 준비하기"
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

enum Plans {
    case edit
    case flow
    case practice
    
    var planName: String {
        switch self {
        case .edit:
            return "그룹 수정하기"
        case .flow:
            return "흐름보기"
        case .practice:
            return "연습모드"
        }
    }
    
    var iconName: String {
        switch self {
        case .edit:
            return "selection.pin.in.out"
        case .flow:
            return "chart.bar.doc.horizontal"
        case .practice:
            return "play.fill"
        }
    }
}

class ProjectDocumentVM: ObservableObject {
    let mainTabs: [Tabs] = [.practice, .record]
    let TOOLBAR_HEIGHT:CGFloat = 49
    @Published var isLeftSidebarActive = true
    @Published var currentSection: Plans = .edit
    @Published var currentTab: Tabs = .practice
}
