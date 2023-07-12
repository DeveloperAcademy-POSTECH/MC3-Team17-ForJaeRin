//
//  SplitLayoutView+Extension.swift
//  ForJaeRin
//
//  Created by Yun Dongbeom on 2023/07/11.
//

import Foundation

extension SplitLayoutView {
    enum TabColumns {
        case single
        case double
        case triple
    }

    enum TabContents {
        case home
        case present
        case history
        case settings
        
        var contentsName: String {
            switch self {
            case .home:
                return "Home"
            case .present:
                return "Present"
            case .history:
                return "History"
            case .settings:
                return "Settings"
            }
        }
        
        var column: TabColumns {
            switch self {
            case .home:
                return .single
            case .present:
                return .double
            case .history:
                return .single
            case .settings:
                return .single
            }
        }
    }
        
    enum MainTabs {
        case home
        case project
        case settings
        
        var tabName: String {
            switch self {
            case .home:
                return "Home"
            case .project:
                return "Project"
            case .settings:
                return "Settings"
            }
        }
        
        var tabContents: [TabContents] {
            switch self {
            case .home:
                return [.home]
            case .project:
                return [.present, .history]
            case .settings:
                return [.settings]
            }
        }
    }
}
