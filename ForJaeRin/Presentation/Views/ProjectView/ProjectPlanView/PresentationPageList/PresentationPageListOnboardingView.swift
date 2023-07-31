//
//  PresentationPageListOnboardingView.swift
//  ForJaeRin
//
//  Created by Yun Dongbeom on 2023/07/16.
//

import SwiftUI

struct PresentationPageListOnboardingView: View {
    let conatainerWidth: CGFloat
    @Binding var isOnboardingActive: Bool
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            HStack(spacing: 0) {
                HStack {
                    RoundedRectangle(cornerRadius: 5)
                        .foregroundColor(Color.primary200)
                        .cornerRadius(5)
                        .frame(maxWidth: .infinity, maxHeight: 105)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(.horizontal, .spacing400)
                Divider()
                    .padding(.trailing, .spacing400)
                scriptInfoView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                Divider()
                    .padding(.leading, .spacing400)
                    .padding(.trailing, .spacing400)
                keywordInfoView()
                    .frame(minWidth: 516,  maxWidth: .infinity)
            }
            .padding(.vertical, .spacing400)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.primary400, lineWidth: 1)
                    .background(Color.primary100)
                    .cornerRadius(10)
                    .frame(maxWidth: .infinity)
            )
            .frame(minWidth: 728, maxWidth: conatainerWidth, maxHeight: 200)
            Button {
                isOnboardingActive = false
            } label: {
                Image(systemName: "xmark")
                    .foregroundColor(Color.primary400)
            }
            .buttonStyle(.plain)
            .offset(x: -18, y: 9)
        }
        .padding(.top, .spacing600)
        .padding(.horizontal, .spacing1000)
    }
}

extension PresentationPageListOnboardingView {
    private func scriptInfoView() -> some View {
        Text("해당 슬라이드의 스크립트에요.\n언제든지 수정이 가능해요")
            .systemFont(.body)
            .foregroundColor(Color.systemPrimary)
    }
    
    private func keywordInfoView() -> some View {
        HStack(spacing: .spacing400) {
            VStack(alignment: .leading) {
                HStack(spacing: 10) {
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
                    Image(systemName: "checkmark.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .foregroundColor(Color.systemPrimary)
                }
                keywordInfoFalseMidView()
                keywordInfoFalseBottomView()
            }
            Text("연습 시 키워드 체크를 위해,\n말할 단어를 박스 당 하나씩\n최대 7개까지 입력해주세요.")
//                .fixedSize()
                .systemFont(.body)
                .foregroundColor(Color.primary500)
                .padding(.trailing, .spacing600)
        }
    }
    
    private func keywordInfoFalseMidView() -> some View {
        HStack(spacing: 10) {
            HStack(spacing: 0) {
                Text("page별")
                    .padding(.horizontal, 11)
                    .padding(.vertical, 7)
                    .cornerRadius(5)
                    .foregroundColor(Color.systemGray300)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .inset(by: 0.5)
                            .stroke(Color.systemGray100, lineWidth:1)
                            .foregroundColor(Color.clear)
                            .cornerRadius(5)
                      )
                    .systemFont(.caption1)
                Text("스크립트 입력")
                    .padding(.horizontal, 11)
                    .padding(.vertical, 7)
                    .cornerRadius(5)
                    .foregroundColor(Color.systemGray300)
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
                    .foregroundColor(Color.systemGray300)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .inset(by: 0.5)
                            .stroke(Color.systemGray100, lineWidth:1)
                            .foregroundColor(Color.clear)
                            .cornerRadius(5)
                      )
                    .systemFont(.caption1)
            }
            Image(systemName: "xmark.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
                .foregroundColor(Color.systemGray200)
        }
    }
    private func keywordInfoFalseBottomView() -> some View {
        HStack(spacing: 10) {
            HStack(spacing: 0) {
                Text("page별")
                    .padding(.horizontal, 11)
                    .padding(.vertical, 7)
                    .cornerRadius(5)
                    .foregroundColor(Color.systemGray300)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .inset(by: 0.5)
                            .stroke(Color.systemGray100, lineWidth:1)
                            .foregroundColor(Color.clear)
                            .cornerRadius(5)
                      )
                    .systemFont(.caption1)
                Text("스크립트 입력")
                    .padding(.horizontal, 11)
                    .padding(.vertical, 7)
                    .cornerRadius(5)
                    .foregroundColor(Color.systemGray300)
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
                    .foregroundColor(Color.systemGray300)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .inset(by: 0.5)
                            .stroke(Color.systemGray100, lineWidth:1)
                            .foregroundColor(Color.clear)
                            .cornerRadius(5)
                      )
                    .systemFont(.caption1)
            }
            Image(systemName: "xmark.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
                .foregroundColor(Color.systemGray200)
        }
    }
}
