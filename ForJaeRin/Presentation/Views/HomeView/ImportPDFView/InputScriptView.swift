//
//  InputScriptView.swift
//  ForJaeRin
//
//  Created by 이재혁 on 2023/07/18.
//

import SwiftUI
import PDFKit

struct InputScriptView: View {
    @EnvironmentObject var myData: MyData
    @State var pageIndex = 0
    @State var isOn = true
    
    @State var focusIndex: Int = 0
    
    @State var pageNumber: Int = 0
    @State var scriptText: String = ""
    @State var keyword: String = ""
    var body: some View {
        HStack {
            VStack {
                
                MyPDFKitView(url: myData.url, pageNumber: $pageNumber)
                Text("Current page: \(pageNumber)")
                
            }
            .padding(.all)
            
            VStack {
                
                ZStack {
                    ForEach(0..<PDFDocument(url: myData.url)!.pageCount, id: \.self) { number in
                        SinglePDFPageView(url: myData.url, pageNumber: number)
                            .zIndex(number == pageNumber ? 1 : 0)
                    }
                }
                
                TextField("스크립트를 입력", text: $scriptText)
                    .padding()
                    .border(Color.gray, width: 0.5)
            }
        }
    }
}

struct InputScriptView_Previews: PreviewProvider {
    static var previews: some View {
        InputScriptView()
    }
}

struct MyPDFKitView: NSViewRepresentable {
    let url: URL
    @Binding var pageNumber: Int
    
    func makeNSView(context: Context) -> PDFView {
        let pdfView = PDFView()
        pdfView.document = PDFDocument(url: url)
        pdfView.autoScales = true
        pdfView.delegate = context.coordinator
        let tapGesture = NSClickGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handleTap(_:)))
        pdfView.addGestureRecognizer(tapGesture)
        return pdfView
    }
    
    func updateNSView(_ pdfView: PDFView, context: Context) {
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, PDFViewDelegate {
        var parent: MyPDFKitView
        
        init(_ pdfView: MyPDFKitView) {
            self.parent = pdfView
        }
        
        @objc func handleTap(_ sender: NSClickGestureRecognizer) {
            if let pdfView = sender.view as? PDFView,
               let page = pdfView.page(for: sender.location(in: pdfView), nearest: true),
               let pageIndex = pdfView.document?.index(for: page) {
                parent.pageNumber = pageIndex
            }
        }
    }
}

struct SinglePDFPageView: NSViewRepresentable {
    let url: URL
    let pageNumber: Int
    
    func makeNSView(context: Context) -> NSView {
        let pdfView = PDFView()
        pdfView.autoScales = true
        pdfView.displayMode = .singlePage
        
        if let document = PDFDocument(url: url), let page = document.page(at: pageNumber) {
            let singlePageDocument = PDFDocument()
            singlePageDocument.insert(page, at: 0)
            pdfView.document = singlePageDocument
        }
        
        return pdfView
    }
    
    func updateNSView(_ nsView: NSView, context: Context) {
    }
}

struct PDFPageThumbnailView: View {
    let url: URL
    let pageIndex: Int
    
    var body: some View {
        if let pdfDocument = PDFDocument(url: url),
           let page = pdfDocument.page(at: pageIndex) {
            let pdfPageImage = page.thumbnail(of: CGSize(width: 200, height: 200), for: .artBox)
            
            Image(nsImage: pdfPageImage)
        } else {
            Text("Failed to load page")
        }
    }
}
