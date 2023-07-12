//
//  HomeView.swift
//  ForJaeRin
//
//  Created by Yun Dongbeom on 2023/07/11.
//

import SwiftUI

struct HomeView: View {
    @State private var isSheetActive = false
    var body: some View {
        VStack(spacing: 0) {
            // Project Title
            pageTitleContinerView()
            Divider()
                .padding(.horizontal, 32)
            projectListContainerView()
            // New Project
            // ProjectTable
            
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity,
            alignment: .topLeading)
        .sheet(isPresented: $isSheetActive) {
            ImportPdfView(isSheetActive: $isSheetActive)
            .frame(minWidth: 650, minHeight: 320)
        }
    }
}

extension HomeView {
    func pageTitleContinerView() -> some View {
        VStack(alignment: .leading, spacing: 8) {
            pageTitleView()
            newProjectButtonView()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private func pageTitleView() -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("새 프로젝트")
                .font(.largeTitle)
                .bold()
            
            Text("새 프로젝트를 추가해서 제작해보세요")
                .font(.body)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .multilineTextAlignment(.leading)
        .padding(.leading, 32)
        .padding(.top, 40)
        .padding(.trailing, 40)
    }
    
    private func newProjectButtonView() -> some View {
        VStack {
            Image(systemName: "square.grid.3x1.folder.fill.badge.plus")
                .resizable()
                .scaledToFit()
                .frame(width: 56, height: 56)
                .foregroundColor(.secondary)
//                .offset(x: 4)
            
            Button {
//                print("add new project")
                isSheetActive.toggle()
            } label: {
                Text("프로젝트 생성하기")
            }
            .buttonStyle(AppButtonStyle())
        }
        .frame(maxWidth: .infinity)
        .padding(.bottom, 56)
    }
    
    private func projectListContainerView() -> some View {
        VStack(alignment: .leading, spacing: 0) {
            projectListTitleView()
            projectListView()
        }
    }
    private func projectListTitleView() -> some View {
        VStack {
            Text("새 프로젝트")
                .font(.largeTitle)
                .bold()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .multilineTextAlignment(.leading)
        .padding(.leading, 32)
        .padding(.top, 40)
        .padding(.trailing, 40)
    }
    
    private func projectListView() -> some View {
        GeometryReader { geometry in
            ScrollView {
                stageListView()
                .padding(.bottom, 32)
                .padding(.horizontal, 32)
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
    }
}

private func stageListView() -> some View {
    let columns = [
        GridItem(.adaptive(minimum: 212, maximum: 320), spacing: 32)
    ]

    return LazyVGrid(
        columns: columns,
        alignment: .leading, spacing: 32
    ) {
        ForEach(0 ..< 60) { _ in
            VStack(alignment: .leading, spacing: 20) {
                Image(systemName: "doc.text.fill")
                    .resizable()
                    .scaledToFit()
                    .padding(24)
                    .frame(maxWidth: .infinity, maxHeight: 147)
                    .foregroundColor(.secondary)
                    .background(.mint)
                    .cornerRadius(10)
                VStack(alignment: .leading, spacing: 8) {
                    Text("title")
                    Text("second")
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .frame(maxWidth: .infinity, alignment: .topLeading)
            .background(.gray)
            .cornerRadius(10)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
