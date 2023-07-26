//
//  StyleDetailChartView.swift
//  ForJaeRin
//
//  Created by Yun Dongbeom on 2023/07/26.
//

import SwiftUI

// MARK: - 막대 그래프
struct StyleDetailsChartView: View {
    var maxTime: Int
    var hopeTime: Int
    var realTime: Int

    var body: some View {
        HStack {
            VStack {
                
                CustomBarChart1(data: [
                    //[data 가져오기]
                    //사용자가 설정한 그룹 발표 시간 중 가장 최대값 : maxTime
                    //y에 사용자가 설정한 그룹 발표 시간 : hopeTime
                    //y에 들어갈 수식(goalGraph) : 200*(hopeTime/(maxTime+(maxTime*1/4)))
                    (x: "Cachapa", y: Int(Double(200) * (Double(hopeTime) / (Double(maxTime) + (Double(maxTime) * 0.15)))))
                ])
            }
            .frame(width: 18, height: 200, alignment: .bottom)
            
            VStack {
                CustomBarChart2(data: [
                    //[data 가져오기]
                    //y에 사용자가 실제로 말한 그룹 발표 시간 : realTime
                    //y에 들어갈 수식(realGraph) : hopeTime-realTime
                    (x: "Cachapa", y: Int(Double(200) * (Double(realTime) / (Double(maxTime) + (Double(maxTime) * 0.15)))))
                ])
            }
            .frame(width: 18, height: 200, alignment: .bottom)
        }
    }
}
