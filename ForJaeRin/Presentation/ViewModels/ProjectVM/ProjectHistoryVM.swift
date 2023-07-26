//
//  ProjectHistoryVM.swift
//  ForJaeRin
//
//  Created by 이용준의 Macbook on 2023/07/25.
//

import Foundation

class ProjectHistoryVM: ObservableObject {
    
    func calcGroupBlockSize(percent: CGFloat, whole: CGFloat) -> CGFloat {
        return percent * (Double(whole) / Double(100))
    }
    
    func secondsToTime(seconds: Int) -> String {
        let minutes = seconds / 60
        let seconds = seconds % 60
        return String(format: "%02d", minutes) + ":" + String(format: "%02d", seconds)
    }
    
    func gettingAudioPath(path: URL) -> String {
        let pdfName = path.absoluteString.components(separatedBy: "/").last!
        return pdfName
    }
}
