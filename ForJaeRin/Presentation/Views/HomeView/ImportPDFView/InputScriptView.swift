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
    
    @State private var pdfImages = [NSImage]()
    
    var body: some View {
        HStack {
            VStack {
                DispatchScrollView1(url: myData.url, pageNumber: $pageNumber)
                    .environmentObject(myData)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color(hex: "2F2F2F").opacity(0.1), lineWidth: 1)
                            .frame(width: 172, height: 586)
                    )
            }
            .padding(.all)
            
            VStack {
                ZStack {
                    ForEach(myData.images.indices, id: \.self) { number in
                        Image(nsImage: myData.images[number])
                            .resizable()
                            .frame(width: 622, height: 337)
                            .cornerRadius(12)
                            .zIndex(number == pageNumber ? 1 : 0)
                    }
                }
                ZStack {
                    ForEach(myData.images.indices, id: \.self) { number in
                        TextEditor(text: $myData.script[number])
                            .frame(width: 576, height: 171)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color(hex: "2F2F2F").opacity(0.1), lineWidth: 1)
                                    .frame(width: 622, height: 203)
                            )
                            .padding(EdgeInsets(top: 32, leading: 0, bottom: 34, trailing: 0))
                            .zIndex(number == pageNumber ? 1 : 0)
                    }
                }
            }
        }
    }
}

//
struct DispatchScrollView1: View {
    @State private var pdfImages = [NSImage]()
    @EnvironmentObject var myData: MyData
    let url: URL
    @Binding var pageNumber: Int
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(pdfImages.indices, id: \.self) { index in
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color(hex: "AC9FFF").opacity(0.25)) // 배경색 변경
                            .frame(width: 132, height: 92)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color(hex: "8B6DFF"), lineWidth: 1) // 테두리 색과 두께 변경
                            )
                            .opacity(pageNumber == index ? 1.0 : 0.0)
                        Image(nsImage: pdfImages[index])
                            .resizable()
                            .frame(width: 120, height: 65)
                            .cornerRadius(4)
                            .padding(EdgeInsets(top: 6, leading: 5, bottom: 22, trailing: 5))
                        Text("\(index+1)")
                            .font(.system(size: 12))
                            .padding(EdgeInsets(top: 75, leading: 63, bottom: 3, trailing: 63))
                    }
                    .onTapGesture {
                        pageNumber = index
                    }
                }
            }
        }
        .onAppear {
            if let pdfDocument = PDFDocument(url: url) {
                let images = self.convertPDFToImages(pdfDocument: pdfDocument)
                self.pdfImages = images
                myData.images = images
            }
        }
    }
    
    func loadPDF() -> PDFDocument? {
        if let pdfURL = Bundle.main.url(forResource: "KHackathon_PDF", withExtension: "pdf") {
            return PDFDocument(url: url)
        }
        return nil
    }
    
    func convertPDFToImages(pdfDocument: PDFDocument) -> [NSImage] {
        var images = [NSImage]()
        let pageCount = pdfDocument.pageCount
        
        for pageNumber in 0..<pageCount {
            if let page = pdfDocument.page(at: pageNumber) {
                let pageRect = page.bounds(for: .cropBox)
                let width = Int(pageRect.width)
                let height = Int(pageRect.height)
                
                let colorSpace = CGColorSpaceCreateDeviceRGB()
                let bitmapInfo = CGImageAlphaInfo.premultipliedLast.rawValue
                
                if let context = CGContext(data: nil, width: width, height: height, bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo) {
                    context.setFillColor(NSColor.white.cgColor)
                    context.fill(CGRect(x: 0, y: 0, width: width, height: height))
                    
                    page.draw(with: .cropBox, to: context)
                    
                    if let cgImage = context.makeImage() {
                        let nsImage = NSImage(cgImage: cgImage, size: NSZeroSize)
                        images.append(nsImage)
                    }
                }
            }
        }
        return images
    }
}

/*
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
 */
