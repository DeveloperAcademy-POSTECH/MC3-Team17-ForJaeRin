//
//  ProjectCardView.swift
//  ForJaeRin
//
//  Created by Yun Dongbeom on 2023/07/17.
//

import SwiftUI
import PDFKit

struct ProjectCardView: View {
    // MARK: PDF에서 썸네일 가져와서 저장하고 싶어요 로키.
    var path: URL
    var title: String
    var date: Date
    var width: CGFloat
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .inset(by: 1)
                    .stroke(Color.primary200)
                    .foregroundColor(Color.clear)
                    .frame(width: width, height: width / 3 * 2)
                    .cornerRadius(10)
                Image(nsImage: pdfToImage(pdfUrl: path)!)
                    .resizable()
                // .scaledToFit()
                // .padding(24)
                    .frame(width: width, height: width / 3 * 2)
                    .cornerRadius(10)
            }
            VStack(alignment: .leading, spacing: 0) {
                Text(title)
                    .foregroundColor(Color.systemGray500)
                    .font(Font.system(size: 16))
                Text(DateManager.formatDateToString(date: date))
                    .foregroundColor(Color.systemGray300)
                    .font(Font.system(size: 13))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(maxWidth: .infinity, alignment: .topLeading)
    }
    
    func pdfToImage(pdfUrl: URL) -> NSImage? {
        let pdfDocument = PDFDocument(url: pdfUrl)
        guard let page = pdfDocument?.page(at: 0) else {
            return nil
        }
        
        let pageRect = page.bounds(for: .mediaBox)
        let thumbnail = NSImage(
            size: pageRect.size,
            flipped: false,
            drawingHandler: { (rect: NSRect) -> Bool in
                guard let context = NSGraphicsContext.current?.cgContext else { return false }
                context.setFillColor(NSColor.white.cgColor)
                context.fill(rect)
                page.draw(with: .mediaBox, to: context)
                return true
            })
        
        return thumbnail
    }
}
