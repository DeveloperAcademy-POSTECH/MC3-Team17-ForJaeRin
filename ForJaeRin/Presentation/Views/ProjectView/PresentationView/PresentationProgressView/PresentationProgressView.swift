//
//  PresentationProgressView.swift
//  ForJaeRin
//
//  Created by Yun Dongbeom on 2023/07/20.
//

import SwiftUI

struct PresentationProgressView: View {
    @EnvironmentObject var projectFileManager: ProjectFileManager
    @EnvironmentObject var vm: PresentationVM
    
    var body: some View {
        VStack {
            Text(vm.PROGRESS_SECTION_TITLE)
                .systemFont(.body)
                .bold()
                .foregroundColor(Color.systemGray500)
                .frame(maxWidth: .infinity, alignment: .leading)
            VStack {
                if let document = projectFileManager.pdfDocument {
                    Text("\(Int(vm.currentPageIndex))/\(Int(document.PDFPages.count)) (장)")
                        .systemFont(.caption2)
                        .foregroundColor(Color.systemGray200)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    ZStack(alignment: .leading) {
                        Rectangle()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .foregroundColor(Color.systemGray100)
                        Rectangle()
                            .frame(
                                maxWidth: vm.calcProgress(wholeCount: document.PDFPages.count),
                                maxHeight: .infinity
                            )
                            .foregroundColor(Color.systemPrimary)
                            .cornerRadius(30)
                    }
                    .frame(maxWidth: .infinity, maxHeight: 12)
                    .cornerRadius(30)
                }
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 32)
    }
}

struct PresentationProgressView_Previews: PreviewProvider {
    static var previews: some View {
        PresentationProgressView()
    }
}
