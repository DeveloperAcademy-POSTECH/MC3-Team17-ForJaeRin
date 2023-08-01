//
//  PresentationOnboardingView.swift
//  ForJaeRin
//
//  Created by Yun Dongbeom on 2023/07/31.
//

import SwiftUI

struct PresentationOnboardingView: View {
    @ObservedObject var vm: PresentationVM
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .topLeading) {
                Image("presentationOnboarding")
                    .resizable()
                    .scaledToFill()
                Button {
                    vm.isPresentationOnboardingActive = false
                } label: {
                    HStack(spacing: 10) {
                        Text("연습모드 시작하기")
                            .systemFont(.headline)
                            .foregroundColor(Color.systemWhite)
                        Image(systemName: "chevron.right")
                            .resizable()
                            .scaledToFit()
                            .frame(maxHeight: 16)
                            .foregroundColor(Color.systemWhite)
                    }
                    .background(Color.systemPrimary)
                }
                .buttonStyle(.plain)
                .frame(maxWidth: 255, maxHeight: 93)
                .background(
                    Rectangle()
                        .cornerRadius(100)
                        .foregroundColor(Color.systemPrimary)
                )
                .offset(x: 64, y: 64 + 28)
            }
            .frame(
                maxWidth: geometry.size.width,
                maxHeight: geometry.size.height
            )
        }
    }
}

struct PresentationOnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        PresentationOnboardingView(vm: PresentationVM())
    }
}
