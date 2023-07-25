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
    // MARK: 뷰 안에서 데이터를 저장하고 있기 위한 상태변수 인데 코드 상에선 안 쓰고 있네요?
    @State var projectMetaData = ProjectMetadata(
        projectName: "",
        projectGoal: "",
        projectTarget: "",
        presentationTime: 0,
        creatAt: Date()
    )
    @State private var selectedItem: String = "선택"
    let items = ["5분", "10분", "15분", "20분", "25분", "30분", "35분", "40분", "45분", "50분", "55분", "60분"]
    
    var body: some View {
        VStack(spacing: 0) {
            GeometryReader { geometry in
                Image(nsImage: myData.images[0])
                    .resizable()
                    .scaledToFill()
                    .frame(
                        maxWidth: geometry.size.width,
                        maxHeight: geometry.size.width / 1.6 * 0.9
                    )
                    .cornerRadius(10)
            }
            VStack(spacing: 12) {
                projectTitleInputView()
                projectInfoInputView()
            }
            .padding(.top, 24)
            .frame(maxWidth: .infinity, alignment: .topLeading)
        }
        .frame(maxWidth: 456, maxHeight: 532, alignment: .center)
    }
}

extension InputPresentationInfoView {
    private func projectTitleInputView() -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("발표 제목")
                .systemFont(.body)
            TextField("나만의 발표 제목을 입력하세요", text: $myData.title)
                .systemFont(.caption1)
                .textFieldStyle(PlainTextFieldStyle())
                .padding(.horizontal, 10)
                .frame(minHeight: 40)
                .background(
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(Color(.black).opacity(0.04))
                        .background(.black.opacity(0.015))
                )
        }
    }
    
    private func projectInfoInputView() -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("발표 상세")
                .systemFont(.body)
            ZStack {
                RoundedRectangle(cornerRadius: 6)
                    .stroke(Color(.black).opacity(0.04))
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color(.black).opacity(0.015))
                VStack(spacing: 0) {
                    targetInputView()
                    Divider()
                    purposeInputView()
                    Divider()
                    timeInputView()
                }
                .padding(.horizontal, 10)
                .frame(maxWidth: .infinity)
            }
        }
    }
    
    private func targetInputView() -> some View {
        HStack {
            Text("발표 대상")
                .padding(.trailing, 24)
            TextField("발표 대상을 입력해주세요", text: $myData.target)
                .textFieldStyle(PlainTextFieldStyle())
                .systemFont(.caption1)
                .multilineTextAlignment(.trailing)
                .frame(maxWidth: .infinity, maxHeight: 40)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private func purposeInputView() -> some View {
        HStack {
            Text("발표 목적")
                .padding(.trailing, 24)
            TextField("발표 목적을 입력해주세요", text: $myData.purpose)
                .textFieldStyle(PlainTextFieldStyle())
                .systemFont(.caption1)
                .multilineTextAlignment(.trailing)
                .frame(maxWidth: .infinity, maxHeight: 40)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private func timeInputView() -> some View {
        HStack {
            Text("발표 예상 소요시간")
            Spacer()
            Menu {
                ForEach(items, id: \.self) { item in
                    Button {
                        selectedItem = item
                        myData.time = item
                    } label: {
                        Text(item)
                    }
                }
            } label: {
                Text("\(selectedItem)")
            }
            .frame(width: 64, height: 20)
        }
        .padding(.top, 10)
        .frame(maxWidth: .infinity, alignment: .leading)
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
            let imgimg = pdfToImage(pdfUrl: self.pdfUrl)
                self.image = imgimg
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
