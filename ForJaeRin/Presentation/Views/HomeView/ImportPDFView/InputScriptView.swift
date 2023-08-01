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
    @StateObject var vm = InputScriptVM()
    
    let scriptPlaceHolder = "이 슬라이드에서 전달할 내용을 입력해주세요.\n나중에도 수정 및 추가가 가능하니 지금 다 채우지 않아도 돼요."
    @FocusState var isFocus: Bool
    
    var body: some View {
        GeometryReader { geometry in
            let maxWidth = geometry.size.width
            HStack(spacing: .spacing200) {
                pdfListView(width: maxWidth / 5)
                    .frame(maxWidth: maxWidth / 5)
                pdfDetailScriptView()
                    .frame(maxWidth: maxWidth / 5 * 4)
            }
            .padding(.horizontal, .spacing500)
            .frame(maxWidth: maxWidth)
            .onAppear {
                vm.script = myData.script
            }
            .onReceive(vm.$pageNumber) {
                if !vm.isScriptEmpty() { myData.script[$0] = vm.script[$0] }
            }
            .onDisappear {
                myData.script = vm.script
            }
        }
    }
}

extension InputScriptView {
    private func pdfListView(width: CGFloat) -> some View {
        ZStack(alignment: .top) {
            Rectangle()
                .fill(Color.clear)
                .frame(maxWidth: .infinity, maxHeight: .spacing400)
                .background(LinearGradient(
                    stops: [
                    Gradient.Stop(color: .white, location: 0.00),
                    Gradient.Stop(color: .white.opacity(0), location: 1.00)
                    ],
                    startPoint: UnitPoint(x: 0.5, y: 0.1),
                    endPoint: UnitPoint(x: 0.5, y: 1)
                    ))
                .zIndex(10)
            VStack(spacing: 0) {
                ZStack(alignment: .bottom) {
                    PDFScrollView(
                        vm: vm,
                        url: myData.url,
                        containerWidth: width
                    )
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    Rectangle()
                        .fill(Color.clear)
                        .frame(maxWidth: .infinity, maxHeight: .spacing400)
                        .background(LinearGradient(
                            stops: [
                                Gradient.Stop(color: .white.opacity(0), location: 0.00),
                                Gradient.Stop(color: .white, location: 1.00)
                            ],
                            startPoint: UnitPoint(x: 0.5, y: 0),
                            endPoint: UnitPoint(x: 0.5, y: 0.8)))
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.systemGray100, lineWidth: 1)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        )
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    private func pdfDetailScriptView() -> some View {
        GeometryReader { geometry in
            let widthSize = geometry.size.width
            let imgHeight = widthSize / 1.6 * 0.9
            VStack(spacing: .spacing150 * 2) {
                ZStack {
                    Image(nsImage: myData.images[vm.pageNumber])
                        .resizable()
                        .frame(width: widthSize, height: imgHeight)
                        .cornerRadius(12)
                }
                ZStack(alignment: .topLeading) {
                    if !vm.isScriptEmpty() {
                        if vm.script[vm.pageNumber].isEmpty {
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
                        TextEditor(text: $vm.script[vm.pageNumber])
                        .systemFont(.body)
                        .foregroundColor(Color.systemGray500)
                        .focused($isFocus)
                        .padding(10)
                        .frame(maxWidth: widthSize, maxHeight: .infinity)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.systemGray100, lineWidth: 1)
                                .frame(maxWidth: widthSize, maxHeight: .infinity)
                        )
                    }
                }
            }
            .frame(maxWidth: geometry.size.width)
        }
    }
}

struct PDFScrollView: View {
    @EnvironmentObject var myData: MyData
    @ObservedObject var vm: InputScriptVM
    @State private var pdfImages = [NSImage]()
    let url: URL
    let containerWidth: CGFloat
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 18) {
                ForEach(pdfImages.indices, id: \.self) { index in
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.primary200)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.systemPrimary, lineWidth: 1)
                            )
                            .opacity(vm.pageNumber == index ? 1.0 : 0.0)
                        VStack(spacing: 0) {
                            Image(nsImage: pdfImages[index])
                                .resizable()
                                .frame(width: containerWidth - 32, height: (containerWidth - 32) / 1.6 * 0.9)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 4)
                                        .stroke(Color.systemGray100, lineWidth: 1)
                                        .foregroundColor(Color.clear)
                                        .cornerRadius(4)
                                )
                                .cornerRadius(4)
                                .padding(.vertical, 5)
                                .padding(.horizontal, 6)
                                .cornerRadius(4)
                            Text("\(index + 1)")
                                .systemFont(.caption2)
                                .foregroundColor(Color.systemGray400)
                                .padding(.bottom, 3)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .onTapGesture {
                        vm.pageNumber = index
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
