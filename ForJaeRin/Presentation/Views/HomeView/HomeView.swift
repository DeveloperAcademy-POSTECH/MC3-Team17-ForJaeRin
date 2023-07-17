//
//  HomeView.swift
//  ForJaeRin
//
//  Created by Yun Dongbeom on 2023/07/11.
//

import SwiftUI

/**
 프로젝트를 생성하거나 기존에 만들어져있는 프로젝트를 가져올 수 있는 페이지뷰입니다.
 */
// MARK: 앱 실행 시 처음으로 진입하게 되는 뷰
struct HomeView: View {
    @Environment(\.newDocument) private var newDocument
    @EnvironmentObject var projectFileManager: ProjectFileManager
    
    @StateObject var vm = HomeVM()
    @State private var isSheetActive = false {
        didSet {
            step = 0
        }
    }
    @State private var step = 0
    
    var body: some View {
        VStack(spacing: 0) {
            topContainerView()
            bottomContainerView()
        }
        .frame(
            minWidth: 960,
            maxWidth: .infinity,
            minHeight: 640,
            maxHeight: .infinity,
            alignment: .topLeading)
        .background(Color.detailLayoutBackground)
        .sheet(isPresented: $isSheetActive) {
            ImportPDFView(isSheetActive: $isSheetActive, step: $step)
            .frame(minWidth: 650, minHeight: 320)
        }
        .onAppear {
            // MARK: 테스트를 위한 샘플 가져오기
            vm.files = KkoProject.sampels
        }
    }
}

extension HomeView {
    // MARK: 페이지 타이틀
    private func topContainerView() -> some View {
        VStack(alignment: .leading, spacing: 0) {
            // 로고
            Image(vm.LOGO_NAME)
                .frame(
                    width: vm.LOGO_SIZE.width,
                    height: vm.LOGO_SIZE.height)
                .background(Color.systemBlack)
                .padding(.top, 40)
                .padding(.bottom, 10)
            sectionTextView(sectionHeaderInfo: vm.TOP_TEXT_INFO)
            newProjectButtonView()
//                .padding(.bottom, 92)
        }
        .border(width: 1, edges: [.bottom], color: Color.systemGray100)
        .padding(.horizontal, vm.HORIZONTAL_PADDING)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private func bottomContainerView() -> some View {
        VStack(alignment: .leading, spacing: 0) {
            sectionTextView(sectionHeaderInfo: vm.BOTTOM_TEXT_INFO)
                .padding(.top, 40)
                .padding(.horizontal, vm.HORIZONTAL_PADDING)
            projectListView(files: vm.files)
        }
    }
    
    // MARK: 텍스트 컨테이너
    private func sectionTextView(sectionHeaderInfo: SectionHeaderInfo) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(sectionHeaderInfo.title)
                .font(.systemHeadline)
                .bold()
            if let subTitle = sectionHeaderInfo.subTitle {
                Text(subTitle)
                    .foregroundColor(Color.systemGray300)
                    .font(.body)
//                    .padding(.bottom, 40)
            }
        }
        .multilineTextAlignment(.leading)
        .padding(.bottom, 32)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    // MARK: 새 프로젝트 생성하기 버튼 - 클릭 시 ImportPDFView sheet 열기
    private func newProjectButtonView() -> some View {
        VStack(spacing: 0) {
            Image(systemName: vm.NEW_PROJECT_BUTTON_INFO.icon)
                .resizable()
                .scaledToFit()
                .frame(width: vm.SYMBOL_INNER_SIZE, height: vm.SYMBOL_INNER_SIZE)
                .foregroundColor(Color.systemGray300)
                .frame(width:  vm.SYMBOL_OUTER_SIZE, height: vm.SYMBOL_OUTER_SIZE)
            Button {
//                isSheetActive.toggle()
                newDocument({KkoDocument()})
            } label: {
                Text(vm.NEW_PROJECT_BUTTON_INFO.label)
                    .font(Font.system(size: 16))
            }
            .buttonStyle(AppButtonStyle())
        }
        .frame(maxWidth: .infinity)
        .padding(.bottom, 56)
    }
    
    // MARK: 프로젝트 리스트
    private func projectListView(files: [KkoProject]) -> some View {
        Group {
            if files.isEmpty {
                emptyItemView()
            } else {
                GeometryReader { geometry in
                    let containerWidth = geometry.size.width - vm.HORIZONTAL_PADDING * 2
                    ScrollView(showsIndicators: false, content: {
                        projectCardContainerView(files: files, containerWidth: containerWidth)
                        .padding(.bottom, 32)
                    })
                    .frame(width: containerWidth,
                           height: geometry.size.height)
                    .padding(.horizontal, vm.HORIZONTAL_PADDING)
                }
            }
        }
    }
    
    // MARK: 리스트가 없을 때 보여지는 뷰
    private func emptyItemView() -> some View {
        VStack(spacing: 0) {
            Image(systemName: vm.EMPTY_TEXT_INFO.icon)
                .resizable()
                .scaledToFit()
                .frame(width: vm.SYMBOL_INNER_SIZE, height: vm.SYMBOL_INNER_SIZE)
                .foregroundColor(Color.systemGray300)
                .frame(width:  vm.SYMBOL_OUTER_SIZE, height: vm.SYMBOL_OUTER_SIZE)
            Text(vm.EMPTY_TEXT_INFO.label)
                .foregroundColor(Color.systemGray300)
                .font(Font.system(size: 20))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
    
    // MARK: 리스트가 있을 때 보여지는 그리드
    private func projectCardContainerView(files: [KkoProject], containerWidth: CGFloat) -> some View {
            LazyVGrid(
            columns: vm.requestCardListColumns(containerWidth: containerWidth),
            alignment: .leading,
            spacing: 56) {
            ForEach(files, id: \.id) { file in
                ProjectCardView(
                    thumanil: file.title,
                    title: file.title,
                    date: file.createAt,
                    width: vm.calcCardWidth(containerWidth: containerWidth))
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
