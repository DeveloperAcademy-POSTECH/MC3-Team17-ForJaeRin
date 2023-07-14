//
//  ProjectPlanView.swift
//  ForJaeRin
//
//  Created by Yun Dongbeom on 2023/07/14.
//

import SwiftUI

enum GroupColor: CaseIterable {
    case groupPurple
    case groupYellow
    case groupGreen
    case groupPink
    case groupOrange
    case groupBlue
    case groupGray
    
    var color: Color {
        switch self {
        case .groupPurple:
            return Color.groupPurple
        case .groupYellow:
            return Color.groupYellow
        case .groupGreen:
            return Color.groupGreen
        case .groupPink:
            return Color.groupPink
        case .groupOrange:
            return Color.groupOrange
        case .groupBlue:
            return Color.groupBlue
        case .groupGray:
            return Color.groupGray
        }
    }
}

struct ProjectPlanView: View {
    @State var values = [
        "a", "b", "c", "d",
        "e", "f", "g"
    ]
    @State var isHovering: Bool = false
    
    var body: some View {
        VStack {
//            PresentationPageList(pdfDocument: PDFDocu)
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct ProjectPlanView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectPlanView()
    }
}
