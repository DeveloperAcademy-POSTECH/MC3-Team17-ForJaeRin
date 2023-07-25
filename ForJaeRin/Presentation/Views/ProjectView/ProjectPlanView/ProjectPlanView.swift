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
            if vm.currentSection == .edit {
                if isViewReady {
                    PresentationPageList(
                        pdfDocumentPages: projectFileManager.pdfDocument!.PDFPages
                    )
                    .background(Color.detailLayoutBackground)
                    .scrollContentBackground(.hidden)
                }
            } else if vm.currentSection == .flow {
                ProjectFlowView()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear {
            isViewReady = true
        }
    }
}

struct ProjectPlanView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectPlanView(vm: ProjectDocumentVM())
    }
}
