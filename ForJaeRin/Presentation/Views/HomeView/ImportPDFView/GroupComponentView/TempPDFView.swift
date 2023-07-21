//
//  TempPDFView.swift
//  ForJaeRin
//
//  Created by 이용준의 Macbook on 2023/07/20.
//

import SwiftUI

struct TempPDFView: View {
    var index: Int
    var hilight: Bool
    @EnvironmentObject var myData: MyData
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .inset(by: 1)
                .fill(hilight ? Color.primary200 : .clear)
                .frame(width: 184, height: 172)
            RoundedRectangle(cornerRadius: 16)
                .stroke(hilight ? Color.primary500 : .clear, lineWidth: 2)
                .foregroundColor(Color.clear)
                .frame(width: 184, height: 172)
            VStack(spacing: 8) {
//                RoundedRectangle(cornerRadius: 10)
//                    .fill(Color.gray)
//                    .frame(width: 169, height: 127)
                Image(nsImage: myData.images[index])
                    .resizable()
                    .frame(width: 169, height: 127)
                Text("\(index + 1)")
                    .font(.system(size: 12))
                    .foregroundColor(.black.opacity(0.5))
            }
        }
    }
}
