//
//  TempPDFView.swift
//  ForJaeRin
//
//  Created by 이용준의 Macbook on 2023/07/20.
//

import SwiftUI

struct TempPDFView: View {
    var index: Int
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(.clear)
                .frame(width: 201, height: 185)
            VStack(spacing: 8) {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.white)
                    .frame(width: 169, height: 127)
                Text("\(index + 1)")
            }
        }
    }
}
