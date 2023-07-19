//
//  AppFileDocument.swift
//  ForJaeRin
//
//  Created by Yun Dongbeom on 2023/07/17.
//

import Foundation
import UniformTypeIdentifiers
import SwiftUI

// MARK: 문서 타입 정의
extension UTType {
    static let kkoDocument = UTType(exportedAs: "com.kkojangro.kko")
}

final class KkoDocument: ReferenceFileDocument {

    typealias Snapshot = KkoProject
    
    @Published var kkoProject: KkoProject
    
    static var readableContentTypes: [UTType] { [.kkoDocument] }
    
    func snapshot(contentType: UTType) throws -> KkoProject {
        kkoProject // Make a copy.
    }
    
    // 새로운 프로젝트 열기 - 아직 실제로 생성하지 않음
    init() {
        kkoProject = KkoProject.sample
    }
    
    // MARK: 파일로 불러오기
    init(configuration: ReadConfiguration) throws {
        guard let data = configuration.file.regularFileContents
        else {
            throw CocoaError(.fileReadCorruptFile)
        }
        self.kkoProject = try JSONDecoder().decode(KkoProject.self, from: data)
    }
    
    // MARK: 파일로 저장
    func fileWrapper(snapshot: KkoProject, configuration: WriteConfiguration) throws -> FileWrapper {
        let data = try JSONEncoder().encode(snapshot)
        let fileWrapper = FileWrapper(regularFileWithContents: data)
        return fileWrapper
    }
}
