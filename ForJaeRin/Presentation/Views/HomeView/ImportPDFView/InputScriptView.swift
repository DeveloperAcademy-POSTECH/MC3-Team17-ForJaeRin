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
    @State var pageNumber: Int = 0
    @FocusState var isFocus: Bool
    
    let scriptPlaceHolder = "이 슬라이드에서 전달할 내용을 입력해주세요.\n나중에도 수정 및 추가가 가능하니 지금 다 채우지 않아도 돼요."
    
    var body: some View {
        HStack(spacing: 12) {
            pdfListView()
            pdfDetailScriptView()
        }
        .padding(.horizontal, 40)
        .frame(maxWidth: .infinity)
    }
}

extension InputScriptView {
    private func pdfListView() -> some View {
        VStack {
            PDFScrollView(pageNumber: $pageNumber, url: myData.url)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.systemGray100, lineWidth: 1)
                        .frame(maxWidth: 172, maxHeight: .infinity)
                )
        }
    }
    
    private func pdfDetailScriptView() -> some View {
        GeometryReader { geometry in
            let widthSize = geometry.size.width
            let imgHeight = widthSize / 1.6 * 0.9

            VStack {
                ZStack {
                    Image(nsImage: myData.images[pageNumber])
                        .resizable()
                        .frame(width: widthSize, height: imgHeight)
                        .cornerRadius(12)
                }
                ZStack(alignment: .topLeading) {
                    if myData.script[pageNumber].isEmpty {
                        Text(scriptPlaceHolder)
                            .systemFont(.body)
                            .foregroundColor(Color.systemGray200)
                            .padding(10)
                            .padding(.horizontal, 6)
                            .zIndex(1)
                            .onTapGesture {
                                isFocus = true
                            }
                    }
                    TextEditor(text: $myData.script[pageNumber])
                        .focused($isFocus)
                    .systemFont(.body)
                    .foregroundColor(Color.systemGray500)
                    .padding(10)
                    .frame(maxWidth: widthSize, maxHeight: .infinity)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.systemGray100, lineWidth: 1)
                            .frame(maxWidth: widthSize, maxHeight: .infinity)
                    )
                }
            }
            .frame(maxWidth: geometry.size.width)
        }
    }
}

struct PDFScrollView: View {
    @EnvironmentObject var myData: MyData
    @State private var pdfImages = [NSImage]()
    @Binding var pageNumber: Int
    let url: URL
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                ForEach(pdfImages.indices, id: \.self) { index in
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.primary200)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.systemPrimary, lineWidth: 1)
                            )
                            .opacity(pageNumber == index ? 1.0 : 0.0)
                        VStack(spacing: 0) {
                            Image(nsImage: pdfImages[index])
                                .resizable()
                                .frame(width: 120, height: 65)
                                .cornerRadius(4)
                                .padding(.vertical, 5)
                                .padding(.horizontal, 6)
                            Text("\(index + 1)")
                                .systemFont(.caption2)
                                .foregroundColor(Color.systemGray400)
                                .padding(.bottom, 3)
                        }
                    }
                    .frame(maxWidth: 132)
                    .onTapGesture {
                        pageNumber = index
                    }
                }
            }
            .padding(.vertical, 16)
            .padding(.horizontal, 10)
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
        if Bundle.main.url(forResource: "KHackathon_PDF", withExtension: "pdf") != nil {
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
                
                if let context = CGContext(
                    data: nil,
                    width: width,
                    height: height,
                    bitsPerComponent: 8,
                    bytesPerRow: 0,
                    space: colorSpace,
                    bitmapInfo: bitmapInfo
                ) {
                    context.setFillColor(NSColor.white.cgColor)
                    context.fill(CGRect(x: 0, y: 0, width: width, height: height))
                    
                    page.draw(with: .cropBox, to: context)
                    
                    if let cgImage = context.makeImage() {
                        let nsImage = NSImage(cgImage: cgImage, size: .zero)
                        images.append(nsImage)
                    }
                }
            }
        }
        return images
    }
}
