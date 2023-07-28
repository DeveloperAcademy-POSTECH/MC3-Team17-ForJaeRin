//
//  AppFileManager.swift
//  ForJaeRin
//
//  Created by Yun Dongbeom on 2023/07/10.
//

import Foundation

class AppFileManager {
    /// FileManager 역할을 담당하는 싱글톤 객체
    static var shared = AppFileManager()

    let fileManager = FileManager.default
    
    @Published var files: [KkoProject] = []
    
    private init() {}
    
    // MARK: 파일 디렉토리 url
    lazy var documentUrl = AppFileManager.shared.fileManager.urls(
        for: .documentDirectory,
        in: .userDomainMask)[0]
    
    /// 새 이름의 폴더
    lazy var directoryPath = documentUrl.appendingPathComponent("MyNewDir", conformingTo: .directory)
    
    /// 새 이름의 파일명
    lazy var filePath = directoryPath.appendingPathComponent("New-File.txt", conformingTo: .text)
    
    /// 프로젝트의 document URL 경로 조회
    /// 
    /// file:///Users/yundongbeom/Library/Containers/kkojangro.ForJaeRin/Data/Documents/
    func printDocumentUrl() {
        print(documentUrl)
    }
    
    /// 프로젝트 루트 폴더에 하위 폴더 생성
    func createNewDirectory() {
        do {
            /// 생성할 폴더가 이미 만들어져 있는지 확인
            if !fileManager.fileExists(atPath: directoryPath.path) {
                /// 만들어져있지 않다면 폴더 생성
                try fileManager.createDirectory(
                    atPath: directoryPath.path,
                    withIntermediateDirectories: false,
                    attributes: nil)
            }
        } catch {
            /// 만들어져 있다면 폴더 생성
            print("create folder error. do something, \(error)")
        }
    }
    
    /// 프로젝트 폴더에 새로운 파일 생성
    func createNewFile() {
        /// 파일에 텍스트를 추가하기 위한 데이터
        let textString = NSString(string: "here is new file")
        
        do {
            if !fileManager.fileExists(atPath: filePath.path) {
                /// 생성한 텍스트를 파일 경로에 추가
                try textString.write(
                    to: filePath,
                    atomically: true,
                    encoding: String.Encoding.utf8.rawValue)
                print("done!")
            }
        } catch {
            // 파일이 해당 경로에 없다면 error
            print("create file error. do something \(error)")
        }
    }
    
    /// 생성한 파일 읽기
    func readFile() {
        do {
            if fileManager.fileExists(atPath: filePath.path) {
                /// 파일경로로부터 텍스트를 읽어오기
                let readString = try String(contentsOf: filePath, encoding: .utf8)
                print("생성한 파일의 정보: \(readString)") // here is new file
            }
        } catch {
            print("read file error. do something \(error)")
        }
    }
    
    /// 생성한 파일 삭제
    func removeFile() {
        do {
            if fileManager.fileExists(atPath: filePath.path) {
                /// 파일경로의 타겟을 삭제
                try fileManager.removeItem(at: filePath)
                print("파일이 삭제되었습니다.")
            }
        } catch {
            // 파일이 해당 경로에 없다면 error
            print("remove file error. do something \(error)")
        }
    }

    /// 생성한 폴더 삭제
    func removeDirectory() {
        do {
            if fileManager.fileExists(atPath: directoryPath.path) {
                /// 폴더경로의 타겟을 삭제
                try fileManager.removeItem(at: directoryPath)
                print("폴더가 삭제되었습니다.")
            }
        } catch {
            // 파일이 해당 경로에 없다면 error
            print("remove directory error. do something \(error)")
        }
    }
    
    func decodeJson(from jsonData: Data) throws -> RootModel {
        let decoder = JSONDecoder()
        return try decoder.decode(RootModel.self, from: jsonData)
    }
    
    // MARK: 임시 json 경로
    let url = Bundle.main.url(forResource: "sampleProject", withExtension: "json")
    
    // CodableProjecctModel을 Json파일로 변환하고 저장.
    // 파일 위치는 PDF 파일 제목으로 폴더를 만들고 해당 폴더 밑에 저장
    func encodeJSON(codableProjectModel: CodableProjectModel, projectURL: URL) {
        // 디렉토리 Path - 프로젝트 이름
        let dirPath = documentUrl.appendingPathComponent(
            codableProjectModel.projectMetadata.projectName,
            conformingTo: .directory
        )
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        do {
            let data = try encoder.encode(codableProjectModel)

            // 사용자의 문서 디렉토리에 JSON 파일을 저장
            do {
                /// 생성할 폴더가 이미 만들어져 있는지 확인
                if !FileManager.default.fileExists(atPath: dirPath.path) {
                    /// 만들어져있지 않다면 폴더 생성
                    try FileManager.default.createDirectory(
                        atPath: dirPath.path,
                        withIntermediateDirectories: false,
                        attributes: nil)
                }
            } catch {
                print("create folder error. do something, \(error)")
            }
            
            // 해당 폴더 밑에 json 파일 저장
            let fileURL = dirPath.appendingPathComponent("appProjectList.json")
            try data.write(to: fileURL)
            
        } catch {
            print("Error: \(error)")
        }
        
        // 해당 폴더 밑에 PDF 파일 복사본 저장.
        let sourceURL = projectURL
        let pdfName = projectURL.absoluteString.components(separatedBy: "/").last!
        let destinationURL = dirPath.appendingPathComponent(pdfName)

        do {
            try fileManager.copyItem(at: sourceURL, to: destinationURL)
            print("File copied successfully")
        } catch let error {
            print("Failed to copy file: \(error.localizedDescription)")
        }
    }
    
    // 이전 프로젝트 기록들은 "@Published var files: [KkoProject] = []"가 가지고 있다.
    // files안에 현재 저장된 PDF데이터를 넣는다.
    func addPreviousProject(codableProjectModel: CodableProjectModel, projectURL: URL) {
        let dirPath = documentUrl.appendingPathComponent(
            codableProjectModel.projectMetadata.projectName,
            conformingTo: .directory
        )
        
        let pdfName = projectURL.absoluteString.components(separatedBy: "/").last!
        let destinationURL = dirPath.appendingPathComponent(pdfName)
        
        files.append(
            KkoProject(
                path: destinationURL,
                title: codableProjectModel.projectMetadata.projectName,
                createAt: Date()
            )
        )
    }
    
    // 이전 프로젝트 기록들은 "@Published var files: [KkoProject] = []"가 가지고 있다.
    // files안에 있는 KkoProject 모두를 projectPath.json 이라는 파일에 저장한다.
    func writePreviousProject() {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        do {
            let data = try encoder.encode(files)

            // User 디렉토리 경로
            let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!

            let fileURL = directory.appendingPathComponent("projectPath.json")

            // JSON 데이터 쓰기
            try data.write(to: fileURL)

            print("KkoProject 리스트를 JSON 파일으로 성공적으로 저장되었습니다.")
        } catch {
            print("저장에 실패했습니다: \(error.localizedDescription)")
        }
    }
    
    // projectPath.json 이라는 파일을 읽어서 이전 프로젝트를 불러온다.
    // 해당 파일에는 이전 프로젝트 기록들을 저장한다.
    func readPreviousProject() {
        do {
            let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let fileURL = directory.appendingPathComponent("projectPath.json")
            let data = try Data(contentsOf: fileURL)
            let decoder = JSONDecoder()
            let jsonData = try decoder.decode([KkoProject].self, from: data)
            
            files = jsonData
            print("PreviousProject JSON파일 불러오기 성공했다!")
            print("files.count: ", files.count)
        } catch {
            print("PreviousProject JSON파일 불러오기 실패했습니다: \(error.localizedDescription)")
        }
        
    }
    
    func deletePreviousProject(file: KkoProject) {
        for index in 0..<files.count {
            if files[index].id == file.id {
                files.remove(at: index)
            }
        }
    }
    
}

// MARK: 임시 JSON 구조체
class RootModel: Codable {
    let projectMetadata: ProjectMetadata
    let projectDocument: ProjectDocument
    let practices: [Practice]
    
    struct ProjectMetadata: Codable {
        let projectName: String
        let projectGoal: String
        let projectTarget: String
        let presentationTime: Int
        let createAt: String
    }
    
    struct ProjectDocument: Codable {
        let PDFPages: [PDFPage]
        let PDFGroups: [PDFGroup]
        // swiftlint:disable nesting
        struct PDFGroup: Codable {
            let name: String
            let range: Range
            let setTime: Int
            
            struct Range: Codable {
                let start: Int
                let end: Int
            }
        }
        
        struct PDFPage: Codable {
            let keywords: Keywords
            let script: String
        }
    }
        
    struct Practice: Codable {
        var saidKeywords: [[String]]
        var speechRanges: [SpeechRange]
        let progressTime: Int
        var audioPath: String
        
        struct SpeechRange: Codable {
            var start: Int
            var group: Int
        }
    }
    
    // swiftlint:enable nesting
}
