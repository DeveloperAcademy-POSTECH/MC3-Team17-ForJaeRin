//
//  TempPDFView.swift
//  ForJaeRin
//
//  Created by 이용준의 Macbook on 2023/07/20.
//

import SwiftUI

struct TempPDFView: View {
    @EnvironmentObject var myData: MyData
    @EnvironmentObject var vm: SettingGroupVM
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
                        .opacity(tapAvailable().contains(index) ? 1.0 : 0.3)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.systemGray100,lineWidth:1)
                                .foregroundColor(Color.clear)
                                .cornerRadius(10)
                        )
                    ZStack {
                        if vm.groupIndex != [] {
                            RoundedRectangle(cornerRadius: 4)
                                .fill(vm.groupIndex[index] == -1 ? .clear
                                      : GroupColor.allCases[vm.groupIndex[index]].color)
                                .opacity(0.55)
                        }
                        Text("\(index + 1)")
                            .systemFont(.caption2)
                            .foregroundColor(Color.systemGray300)
                    }
                }
            }
            .padding(.top, 8)
            .padding(.horizontal, 8)
            .padding(.bottom, 15)
        }
        .frame(maxWidth: imgSize.width, maxHeight: .infinity)
    }
    
    private func tapAvailable() -> [Int] {
        var answer: [Int] = []
        if vm.tapHistory.count == 1 {
            for index in vm.tapHistory[0]..<vm.groupIndex.count {
                if vm.groupIndex[index] == -1 {
                    answer.append(index)
                } else {
                    break
                }
            }
            for index in stride(from: vm.tapHistory[0], to: -1, by: -1) {
                if vm.groupIndex[index] == -1 {
                    answer.append(index)
                } else {
                    break
                }
            }
        } else {
            for index in 0..<vm.groupIndex.count where vm.groupIndex[index] == -1 {
                answer.append(index)
            }
        }
        return answer
    }
}
