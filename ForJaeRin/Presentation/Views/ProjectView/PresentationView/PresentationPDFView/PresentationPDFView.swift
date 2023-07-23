//
//  PresentationPDFView.swift
//  ForJaeRin
//
//  Created by Yun Dongbeom on 2023/07/12.
//

import SwiftUI
import PDFKit

/**
 프레젠테이션과 키워드 뷰 간 연동 필요
 키보드 바인딩 필요
 */

// MARK: PDF뷰를 가져와서 연습모드에 띄울 뷰
struct PresentationPDFView: View {
    @EnvironmentObject var vm: PresentationVM
    private let pdfView = PDFView()
    let document = PDFDocument(url: Bundle.main.url(forResource: "sample", withExtension: "pdf")!)!
    
    var body: some View {
        VStack {
            PDFKitRepresentedView(
                currentPageIndex: $vm.currentPageIndex,
                pdfView: pdfView,
                pdfDocument: document)
            Text("Current Page: \(vm.currentPageIndex)")
            Button {
                vm.currentPageIndex += 1
            } label: {
                Text("이동하기")
            }
        }
    }

}

struct PDFKitRepresentedView: NSViewRepresentable {
    
    @Binding var currentPageIndex: Int
    var pdfView: PDFView
    let pdfDocument: PDFDocument
    
    func makeNSView(context: NSViewRepresentableContext<PDFKitRepresentedView>) -> PDFView {
        pdfView.displayBox = .cropBox
        pdfView.displayMode = .singlePage
        pdfView.autoScales = true
        pdfView.backgroundColor = NSColor(cgColor: Color.detailLayoutBackground.cgColor!)!
        pdfView.document = pdfDocument
        pdfView.delegate = context.coordinator
        NotificationCenter.default.addObserver(
            context.coordinator,
            selector: #selector(Coordinator.pdfViewPageChanged(_:)),
            name: .PDFViewPageChanged,
            object: pdfView
        )
        
        return pdfView
    }

    func updateNSView(_ nsView: PDFView, context: NSViewRepresentableContext<PDFKitRepresentedView>) {
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, PDFViewDelegate {
        var parent: PDFKitRepresentedView

        init(_ parent: PDFKitRepresentedView) {
            self.parent = parent
        }
        
        @objc func pdfViewPageChanged(_ notification: Notification) {
            if let pdfView = notification.object as? PDFView {
                parent.currentPageIndex = (pdfView.currentPage?.pageRef?.pageNumber ?? 1) - 1
            }
        }
    }
}
