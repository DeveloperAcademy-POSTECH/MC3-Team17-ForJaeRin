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
}

struct CodableProjectModel: Codable {
    var projectMetadata: CodableProjectMetadata
    var pdfDocumentManager: CodablePDFDocumentManager
    var practices: [String]
}
