//
//  ProjectFileManager.swift
//  ForJaeRin
//
//  Created by Yun Dongbeom on 2023/07/14.
//

import Foundation

/// String배열 대신 사용할 키워드 - 최대 7개
typealias Keywords = [String]

final class ProjectFileManager: ObservableObject {
    /// 프로젝트 디렉토리 경로
    var projectURL: URL?
    /// 프로젝트 메타 데이터
    @Published
    var projectMetadata: ProjectMetadata?
    /// PDF 정보
    @Published
    var pdfDocument: PDFDocumentManager?
    /// 연습 이력
    @Published
    var practices: [Practice]?
        
    // MARK: 파일로 변환
    public func exportFile() {
        AppFileManager.shared.encodeJSON(
            codableProjectModel: makeCodableProjectModel(),
            projectURL: projectURL!
        )
    }
    
    public func savePreviousProject() {
        print("ProjectFileManager에서 savaPreviousProject 시작")
        AppFileManager.shared.savePreviousProject(
            codableProjectModel: makeCodableProjectModel(),
            projectURL: projectURL!
        )
        print("ProjectFileManager에서 savaPreviousProject 끝")
    }
    
    // ProjectFileManager를 이용해서 CodableProjectModel을 만들어서 전달
    public func makeCodableProjectModel() -> CodableProjectModel {
        let codableProjectModel = CodableProjectModel(
            projectMetadata: CodableProjectMetadata(
                projectName: self.projectMetadata!.projectName,
                projectGoal: self.projectMetadata!.projectGoal,
                presentationTime: self.projectMetadata!.presentationTime,
                createAt: DateManager.formatDateToString(date: self.projectMetadata!.creatAt)
            ),
            pdfDocumentManager: CodablePDFDocumentManager(
                PDFPages: self.pdfDocument!.PDFPages,
                PDFGroups: self.pdfDocument!.PDFGroups
            ),
            practices: []
        )
        return codableProjectModel
    }
    
    // CodableProjectModel에 있는 데이터를 이용해서 ProjectFileManager을 만들고 전달
    public func makeProjectModel(codableData: CodableProjectModel, url: URL){
        
//        let projectFileManager = ProjectFileManager()
//        projectFileManager.projectMetadata = ProjectMetadata(
//            projectName: codableData.projectMetadata.projectName,
//            projectGoal: codableData.projectMetadata.projectGoal,
//            projectTarget: codableData.projectMetadata.projectGoal,
//            presentationTime: codableData.projectMetadata.presentationTime,
//            creatAt: Date()
//        )
//        projectFileManager.pdfDocument = PDFDocumentManager(
//            url: FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!,
//            PDFPages: codableData.pdfDocumentManager.PDFPages,
//            PDFGroups: codableData.pdfDocumentManager.PDFGroups
//        )
//        projectFileManager.practices = []
        self.projectURL = url
        self.projectMetadata = ProjectMetadata(
            projectName: codableData.projectMetadata.projectName,
            projectGoal: codableData.projectMetadata.projectGoal,
            projectTarget: codableData.projectMetadata.projectGoal,
            presentationTime: codableData.projectMetadata.presentationTime,
            creatAt: Date()
        )
        self.pdfDocument = PDFDocumentManager(
            url: FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!,
            PDFPages: codableData.pdfDocumentManager.PDFPages,
            PDFGroups: codableData.pdfDocumentManager.PDFGroups
        )
        self.practices = []
        
    }
}

struct CodableProjectModel: Codable {
    var projectMetadata: CodableProjectMetadata
    var pdfDocumentManager: CodablePDFDocumentManager
    var practices: [String]
}
