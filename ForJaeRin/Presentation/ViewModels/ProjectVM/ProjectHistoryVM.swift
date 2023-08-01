//
//  ProjectHistoryVM.swift
//  ForJaeRin
//
//  Created by 이용준의 Macbook on 2023/07/25.
//

import Foundation

class ProjectHistoryVM: ObservableObject {
    let SUMMARY_INFO_TITLES = ["발표 날짜", "목표 소요 시간", "연습 횟수"]
    
    @Published var isHistoryDetailActive = false
    
    func calcGroupBlockSize(percent: CGFloat, whole: CGFloat) -> CGFloat {
        return percent * (Double(whole) / Double(100))
    }
    
    func secondsToTime(seconds: Int) -> String {
        DateManager.secondsToTime(seconds: seconds)
    }
    
    func intToTime(second: Int) -> String {
        DateManager.intToTime(second: second)
    }
    
    func gettingAudioPath(path: URL) -> String {
        let pdfName = path.absoluteString.components(separatedBy: "/").last!
        return pdfName
    }
    
    func numberToHanguel(number: Int) -> String {
        if number == 1 { return "첫"} else
        if number == 2 {return "두"} else
        if number == 3 {return "세"} else
        if number == 4 {return "네"} else
        if number == 5 {return "다섯"} else
        if number == 6 {return "여섯"} else
        if number == 7 {return "일곱"} else
        if number == 8 {return "여덟"} else
        if number == 9 {return "아홉"} else
        if number == 10 {return "열"} else { return "열한" }
    }
}

struct PracticeTimeResult: Hashable {
    var groupName: String
    var hopeTime: Int
    var realTime: Int
}
