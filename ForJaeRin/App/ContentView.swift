//
//  ContentView.swift
//  ForJaeRin
//
//  Created by Yun Dongbeom on 2023/07/06.
//

import SwiftUI

struct ContentView: View {
    @State private var path = NavigationPath()
    @EnvironmentObject var projectFileManager: ProjectFileManager
    
    var body: some View {
        VStack(spacing: 0) {
            Rectangle()
                .frame(maxWidth: .infinity, minHeight: 1, maxHeight: 1)
                .foregroundColor(Color.systemGray100)
            NavigationStack {
                    SplitLayoutView()
            }
        }
        .background(Color.systemWhite)
        .onAppear {
            initProject()
        }
    }
    
    // MARK: 테스트용 데이터 가져와서 넣기
    private func initProject() {
        do {
            let data = try Data(contentsOf: AppFileManager.shared.url!)
            let file = try AppFileManager.shared.decodeJson(from: data)
            
            let PDFPages = file.projectDocument.PDFPages.map { pdfpage in
                PDFPage(keywords: pdfpage.keywords, script: pdfpage.script)
            }
            let PDFGroups = file.projectDocument.PDFGroups.map { pdfGroup in
                PDFGroup(
                    name: pdfGroup.name,
                    range: (pdfGroup.range.start, pdfGroup.range.end),
                    setTime: pdfGroup.setTime)
            }
            
            projectFileManager.pdfDocument = PDFDocumentManager(
                url: AppFileManager.shared.url!,
                PDFPages: PDFPages,
                PDFGroups: PDFGroups)
            
            projectFileManager.projectMetadata = ProjectMetadata(
                projectName: file.projectMetadata.projectName,
                projectGoal: file.projectMetadata.projectGoal,
                presentationTime: file.projectMetadata.presentationTime,
                creatAt: Date())
            
            projectFileManager.practices = []
        } catch {
            print("hhh")
            print("Error decoding JSON: \(error)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
