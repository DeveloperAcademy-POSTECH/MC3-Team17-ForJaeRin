//
//  InputPresentationInfoView.swift
//  ForJaeRin
//
//  Created by 이재혁 on 2023/07/18.
//

import SwiftUI
import PDFKit

struct InputPresentationInfoView: View {
    @EnvironmentObject var myData: MyData
    @State var title: String = ""
    @State var target: String = ""
    @State var purpose: String = ""
    @State var duration: String = ""
    
    @State private var selectedItem: String = "Item 1"
    let items = ["Item 1", "Item 2", "Item 3"]
    
    var body: some View {
        VStack {
            
            OnePDFImageView(pdfUrl: myData.url)
                .frame(width: 456, height: 264)
                .cornerRadius(10)
            
            VStack {
                Text("발표 제목")
                    .font(.system(size: 16))
                    .padding(EdgeInsets(top: 0, leading: 18, bottom: 0, trailing: 413))
                TextField("나만의 발표 제목을 입력하세요", text: $title)
                    .textFieldStyle(PlainTextFieldStyle())
                    .font(.system(size: 14))
                    .frame(width: 421, height: 17)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 10)
                    .background(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color(.black).opacity(0.04))
                            .background(.black.opacity(0.015))
                    )
                
                Text("발표 상세")
                    .font(.system(size: 16))
                    .padding(EdgeInsets(top: 15, leading: 18, bottom: 0, trailing: 413))
                
                ZStack {
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(Color(.black).opacity(0.04))
                        .frame(width: 451, height: 110)
                        .background(Color(.black).opacity(0.015))
                    
                    Rectangle()
                        .stroke(Color(.black).opacity(0.04))
                        .frame(width: 431, height: 0.5)
                        .padding(EdgeInsets(top: 36, leading: 10, bottom: 73, trailing: 10))
                    Rectangle()
                        .stroke(Color(.black).opacity(0.04))
                        .frame(width: 431, height: 0.5)
                        .padding(EdgeInsets(top: 72, leading: 10, bottom: 37, trailing: 10))
                    Text("발표 대상")
                        .padding(EdgeInsets(top: 12, leading: 10, bottom: 81, trailing: 389))
                    Text("발표 목적")
                        .padding(EdgeInsets(top: 48, leading: 10, bottom: 45, trailing: 389))
                    Text("발표 예상 소요시간")
                        .padding(EdgeInsets(top: 84, leading: 10, bottom: 9, trailing: 337))
                    TextField("발표 대상을 입력해주세요", text: $target)
                        .textFieldStyle(PlainTextFieldStyle())
                        .font(.system(size: 14))
                        .frame(width: 141, height: 37)
                        .padding(EdgeInsets(top: 2, leading: 300, bottom: 71, trailing: 10))
                    TextField("발표 목적을 입력해주세요", text: $purpose)
                        .textFieldStyle(PlainTextFieldStyle())
                        .font(.system(size: 14))
                        .frame(width: 141, height: 37)
                        .padding(EdgeInsets(top: 38, leading: 300, bottom: 35, trailing: 10))
                    Menu {
                        ForEach(items, id: \.self) { item in
                            Button(action: {
                                selectedItem = item
                            }) {
                                Text(item)
                            }
                        }
                    } label: {
                        Text("Select an Item")
                    }
                    .frame(width: 63, height: 20)
                    .padding(EdgeInsets(top: 82.5, leading: 398, bottom: 7.5, trailing: 10))
                }
            }
            .padding(EdgeInsets(top: 24, leading: 0, bottom: 0, trailing: 0))
        }
    }
}

struct PDFViewer: NSViewRepresentable {
    var pdfDocument: PDFDocument
    
    func makeNSView(context: Context) -> PDFView {
        let pdfView = PDFView()
        pdfView.document = pdfDocument
        pdfView.autoScales = true
        pdfView.displayMode = .singlePage
        pdfView.goToFirstPage(nil)
        return pdfView
    }
    
    func updateNSView(_ pdfView: PDFView, context: Context) {
        pdfView.document = pdfDocument
        pdfView.goToFirstPage(nil)
    }
}

struct OnePDFImageView: View {
    let pdfUrl: URL
    @State private var image: NSImage?
    
    var body: some View {
        Group {
            if let imgimg = self.image {
                Image(nsImage: imgimg)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } else {
                Text("Loading...")
            }
        }
        .onAppear(perform: loadImage)
    }
    
    private func loadImage() {
        DispatchQueue.global(qos: .userInitiated).async {
            let imgimg = pdfToImage(pdfUrl: self.pdfUrl)
            DispatchQueue.main.async {
                self.image = imgimg
            }
        }
    }
    
    func pdfToImage(pdfUrl: URL) -> NSImage? {
        let pdfDocument = PDFDocument(url: pdfUrl)
        guard let page = pdfDocument?.page(at: 0) else {
            return nil
        }
        
        let pageRect = page.bounds(for: .mediaBox)
        let imgimg = NSImage(size: pageRect.size, flipped: false, drawingHandler: { (rect: NSRect) -> Bool in
            guard let context = NSGraphicsContext.current?.cgContext else { return false }
            context.setFillColor(NSColor.white.cgColor)
            context.fill(rect)
            //            context.translateBy(x: 0.0, y: rect.size.height)
            //            context.scaleBy(x: 1.0, y: -1.0)
            page.draw(with: .mediaBox, to: context)
            return true
        })
        
        return imgimg
    }
}

struct InputPresentationInfoView_Previews: PreviewProvider {
    static var previews: some View {
        InputPresentationInfoView()
    }
}
