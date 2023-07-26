//
//  CustomBarChartView.swift
//  ForJaeRin
//
//  Created by Yun Dongbeom on 2023/07/26.
//

import SwiftUI

struct CustomBarChart1: View {
    let data: [(x: String, y: Int)]
    
    var body: some View {
        ZStack (alignment: .bottomLeading) {
            Rectangle()
                .frame(width: 18, height: CGFloat(data[0].y))
                //오퍼시티 없는 색 버전으로 수정 필요
                .foregroundColor(Color.systemGray200)
                .cornerRadius(6)
            Rectangle()
                .frame(width: 18, height: 6)
                //오퍼시티 없는 색 버전으로 수정 필요
                .foregroundColor(Color.systemGray200)
            ForEach(data, id: \.x) { datum in
            }
        }
    }
}

struct CustomBarChart2: View {
    let data: [(x: String, y: Int)]
    
    var body: some View {
        ZStack (alignment: .bottomLeading) {
            Rectangle()
                .frame(width: 18, height: CGFloat(data[0].y))
                .foregroundColor(Color.systemPrimary)
                .cornerRadius(6)
            Rectangle()
                .frame(width: 18, height: 6)
                .foregroundColor(Color.systemPrimary)
            ForEach(data, id: \.x) { datum in
            }
        }
    }
}
