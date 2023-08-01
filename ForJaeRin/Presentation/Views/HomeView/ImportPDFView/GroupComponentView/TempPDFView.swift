//
//  TempPDFView.swift
//  ForJaeRin
//
//  Created by 이용준의 Macbook on 2023/07/20.
//

import SwiftUI

struct TempPDFView: View {
    @EnvironmentObject var myData: MyData
    @StateObject var vm = SettingGroupVM()
    var index: Int
    var imgSize: CGSize
    var hilight: Bool
    
    var body: some View {
        ZStack {
            // MARK: - Box Decoration
            RoundedRectangle(cornerRadius: 12)
                .fill(hilight ? Color.primary200 : .clear)
                .frame(maxWidth: imgSize.width, maxHeight: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(hilight ? Color.primary500 : .clear, lineWidth: 2)
                        .foregroundColor(Color.clear)
                        .frame(maxWidth: imgSize.width, maxHeight: .infinity)
                )
            VStack(spacing: 8) {
                if !myData.images.isEmpty {
                    Image(nsImage: myData.images[index])
                        .resizable()
                        .frame(width: imgSize.width - 16, height: (imgSize.width - 16) / 3 * 2)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.systemGray100,lineWidth:1)
                                .foregroundColor(Color.clear)
                                .cornerRadius(10)
                        )
                    ZStack {
                        Text("\(index + 1)")
                            .systemFont(.caption2)
                            .foregroundColor(Color.systemGray300)
//                        RoundedRectangle(cornerRadius: 10)
//                            .fill(vm.groupIndex[index] == -1 ? .clear : GroupColor.allCases[vm.groupIndex[index]].color)
//                            .opacity(0.55)
                    }
                }
            }
            .padding(.top, 8)
            .padding(.horizontal, 8)
            .padding(.bottom, 15)
        }
        .frame(maxWidth: imgSize.width, maxHeight: .infinity)
    }
}
