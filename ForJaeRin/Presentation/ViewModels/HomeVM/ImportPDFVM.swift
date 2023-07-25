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
    
    var title: String {
        switch self {
        case .importPDFFile:
            return "PDF 가져오기"
        case .setMetaData:
            return "발표 정보 입력하기"
        case .setScripts:
            return "스크립트 입력하기"
        case .setGroup:
            return "그룹 설정하기"
        }
    }
}

class ImportPDFVM: ObservableObject {
    // MARK: 새 프로젝트 생성 시 프로세스 진행을 표시하기 위한 상태
    @Published var step: ImportPDFStep = .importPDFFile
    
    let FOOTER_BUTTON_SIZE: CGFloat = 92
    
    let PREV_BUTTON_INFO = (
        icon: "exclamationmark.bubble.fill",
        label: "이전"
    )
    
    let NEXT_BUTTON_INFO = (
        icon: "exclamationmark.bubble.fill",
        label: "다음"
    )
    
    func handlePrevButton() {
        if step.rawValue >= 1 {
            step = ImportPDFStep.allCases[step.rawValue - 1]
        }
    }
    
    func handleNextButton() {
        if step == .setGroup {
            print("설정 완료 이벤트 시작!")
        } else {
            step = ImportPDFStep.allCases[step.rawValue + 1]
        }
    }
    
    func checkIsStepFirst() -> Bool {
        step != .importPDFFile
    }
    
    // MARK: NextButon 클릭 시 동작
    func checkIsCanGoToNext(myData: MyData) -> Bool {
        if step == .importPDFFile {
            return false
        }
        
        if step == .setMetaData {
            if myData.title == "" || myData.purpose == "" || myData.target == "" || myData.time == "" {
                return false
            }
        }
        return true
    }
}
