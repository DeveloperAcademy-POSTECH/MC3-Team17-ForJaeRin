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
    
    var text: Color {
        switch self {
        case .groupPurple:
            return Color.groupPurpleText
        case .groupYellow:
            return Color.groupYellowText
        case .groupGreen:
            return Color.groupGreenText
        case .groupPink:
            return Color.groupPinkText
        case .groupOrange:
            return Color.groupOrangeText
        case .groupBlue:
            return Color.groupBlueText
        case .groupGray:
            return Color.groupGrayText
        }
    }
}

struct ProjectPlanView: View {
    @State private var leftPaneWidth: CGFloat = 200
    @EnvironmentObject var projectFileManager: ProjectFileManager

    var body: some View {
        VStack(spacing: 0) {
            PresentationPageList(
                pdfDocumentPages: projectFileManager.pdfDocument!.PDFPages
            )
            .background(Color.detailLayoutBackground)
            .scrollContentBackground(.hidden)
        }
        .padding(.leading, 92)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct ProjectPlanView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectPlanView()
    }
}
