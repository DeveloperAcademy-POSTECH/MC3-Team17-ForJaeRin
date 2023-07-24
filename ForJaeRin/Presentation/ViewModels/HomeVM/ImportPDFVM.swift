//
//  ImportPDFVM.swift
//  ForJaeRin
//
//  Created by Yun Dongbeom on 2023/07/24.
//

import Foundation

enum ImportPDFStep: Int, CaseIterable {
    case importPDFFile
    case setMetaData
    case setScripts
    case setGroup
}

class ImportPDFVM: ObservableObject {
    // MARK: 새 프로젝트 생성 시 프로세스 진행을 표시하기 위한 상태
    @Published var step: ImportPDFStep = .importPDFFile
    
    func handlePrevButton() {
        
    }
    
    func handleNextButton() {
        
    }
}
