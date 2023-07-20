//
//  InputPresentationInfoView.swift
//  ForJaeRin
//
//  Created by 이재혁 on 2023/07/18.
//

import SwiftUI
import PDFKit

struct InputPresentationInfoView: View {
    @EnvironmentObject var myData: MyData
    @State var title: String = ""
    @State var target: String = ""
    @State var purpose: String = ""
    @State var duration: String = ""
    
    @State private var selectedItem: String = "선택"
    let items = ["5분", "10분", "15분", "20분", "25분", "30분", "35분", "40분", "45분", "50분", "55분", "60분"]
    
    var body: some View {
        VStack {
            
            Image(nsImage: myData.images[0])
                .resizable()
                .frame(width: 456, height: 264)
                .cornerRadius(10)
            
            VStack {
                Text("발표 제목")
                    .font(.system(size: 16))
                    .padding(EdgeInsets(top: 0, leading: 18, bottom: 0, trailing: 413))
                TextField("나만의 발표 제목을 입력하세요", text: $myData.title)
                    .textFieldStyle(PlainTextFieldStyle())
                    .font(.system(size: 14))
                    .frame(width: 421, height: 17)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 10)
                    .background(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color(.black).opacity(0.04))
                            .background(.black.opacity(0.015))
                    )
                
                Text("발표 상세")
                    .font(.system(size: 16))
                    .padding(EdgeInsets(top: 15, leading: 18, bottom: 0, trailing: 413))
                
                ZStack {
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(Color(.black).opacity(0.04))
                        .frame(width: 451, height: 110)
                        .background(Color(.black).opacity(0.015))
                    
                    Rectangle()
                        .stroke(Color(.black).opacity(0.04))
                        .frame(width: 431, height: 0.5)
                        .padding(EdgeInsets(top: 36, leading: 10, bottom: 73, trailing: 10))
                    Rectangle()
                        .stroke(Color(.black).opacity(0.04))
                        .frame(width: 431, height: 0.5)
                        .padding(EdgeInsets(top: 72, leading: 10, bottom: 37, trailing: 10))
                    Text("발표 대상")
                        .padding(EdgeInsets(top: 12, leading: 10, bottom: 81, trailing: 389))
                    Text("발표 목적")
                        .padding(EdgeInsets(top: 48, leading: 10, bottom: 45, trailing: 389))
                    Text("발표 예상 소요시간")
                        .padding(EdgeInsets(top: 84, leading: 10, bottom: 9, trailing: 337))
                    TextField("발표 대상을 입력해주세요", text: $myData.target)
                        .textFieldStyle(PlainTextFieldStyle())
                        .font(.system(size: 14))
                        .frame(width: 141, height: 37)
                        .padding(EdgeInsets(top: 2, leading: 300, bottom: 71, trailing: 10))
                    TextField("발표 목적을 입력해주세요", text: $myData.purpose)
                        .textFieldStyle(PlainTextFieldStyle())
                        .font(.system(size: 14))
                        .frame(width: 141, height: 37)
                        .padding(EdgeInsets(top: 38, leading: 300, bottom: 35, trailing: 10))
                    Menu {
                        ForEach(items, id: \.self) { item in
                            Button(action: {
                                selectedItem = item
                                myData.time = item
                            }) {
                                Text(item)
                            }
                        }
                    } label: {
                        Text("\(selectedItem)")
                    }
                    .frame(width: 63, height: 20)
                    .padding(EdgeInsets(top: 82.5, leading: 398, bottom: 7.5, trailing: 10))
                }
            }
            .padding(EdgeInsets(top: 24, leading: 0, bottom: 0, trailing: 0))
        }
    }
}
