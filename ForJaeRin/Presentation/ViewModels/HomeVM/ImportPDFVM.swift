//
//  ImportPDFVM.swift
//  ForJaeRin
//
//  Created by Yun Dongbeom on 2023/07/24.
//

import Foundation
import SwiftUI

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
    
    let FOOTER_BUTTON_SIZE: CGFloat = 120
    
    let PREV_BUTTON_INFO = (
        icon: "exclamationmark.bubble.fill",
        label: "이전"
    )
    
    let NEXT_BUTTON_INFO = (
        icon: "exclamationmark.bubble.fill",
        label: "다음"
    )
    
    let DONE_BUTTON_INFO = (
        icon: "exclamationmark.bubble.fill",
        label: "저장하기"
    )
    
    func handlePrevButton() {
        if step.rawValue >= 1 {
            step = ImportPDFStep.allCases[step.rawValue - 1]
        }
    }
    
    func handleNextButton(completion: @escaping () -> Void) {
        if step == .setGroup {
            
            print("설정 완료 이벤트 시작!")
            completion()
        } else {
            step = ImportPDFStep.allCases[step.rawValue + 1]
        }
    }
    
    func checkIsStepFirst() -> Bool {
        step != .importPDFFile && step != .setMetaData
    }
    
    // MARK: NextButon 클릭 시 동작
    func checkIsCanGoToNext(myData: MyData) -> Bool {
        if step == .importPDFFile {
            return false
        }
        
        // MARK: 테스트를 위한 주석 - 그룹 설정
        /// 그룹 설정이 완료되려면
        /// 그룹 수가 3개 이상 7개 이하
        /// 모든 페이지가 포함
        /// 그룹 시간이 정확히 일치
        if step == .setGroup {
            if 3 <= myData.groupData.count
                && myData.groupData.count <= 7
                && checkGroupIndex()
                && leftTimeCalculator() == 0 {
                return true
            } else {
                return false
            }
        }
        
        // MARK: 테스트를 위한 주석
        if step == .setMetaData
            && myData.title == ""
            || myData.purpose == ""
            || myData.target == ""
            || myData.time == "" {
                return false
        }
        
        return true
        
        func checkGroupIndex() -> Bool {
            var groupNumber = Array(repeating: false, count: myData.keywords.count)
            for groupIndex in myData.groupData {
                if groupIndex[3] != "-1" && groupIndex[4] != "-1" {
                    for index in Int(groupIndex[3])!...Int(groupIndex[4])! {
                        groupNumber[index] = true
                    }
                }
            }
            if groupNumber.contains(false) {
                return false
            } else {
                return true
            }
        }
        func leftTimeCalculator() -> Int {
            let temp = myData.time
            var answer = Int(temp.dropLast())! * 60
            for groupIndex in 0..<myData.groupData.count {
                var minute = 0
                var second = 0
                if myData.groupData[groupIndex][1] != "" {
                    minute = Int(myData.groupData[groupIndex][1].filter { "0123456789".contains($0) })!
                }
                if myData.groupData[groupIndex][2] != "" {
                    second = Int(myData.groupData[groupIndex][2].filter { "0123456789".contains($0) })!
                }
                answer -= minute * 60 + second
            }
            return answer
        }
    }
}
