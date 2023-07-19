//
//  PresentationPageListOnboardingView.swift
//  ForJaeRin
//
//  Created by Yun Dongbeom on 2023/07/16.
//

import SwiftUI

struct PresentationPageListOnboardingView: View {
    @Binding var isOnboardingActive: Bool
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            backgackgroundView()
            HStack {
                HStack(spacing: 0) {
                    Spacer(minLength: 70 + 92)
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(Color.primary200)
                            .cornerRadius(10)
                            .frame(width: 111, height: 62)
                        Text("썸네일")
                            .systemFont(.body)
                            .foregroundColor(Color.systemPrimary)
                    }
                    Spacer(minLength: 35)
                }
                .frame(maxWidth: 318)
                Divider()
                    .padding(.trailing, 35)
                scriptInfoView()
                Divider()
                    .padding(.leading, 35)
                    .padding(.trailing, 18)
                keywordInfoView()
                Spacer(minLength: 102)
            }
            .padding(.vertical, 18)
            Button {
                isOnboardingActive = false
            } label: {
                Image(systemName: "xmark")
                    .foregroundColor(Color.primary400)
            }
            .buttonStyle(.plain)
            .padding(.trailing, 92)
            .offset(x: -18, y: 9)
        }
        .padding(.top, 50)
        .frame(maxWidth: .infinity, minHeight: 98)
    }
}

extension PresentationPageListOnboardingView {
    private func backgackgroundView() -> some View {
        Rectangle()
        .foregroundColor(.clear)
        .frame(maxWidth: .infinity, minHeight: 98)
        .background(Color.primary100)
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .inset(by: 0.5)
                .stroke(Color.primary400)
        )
        .padding(.leading, 92)
        .padding(.trailing, 92)
    }
    
    private func scriptInfoView() -> some View {
        Text("이 곳에 PPT 페이지별 스크립트를\n입력해주세요.")
            .lineLimit(2)
            .systemFont(.body)
            .foregroundColor(Color.primary400)
    }
    
    private func keywordInfoView() -> some View {
        HStack(spacing: 13) {
            HStack(spacing: 0) {
                Text("페이지별")
                    .padding(.horizontal, 11)
                    .padding(.vertical, 7)
                    .cornerRadius(5)
                    .foregroundColor(Color.systemPrimary)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .inset(by: 0.5)
                            .stroke(Color.systemGray100, lineWidth:1)
                            .foregroundColor(Color.clear)
                            .cornerRadius(5)
                      )
                    .systemFont(.caption1)
                Text("스크립트")
                    .padding(.horizontal, 11)
                    .padding(.vertical, 7)
                    .cornerRadius(5)
                    .foregroundColor(Color.systemPrimary)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .inset(by: 0.5)
                            .stroke(Color.systemGray100, lineWidth:1)
                            .foregroundColor(Color.clear)
                            .cornerRadius(5)
                      )
                    .systemFont(.caption1)
                Text("입력")
                    .padding(.horizontal, 11)
                    .padding(.vertical, 7)
                    .cornerRadius(5)
                    .foregroundColor(Color.systemPrimary)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .inset(by: 0.5)
                            .stroke(Color.systemGray100, lineWidth:1)
                            .foregroundColor(Color.clear)
                            .cornerRadius(5)
                      )
                    .systemFont(.caption1)
            }
            Text("키워드는 스크립트에 포함된 단어들로\n최대 7개까지 입력해주세요.")
                .lineLimit(2)
                .systemFont(.caption2)
                .foregroundColor(Color.primary400)
        }
    }
}

struct PresentationPageListOnboardingView_Previews: PreviewProvider {
    
    static var previews: some View {
        @State var isOnboardingActive = false
        PresentationPageListOnboardingView(isOnboardingActive: $isOnboardingActive)
    }
}
