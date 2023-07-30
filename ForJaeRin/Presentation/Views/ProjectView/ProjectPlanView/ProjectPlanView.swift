//
//  ProjectPlanView.swift
//  ForJaeRin
//
//  Created by Yun Dongbeom on 2023/07/14.
//

import SwiftUI

struct ProjectPlanView: View {
    @State private var leftPaneWidth: CGFloat = 200
    @EnvironmentObject var projectFileManager: ProjectFileManager
    @State private var isViewReady = false
    @ObservedObject var vm: ProjectDocumentVM
    @EnvironmentObject var myData: MyData
    
    var body: some View {
        VStack(spacing: 0) {
            if vm.currentSection == .flow {
                ProjectFlowView()
                    .onDisappear {
                        vm.currentSection = .edit
                    }
            } else {
                if isViewReady {
                    if let document = projectFileManager.pdfDocument {
                        PresentationPageList(
                            pdfDocumentPages: document.PDFPages,
                            lastIndexes: enteredKeywordCount()
                        )
                        .background(Color.detailLayoutBackground)
                        .scrollContentBackground(.hidden)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear {
            isViewReady = true
        }
    }
    private func enteredKeywordCount() -> [Int] {
        var lastIndexes: [Int] = []
        for page in 0..<myData.images.count {
            var answer = 0
            for allKeyword in myData.keywords[page] where allKeyword != "" {
                answer += 1
            }
            if answer > 0 {
                answer -= 1
            }
            lastIndexes.append(answer)
        }
        return lastIndexes
    }
}

struct ProjectPlanView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectPlanView(vm: ProjectDocumentVM())
    }
}
