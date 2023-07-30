//
//  GroupChartView.swift
//  ForJaeRin
//
//  Created by Yun Dongbeom on 2023/07/26.
//

import SwiftUI

struct GroupChartView: View {
    var groupName: String
    var realGroup: Int
    
    var maxTime: Int
    var hopeTime: Int
    var realTime: Int
    
    var body: some View {
        Group {
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    
                    if realGroup > 0 {
                        Image(systemName: "plus")
                            .frame(width: 16, height: 16)
                            .padding(.trailing, 2)
                            .foregroundColor(Color.systemPrimary)
                        
                        // 임의로 적어둔"01:00" 부분에 RealGroup 변수 값이 들어가야 할 듯
                        Text("01:00")
                            .systemFont(.caption1)
                            .foregroundColor(Color.systemPrimary)
                    } else if realGroup < 0 {
                        Image(systemName: "minus")
                            .frame(width: 16, height: 16)
                            .padding(.trailing, 2)
                            .foregroundColor(Color.systemGray200)
                        
                        // 임의로 적어둔 "00:20" 부분에 RealGroup 변수 값이 들어가야 할 듯
                        Text("00:20")
                            .systemFont(.caption1)
                            .foregroundColor(Color.systemGray200)
                    } else {
                    // 임의로 적어둔 "00:00" 부분에 RealGroup 변수 값이 들어가야 할 듯
                    Text("00:00")
                        .systemFont(.caption1)
                        .foregroundColor(Color.systemGray200)
                    }
                }
                
                if realGroup > 0 {
                    ZStack {
                        Rectangle()
                            .frame(width: 78, height: 219)
                            .foregroundColor(Color.primary100)
                            .cornerRadius(6)
                            .opacity(100)
                            .padding(.top, 8)
                            .padding(.bottom, 5)
                        
                        StyleDetailsChartView(maxTime: maxTime, hopeTime: hopeTime, realTime: realTime)
                    }
                } else {
                    ZStack {
                        Rectangle()
                            .frame(width: 78, height: 219)
                            .foregroundColor(Color.primary100)
                            .cornerRadius(6)
                            .opacity(0)
                            .padding(.top, 8)
                            .padding(.bottom, 5)
                        
                        StyleDetailsChartView(maxTime: maxTime, hopeTime: hopeTime, realTime: realTime)
                    }
                }
                
                if realGroup > 0 {
                    Text(groupName)
                        .systemFont(.caption2)
                        .foregroundColor(Color.systemGray500)
                } else {
                    Text(groupName)
                        .systemFont(.caption2)
                        .foregroundColor(Color.systemGray300)
                }
            }
        }
    }
}
