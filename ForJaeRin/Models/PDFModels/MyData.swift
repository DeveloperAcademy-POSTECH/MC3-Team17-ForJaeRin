//
//  MyData.swift
//  ForJaeRin
//
//  Created by 이재혁 on 2023/07/17.
//

import SwiftUI
import PDFKit

class MyData: ObservableObject {
    // MARK: 최초 키워드 리스트 설정 시 온보딩 활성화 여부
    @AppStorage("isOnboardingActive") var isOnboardingActive = true
    // MARK: 최초 키워드 리스트 설정 시 온보딩 활성화 여부
    @AppStorage("isGroupSettingOnboardingActive") var isGroupSettingOnboardingActive = true
    
    @Published var isHistoryDetailActive = false
    
    @Published var url: URL = Bundle.main.url(forResource: "sample", withExtension: "pdf")!
    
    @Published var images: [NSImage] = [NSImage]()
    
    @Published var title: String = ""
    @Published var target: String = ""
    @Published var time: String = "선택" {
        didSet {
            print(time)
        }
    }
    @Published var purpose: String = ""
    @Published var createAt: Date = Date()
    @Published var presentationDate: Date = Date()
    
    @Published var keywords: [Keywords] = []
    @Published var script: [String] = []
    @Published var groupData: [[String]] = [] {
        didSet {
            print(groupData)
        }
    }
    
    func clear() {
        self.images = [NSImage]()
        self.title = ""
        self.target = ""
        self.time = ""
        self.purpose = ""
        self.createAt = Date()
        self.presentationDate = Date()

        self.keywords = []
        self.script = []
        
        self.groupData = []
    }
    
    func checkIsGroupDataInit(index: Int) -> Bool {
        groupData[index][0] != ""
        && (groupData[index][1] != ""
        || groupData[index][2] != "")
        && groupData[index][3] != "-1"
        && groupData[index][4] != "-1"
    }
    
    func projectFileManagerToMyData(projectFileManager: ProjectFileManager) {
        self.clear()
        
        self.url = projectFileManager.projectURL!
        
        self.title = projectFileManager.projectMetadata!.projectName
        self.target = projectFileManager.projectMetadata!.projectTarget
        self.time = String(projectFileManager.projectMetadata!.presentationTime)
        self.purpose = projectFileManager.projectMetadata!.projectGoal
        self.presentationDate = projectFileManager.projectMetadata!.presentationDate
        self.createAt = projectFileManager.projectMetadata!.creatAt
        
        self.images = convertPDFToImages(pdfDocument: PDFDocument(url: self.url)!)
        
        for index in 0..<(projectFileManager.pdfDocument?.PDFPages.count)! {
            self.keywords.append((projectFileManager.pdfDocument?.PDFPages[index].keywords)!)
            self.script.append((projectFileManager.pdfDocument?.PDFPages[index].script)!)
        }
        for index in 0..<(projectFileManager.pdfDocument?.PDFGroups.count)! {
            let start = projectFileManager.pdfDocument?.PDFGroups[index].range.start
            let end = projectFileManager.pdfDocument?.PDFGroups[index].range.end
            let minute = (projectFileManager.pdfDocument?.PDFGroups[index].setTime)! / 60
            let second =  (projectFileManager.pdfDocument?.PDFGroups[index].setTime)! % 60
            let name = projectFileManager.pdfDocument?.PDFGroups[index].name
            
            self.groupData.append(
                [
                    name!,
                    String(minute),
                    String(second),
                    String(start!),
                    String(end!)
                ]
            )
        }
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
                        let nsImage = NSImage(cgImage: cgImage, size: NSZeroSize)
                        images.append(nsImage)
                    }
                }
            }
        }
        return images
    }
}
