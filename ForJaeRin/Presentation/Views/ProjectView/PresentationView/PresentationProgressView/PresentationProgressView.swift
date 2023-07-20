//
//  PresentationProgressView.swift
//  ForJaeRin
//
//  Created by Yun Dongbeom on 2023/07/20.
//

import SwiftUI

struct PresentationProgressView: View {
    var sidebarWidth: CGFloat
    
    @State var currentPageCount: CGFloat = 12
    @State var wholePageCount: CGFloat = 36
    
    var body: some View {
        VStack {
            Text("PPT 진행상황")
                .systemFont(.body)
                .bold()
                .foregroundColor(Color.systemGray500)
                .frame(maxWidth: .infinity, alignment: .leading)
            VStack {
                Text("\(Int(currentPageCount))/\(Int(wholePageCount)) (장)")
                    .systemFont(.caption2)
                    .foregroundColor(Color.systemGray200)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                ZStack(alignment: .leading) {
                    Rectangle()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .foregroundColor(Color.systemGray100)
                    Rectangle()
                        .frame(maxWidth: ((currentPageCount / wholePageCount) * (sidebarWidth - 64)), maxHeight: .infinity)
                        .foregroundColor(Color.systemPrimary)
                        .cornerRadius(30)
                }
                .frame(maxWidth: .infinity, maxHeight: 12)
                .cornerRadius(30)
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 32)
    }
}

struct PresentationProgressView_Previews: PreviewProvider {
    static var previews: some View {
        PresentationProgressView(sidebarWidth: 302)
    }
}
