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
    
    public func addPreviousProject() {
        AppFileManager.shared.addPreviousProject(
            codableProjectModel: makeCodableProjectModel(),
            projectURL: projectURL!
        )
    }
    
    public func writePreviousProject() {
        AppFileManager.shared.writePreviousProject()
    }
    
    // ProjectFileManager를 이용해서 CodableProjectModel을 만들어서 전달
    public func makeCodableProjectModel() -> CodableProjectModel {
        
        let codableProjectModel = CodableProjectModel(
            projectMetadata: CodableProjectMetadata(
                projectName: self.projectMetadata!.projectName,
                projectGoal: self.projectMetadata!.projectGoal,
                projectTarget: self.projectMetadata!.projectTarget,
                presentationTime: self.projectMetadata!.presentationTime,
                createAt: DateManager.formatDateToString(date: self.projectMetadata!.creatAt),
                updateAt: DateManager.formatDateToString(date: self.projectMetadata!.updateAt),
                presentationDate: DateManager.formatDateToString(date: self.projectMetadata!.presentationDate)
            ),
            pdfDocumentManager: CodablePDFDocumentManager(
                PDFPages: self.pdfDocument!.PDFPages,
                PDFGroups: self.pdfDocument!.PDFGroups
            ),
            practices: self.practices!
        )
        return codableProjectModel
    }
    
    // CodableProjectModel에 있는 데이터를 이용해서 ProjectFileManager을 만들고 전달
    public func makeProjectModel(codableData: CodableProjectModel, url: URL) {
        self.projectURL = url
        self.projectMetadata = ProjectMetadata(
            projectName: codableData.projectMetadata.projectName,
            projectGoal: codableData.projectMetadata.projectGoal,
            projectTarget: codableData.projectMetadata.projectTarget,
            presentationTime: codableData.projectMetadata.presentationTime,
            creatAt: DateManager.formatStringToDate(date: codableData.projectMetadata.createAt),
            updateAt: Date(),
            presentationDate:
                DateManager.formatStringToDate(date: codableData.projectMetadata.presentationDate)
        )
        self.pdfDocument = PDFDocumentManager(
            url: FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!,
            PDFPages: codableData.pdfDocumentManager.PDFPages,
            PDFGroups: codableData.pdfDocumentManager.PDFGroups
        )
        self.practices = codableData.practices
    }
    
    // MyData -> ProjectFileManager
    func myDataToProjectFileManager(myData: MyData) {
        self.projectURL = myData.url
        
        var stringTime = myData.time
        stringTime.removeLast()
        self.projectMetadata = ProjectMetadata(
            projectName: myData.title,
            projectGoal: myData.purpose,
            projectTarget: myData.target,
            presentationTime: Int(stringTime)!,
            creatAt: Date(),
            updateAt: Date(),
            presentationDate: myData.presentationDate
        )
        
        if let document = self.pdfDocument {
            document.url = myData.url
            document.PDFPages = []
            myData.images.indices.forEach { index in
                print("myData.images.index: \(index)")
                document.PDFPages.append(PDFPage(
                    keywords: myData.keywords[index],
                    script: myData.script[index])
                )
            }
            
            document.PDFGroups = []
            myData.groupData.enumerated().forEach { _, groupData in
                document.PDFGroups.append(PDFGroup(
                    name: groupData[0],
                    range: PDFGroupRange(start: Int(groupData[3])!, end: Int(groupData[4])!),
                    setTime: (Int(groupData[1]) ?? 0) * 60 + (Int(groupData[2]) ?? 0)))
            }
        }
    }
}

struct CodableProjectModel: Codable {
    var projectMetadata: CodableProjectMetadata
    var pdfDocumentManager: CodablePDFDocumentManager
    var practices: [Practice]
}
