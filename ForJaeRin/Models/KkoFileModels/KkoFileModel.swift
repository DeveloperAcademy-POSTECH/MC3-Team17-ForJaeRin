//
//  KkoFileModels.swift
//  ForJaeRin
//
//  Created by Yun Dongbeom on 2023/07/17.
//

import Foundation

struct KkoProject: Identifiable, Codable {
    var id = UUID()
    var path: URL
    var title: String
    var createAt = Date()
}

// MARK: 테스트를 위한 샘플 프로젝트를 가져오기 위함.
extension KkoProject {
    static let sampleJSONPath = Bundle.main.url(forResource: "sampleProject", withExtension: "json")
    static let samplePDFPath = Bundle.main.url(forResource: "sampleProject", withExtension: "pdf")
    static let rootStorage = AppFileManager.shared.documentUrl
    static let sample = KkoProject(path: KkoProject.rootStorage, title: "unnamed")
}

// MARK: 테스트를 위한 파일 업데이트 메서드
extension KkoProject {
    mutating func updateProjectPath(url: URL) {
        path = url
    }
    mutating func updateProjectTitle(newTitle: String) {
        title = newTitle
    }
}
