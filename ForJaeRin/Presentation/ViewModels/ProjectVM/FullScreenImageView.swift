//
//  FullScreenImageView.swift
//  ForJaeRin
//
//  Created by Yun Dongbeom on 2023/07/31.
//

import SwiftUI

// 린 추가 : 이미지 눌렀을 때 뜨는 창
struct FullScreenImageView: View {
    @EnvironmentObject var myData: MyData
    @Binding var isPresented: Bool
    let pageIndex: Int
    let containerWidth: CGFloat
    
    var body: some View {
        ZStack {
            Image(nsImage: myData.images[pageIndex])
                .resizable()
                .frame(
                    maxWidth: calcImageRatio().width,
                    maxHeight: calcImageRatio().height
                )
                .fixedSize()
                .padding(.all, 0)
                .onTapGesture {
                    isPresented = false
                }
        }
        .onAppear {
            print(myData.images[pageIndex].size)
            print(containerWidth)
        }
        .edgesIgnoringSafeArea(.all) // 창 크기를 조절할 수 없도록 설정
        .background(Color.clear) // 흰색 여백을 없애기 위해 배경을 clear로 설정
    }
    
    func calcImageRatio() -> CGSize {
        CGSize(width: containerWidth - 48, height: (containerWidth - 48) * myData.images[pageIndex].size.height / myData.images[pageIndex].size.width)
    }
}
