//
//   ProjectFlowView.swift
//  ForJaeRin
//
//  Created by 박보경 on 2023/07/20.
//
import SwiftUI

struct ProjectFlowView: View {
    @StateObject var vm = ProjectFlowVM()
    @EnvironmentObject var projectFileManager: ProjectFileManager
    
    @State private var selectedRectangleIndex: Int? = 0
    @State private var rowCount: Int = 15
    @State private var groupNames: [String] = ["그룹1", "그룹2", "그룹3", "그룹4", "그룹5", "그룹6", "그룹7"]
    let texts: [String] = ["차이", "개발자", "안녕하세요", "디자이너", "충전기", "어쩌라고", "반가워요"]

    var body: some View {
        VStack(spacing: 46) {
            topContainer()
            bottomContainer()
        }
        .padding(.top, 50)
        .padding(.bottom, 64)
        .padding(.horizontal, 97)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.detailLayoutBackground)
    }
}

extension ProjectFlowView {
    // MARK: 상단 컨테이너
    private func topContainer() -> some View {
        VStack(spacing: 0) {
            sectionTextView(sectionHeaderInfo: vm.TOP_TEXT_INFO)
            GeometryReader { geometry in
                if let pdfDocument = projectFileManager.pdfDocument {
                    let wholeWidthSize = geometry.size.width
                    VStack(spacing: 15) {
                        partOfGroupBlockView(document: pdfDocument, wholeWidthSize: wholeWidthSize)
                        partOfGroupTextView(document: pdfDocument, wholeWidthSize: wholeWidthSize)
                    }
                } else {}
            }
        }
        .padding(.top, 36)
        .padding(.bottom, 18)
        .padding(.horizontal, 27)
        .background(Color.systemWhite)
        .cornerRadius(12)
        .frame(maxWidth: .infinity, maxHeight: 244, alignment: .topLeading)
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
            }
        }
        .multilineTextAlignment(.leading)
        .padding(.bottom, 32)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    // MARK: Group Black
    private func partOfGroupBlockView(document: PDFDocumentManager, wholeWidthSize: CGFloat) -> some View {
        HStack(spacing: 4) {
            ForEach(
                Array(document.PDFGroups.enumerated()), id: \.1.id) { index, _ in
                let size = vm.calcGroupBlockSize(
                    percent: document.getGroupVolumn(index: index),
                    whole: wholeWidthSize
                )
                VStack {
                    ZStack {
                        Rectangle()
                            .fill(GroupColor.allCases[index].color)
                        if vm.selectedGroup == index {
                            Image(systemName: "checkmark.circle.fill")
                                .scaledToFit()
                                .foregroundColor(GroupColor.allCases[index].text)
                                .frame(maxWidth: 20, maxHeight: 20)
                        }
                    }
                    .frame(maxHeight: 40)
                }
                .frame(maxWidth: size, alignment: .center)
                .onTapGesture {
                    vm.selectedGroup = index
                }
            }
        }
        .frame(maxWidth: wholeWidthSize)
        .cornerRadius(12)
    }
    
    // MARK: Group Name
    private func partOfGroupTextView(document: PDFDocumentManager, wholeWidthSize: CGFloat) -> some View {
        HStack(spacing: 4) {
            ForEach(
                Array(document.PDFGroups.enumerated()), id: \.1.id) { index, pdfGroup in
                let size = vm.calcGroupBlockSize(
                    percent: document.getGroupVolumn(index: index),
                    whole: wholeWidthSize
                )
                VStack {
                    Text(pdfGroup.name)
                        .systemFont(.caption2)
                        .foregroundColor(.systemGray300)
                }
                .frame(maxWidth:size, alignment: .center)
                .onTapGesture {
                    vm.selectedGroup = index
                }
            }
        }
        .frame(maxWidth: wholeWidthSize)
        .cornerRadius(12)
    }
    
    // MARK: 하단 컨테이너
    private func bottomContainer() -> some View {
        VStack {
            Rectangle()
                .frame(maxWidth: .infinity, maxHeight: 20)
                .foregroundColor(GroupColor.allCases[vm.selectedGroup].color)
                .alignmentGuide(.top) { _ in 0 }
            
            ScrollView(showsIndicators: true) {
                VStack(spacing: 0) {
                    if let document = projectFileManager.pdfDocument {
                        let range = document.PDFGroups[vm.selectedGroup].range
                        ForEach(range.start...range.end, id: \.self) { index in
                            groupKeywordListView(pdfPages: document.PDFPages, index: index)
                        }
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.systemWhite)
        .cornerRadius(12)
    }
    
    private func groupKeywordListView(pdfPages: [PDFPage], index: Int) -> some View {
        VStack {
            HStack {
                ForEach(pdfPages[index].keywords, id: \.self) { keyword in
                    ZStack {
                        Text(keyword)
                            .systemFont(.subTitle)
                            .foregroundColor(Color.systemGray400)
                            .padding(.vertical, 12)
                            .padding(.horizontal, 16)
                            .background(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color.systemGray200)
                                    .background(Color.clear)
                                    .cornerRadius(5)
                            )
                    }
                }
            }
        }
        .padding(.vertical, 26)
    }
}
