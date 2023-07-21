//
//  OpenFileDialogView.swift
//  ForJaeRin
//
//  Created by Yun Dongbeom on 2023/07/12.
//

import SwiftUI
import PDFKit

/**
 파일 시스템과 관련된 클래스와 연동해서, PDF파일 경로를 들고 있는 것이 좋을 것 같습니다.
 */
// MARK: PDF를 불러오기 위한 View
struct FileImporterButtonView: View {
    @EnvironmentObject var myData: MyData
    @State private var isImporting: Bool = false
    @Binding var step: Int
    @State private var pdfImages = [NSImage]()
    
    var body: some View {
        
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .stroke(style: StrokeStyle(lineWidth: 2, dash: [5]))
                .foregroundColor(Color(hex: "2F2F2F"))
                .opacity(0.25)
                .background(Color.clear)
                .frame(width: 532, height: 431)
            
            VStack {
                Image(systemName: "folder.badge.plus")
                    .resizable()
                    .frame(width: 84, height: 58)
                    .foregroundColor(Color(hex: "2F2F2F").opacity(0.25))
                    .padding(EdgeInsets(top: 17, leading: 10.5, bottom: 22, trailing: 2.5))
                    .frame(width: 97, height: 97)
                Text("PDF 파일을 여기에 끌어서 추가할 수 있어요")
                    .padding(EdgeInsets(top: 24, leading: 0, bottom: 0, trailing: 0))
                    .foregroundColor(Color(hex: "000000"))
                    .opacity(0.5)
                Button(action: {
                    isImporting = true
                }, label: {
                    Text("PDF 파일 불러오기")
                })
                .padding(EdgeInsets(top: 24, leading: 0, bottom: 0, trailing: 0))
                .fileImporter(isPresented: $isImporting,
                              allowedContentTypes: [.pdf],
                              onCompletion: { result in
                    switch result {
                    case .success(let success):
                        print(success)
                        myData.clear()
                        myData.url = success
                        step += 1
                        //
                        if let pdfDocument = PDFDocument(url: myData.url) {
                            let images = self.convertPDFToImages(pdfDocument: pdfDocument)
                            self.pdfImages = images
                            myData.images = images
                            myData.script = [String](repeating: "", count: myData.images.count)
                            myData.keywords = [[String]](repeating: ["", "", "", "", "", "", ""], count: myData.images.count)
                        }
                        step += 2
                        //
                    case .failure(let failure):
                        print(failure)
                    }
                })
            }
        }
    }
    
    func loadPDF() -> PDFDocument? {
        if let pdfURL = Bundle.main.url(forResource: "KHackathon_PDF", withExtension: "pdf") {
            return PDFDocument(url: pdfURL)
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
