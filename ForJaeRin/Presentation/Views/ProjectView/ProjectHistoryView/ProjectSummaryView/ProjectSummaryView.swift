//
//  ProjectSummaryView.swift
//  ForJaeRin
//
//  Created by Yun Dongbeom on 2023/07/12.
//

import Charts
import SwiftUI

/*
 어떤 결과를 요약해서 보여줄 것인지, 정보 확인이 필요합니다.
 */
// MARK: - 프로젝트 연습 결과 요약 뷰
struct ProjectSummaryView: View {
    
    let data = [
        //[data 가져오기] 내가 말한 키워드 횟수
        (23.0, Color.primary500),
        //[data 가져오기] 말하지 못한 키워드 횟수 = 전체 키워드 갯수 - 내가 말한 키워드 횟수
        (11.0, Color.systemGray100),
    ]
    let groupName: [String] = ["Group 1", "Group 2", "Group 3", "Group 4", "Group 5", "Group 6", "Group 7"]
    //[data 가져오기] 그룹 갯수(0 포함이 되어 있어서 실제로 입력한 갯수+1로 들어감)
    var groupCount:Int = 6
    
    var body: some View {
        ZStack {
            Color.detailLayoutBackground
            GeometryReader { geometry in
                ScrollView {
                    VStack(spacing: 0) {
                        //MARK: 타이틀
                        VStack {
                            Text("첫번째 발표연습 기록")
                                .systemFont(.headline)
                                .padding(.top, 52)
                                .padding(.horizontal, 72)
                        }
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                        HStack(spacing: 28) {
                            //MARK: 키워드
                            ZStack (alignment: .topLeading){
                                Rectangle()
                                    .cornerRadius(10)
//                                    .frame(width: 432, height: 380)
                                    .frame(minWidth: 432, maxWidth: .infinity)
                                    .foregroundColor(Color.systemWhite)
                                
                                VStack (spacing: 42){
                                    Group{
                                        VStack (alignment: .leading, spacing: 8) {
                                            Text("키워드")
                                                .systemFont(.headline)
                                            Text("나의 키워드를 말한 횟수예요")
                                                .systemFont(.caption1)
                                                .foregroundColor(Color.systemGray400)
                                        }
                                        .padding(.top, 26)
                                        .padding(.leading, 26)
                                    }
                                    
                                    ZStack{
                                        PieChartView(slices : data)
                                            .foregroundColor(Color.primary500)
                                            .frame(width: 200, height: 200)
                                        
                                        HStack (alignment: .bottom){
                                            //[data 가져오기] 내가 말한 키워드 횟수/전체 키워드 갯수
                                            Text("23/34")
                                                .systemFont(.headline)
                                                .foregroundColor(Color.systemGray500)
                                            Text("(개)")
                                                .systemFont(.body)
                                                .foregroundColor(Color.systemGray200)
                                                .padding(.leading, -8)
                                        }
                                    }
                                    .offset(x: 116, y: 0)
                                }
                            }
                            .frame(minWidth: 432, maxWidth: .infinity)
                            .border(.indigo, width: 2)
                            //연습 소요시간
                            ZStack (alignment: .topLeading){
                                Rectangle()
                                    .cornerRadius(10)
                                    .frame(maxWidth: (geometry.size.width - 144) / 3 * 2)
                                    .foregroundColor(Color.systemWhite)
                                HStack {
                                    VStack (alignment: .leading, spacing: 8) {
                                        Text("연습 소요시간")
                                            .systemFont(.headline)
                                        Text("설정한 시간 대비 실제 연습시간이에요")
                                            .systemFont(.caption1)
                                            .foregroundColor(Color.systemGray400)
                                    }
                                    .padding(.top, 26)
                                    .padding(.leading, 26)
                                    .padding(.trailing, 375)
                                    
                                    VStack (alignment: .trailing, spacing: 4)  {
                                        HStack {
                                            Rectangle()
                                                .cornerRadius(6)
                                                .frame(width: 19, height: 19)
                                                .foregroundColor(Color.systemGray200)
                                            
                                            Text("목표 시간")
                                                .systemFont(.caption1)
                                                .foregroundColor(Color.systemGray500)
                                        }
                                        
                                        HStack {
                                            Rectangle()
                                                .cornerRadius(6)
                                                .frame(width: 19, height: 19)
                                                .foregroundColor(Color.systemPrimary)
                                            
                                            Text("소요 시간")
                                                .systemFont(.caption1)
                                            .foregroundColor(Color.systemGray500)                            }
                                    }
                                    .padding(.top, 38)
                                    .padding(.leading, 10)
                                }
                                HStack (alignment: .center) {
                                    //[data 가져오기]
                                    //사용자가 설정한 그룹 발표 시간 중 가장 최대값 : maxTime
                                    //y에 사용자가 설정한 그룹 발표 시간 : hopeTime
                                    //y에 들어갈 수식(goalGraph) : 200*(hopeTime/(maxTime+(maxTime*1/4)))
                                    //y에 사용자가 실제로 말한 그룹 발표 시간 : realTime
                                    
                                    Group {
                                        //[data 가져오기] 그룹명 가져오기, realGroup&maxTime&hopeTime&realTime 값 가져오기
                                        GroupChartView(
                                            groupName: "그룹 1",
                                            realGroup: 1,
                                            maxTime: 80,
                                            hopeTime: 60,
                                            realTime: 70
                                        )
                                        GroupChartView(
                                            groupName: "그룹 2",
                                            realGroup: -1,
                                            maxTime: 80,
                                            hopeTime: 70,
                                            realTime: 50
                                        )
                                        GroupChartView(
                                            groupName: "그룹 3",
                                            realGroup: 0,
                                            maxTime: 80,
                                            hopeTime: 35,
                                            realTime: 35
                                        )
                                        GroupChartView(
                                            groupName: "그룹 4",
                                            realGroup: 1,
                                            maxTime: 80,
                                            hopeTime: 80,
                                            realTime: 90
                                        )
                                        GroupChartView(
                                            groupName: "그룹 5",
                                            realGroup: 0,
                                            maxTime: 80,
                                            hopeTime: 70,
                                            realTime: 70
                                        )
                                    }
                                }
                                .border(.indigo, width: 2)
                                .padding(.top, 100)
                            }
                            .border(.indigo, width: 2)
                            .frame(maxWidth: geometry.size.width / 3 * 2)
                        }
                        .padding(.top, 80)
                        .padding(.horizontal, 72)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .border(.mint, width: 2)
                        //MARK: 구간 별 다시듣기
                        
                        //MARK: 한 눈에 보기
                            VStack {
                                    HStack (spacing: 12){
                                        ForEach(0...groupCount, id: \.self) { value in
                                            GroupView(group: groupName[value])
                                                .frame(maxHeight: .infinity, alignment: .topLeading)
                                        }
                                    }
                                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                                    .padding(.bottom, 52)
                                    .padding(.top, 56)
                                }
                            .frame(maxWidth: .infinity, maxHeight: 800, alignment: .topLeading)
                            .border(.indigo, width: 2)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                }
                .frame(maxWidth: geometry.size.width, maxHeight: geometry.size.height, alignment: .topLeading)
                .onAppear {
                    print(geometry.size)
                }
                .border(.red, width: 2)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .border(.green, width: 2)
    }
}



struct ProjectSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectSummaryView()
    }
}
