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
    @State private var selectedItem: String = "선택"
    @State private var date: Date = Date()
    var underTenMinutes = Array(1...10).map { String("\($0)분") }
    let items = ["15분", "20분", "25분", "30분", "35분", "40분", "45분", "50분", "55분", "60분"]
    
    var body: some View {
        VStack(spacing: 24) {
            GeometryReader { geometry in
                VStack {
                    Image(nsImage: myData.images[0])
                        .resizable()
                        .scaledToFill()
                        .frame(
                            maxWidth: geometry.size.width,
                            maxHeight: geometry.size.width / 1.6 * 0.9
                        )
                        .cornerRadius(10)
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: .spacing150) {
                            projectTitleInputView()
                            projectInfoInputView()
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                    .padding(.vertical, .spacing300)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .frame(maxWidth: 456, maxHeight: .infinity)
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
            VStack(spacing: 0) {
                Spacer()
                targetInputView()
                Divider()
                purposeInputView()
                Divider()
                timeInputView()
                Spacer()
                dateInputView()
            }
            .padding(.horizontal, 10)
            .background(
                RoundedRectangle(cornerRadius: 6)
                    .stroke(Color.textFieldBorder)
                    .background(Color.textFieldBackground)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            )
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
    
    private func targetInputView() -> some View {
        HStack {
            Text("대상")
                .systemFont(.caption1)
                .padding(.trailing, 24)
            TextField("무엇을 위한 발표인지 입력해주세요", text: $myData.target)
                .textFieldStyle(PlainTextFieldStyle())
                .systemFont(.caption1)
                .multilineTextAlignment(.trailing)
                .frame(maxWidth: .infinity, minHeight: 30)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private func purposeInputView() -> some View {
        HStack {
            Text("목적")
                .systemFont(.caption1)
                .padding(.trailing, 24)
            TextField("누구에게 발표하는지 입력해주세요", text: $myData.purpose)
                .textFieldStyle(PlainTextFieldStyle())
                .systemFont(.caption1)
                .multilineTextAlignment(.trailing)
                .frame(maxWidth: .infinity, minHeight: 40)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private func timeInputView() -> some View {
        HStack {
            Text("소요시간")
                .systemFont(.caption1)
            Spacer()
            Menu {
                ForEach(underTenMinutes + items, id: \.self) { item in
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
    
    private func dateInputView() -> some View {
        HStack {
            Text("날짜")
                .systemFont(.caption1)
                .padding(.trailing, 24)
            Spacer()
            DatePicker("발표날짜", selection: $myData.presentationDate, displayedComponents: [.date])
                .systemFont(.caption1)
                .labelsHidden()
                .datePickerStyle(.stepperField)
                .accentColor(Color.systemPrimary)
                .background(Color.clear)
                .frame(maxWidth: 72)
                .padding(.trailing, 12)
        }
        .padding(.bottom, 8)
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
        let nsImage = NSImage(size: pageRect.size, flipped: false, drawingHandler: { (rect: NSRect) -> Bool in
            guard let context = NSGraphicsContext.current?.cgContext else { return false }
            context.setFillColor(NSColor.white.cgColor)
            context.fill(rect)
            page.draw(with: .mediaBox, to: context)
            return true
        })
        
        return nsImage
    }
}

struct InputPresentationInfoView_Previews: PreviewProvider {
    static var previews: some View {
        InputPresentationInfoView()
    }
}
