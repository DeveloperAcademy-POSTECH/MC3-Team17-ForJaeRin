//
//  HomeView.swift
//  ForJaeRin
//
//  Created by Yun Dongbeom on 2023/07/11.
//

import SwiftUI
import PDFKit

/**
 프로젝트를 생성하거나 기존에 만들어져있는 프로젝트를 가져올 수 있는 페이지뷰입니다.
 */
// MARK: 앱 실행 시 처음으로 진입하게 되는 뷰
struct HomeView: View {
    @EnvironmentObject var projectFileManager: ProjectFileManager
    @EnvironmentObject var myData: MyData
    // EnvironmentObject로 전달할 변수 여기서 선언
    @StateObject var vm = HomeVM()
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                topContainerView()
                bottomContainerView()
            }
            .frame(
                minWidth: 960,
                maxWidth: .infinity,
                minHeight: 640,
                maxHeight: .infinity,
                alignment: .topLeading
            )
            .background(Color.detailLayoutBackground)
            .sheet(isPresented: $vm.isSheetActive) {
                // MARK: 새 프로젝트 열기 데이터를 받기 위한 뷰
                ImportPDFView(
                    isSheetActive: $vm.isSheetActive,
                    isNewProjectSettingDone: $vm.isNewProjectSettingDone
                )
                .frame(
                    minWidth: vm.getSheetWidth(height: geometry.size.height),
                    maxWidth: vm.getSheetWidth(height: geometry.size.height),
                    minHeight: geometry.size.height - 64
                )
                .environmentObject(projectFileManager)
                .environmentObject(myData)
            }
            .navigationDestination(isPresented: $vm.isNewProjectSettingDone) {
                ProjectDocumentView()
                    .environmentObject(projectFileManager)
                    .environmentObject(myData)
                    .presentedWindowStyle(.titleBar)
                    .navigationBarBackButtonHidden()
                    .frame(maxWidth: .infinity)
            }
            .onAppear {
                initProject()
                AppFileManager.shared.readPreviousProject()
            }
        }
    }
    // MARK: 테스트용 데이터 가져와서 넣기
    private func initProject() {
        do {
            let data = try Data(contentsOf: AppFileManager.shared.url!)
            let file = try AppFileManager.shared.decodeJson(from: data)
            
            let PDFPages = file.projectDocument.PDFPages.map { pdfpage in
                PDFPage(keywords: pdfpage.keywords, script: pdfpage.script)
            }
            let PDFGroups = file.projectDocument.PDFGroups.map { pdfGroup in
                PDFGroup(
                    name: pdfGroup.name,
                    range: PDFGroupRange(start: pdfGroup.range.start, end: pdfGroup.range.end),
                    setTime: pdfGroup.setTime)
            }
            projectFileManager.pdfDocument = PDFDocumentManager(
                url: AppFileManager.shared.url!,
                PDFPages: PDFPages,
                PDFGroups: PDFGroups)
            projectFileManager.projectMetadata = ProjectMetadata(
                projectName: file.projectMetadata.projectName,
                projectGoal: file.projectMetadata.projectGoal,
                projectTarget: file.projectMetadata.projectTarget,
                presentationTime: file.projectMetadata.presentationTime,
                creatAt: Date())
            projectFileManager.practices = [Practice(
                saidKeywords: file.practices[0].saidKeywords,
                speechRanges: file.practices[0].speechRanges.map { speechRange in
                    SpeechRange(start: speechRange.start, group: speechRange.group)
                },
                progressTime: file.practices[0].progressTime,
                audioPath: URL(string: file.practices[0].audioPath)!
            ),
                Practice(
                    saidKeywords: file.practices[1].saidKeywords,
                    speechRanges: file.practices[1].speechRanges.map { speechRange in
                        SpeechRange(start: speechRange.start, group: speechRange.group)
                    },
                    progressTime: file.practices[1].progressTime,
                    audioPath: URL(string: file.practices[1].audioPath)!
                )
            ]
        } catch {
            print("Error decoding JSON: \(error)")
        }
    }
}

extension HomeView {
    // MARK: 페이지 타이틀
    private func topContainerView() -> some View {
        VStack(alignment: .leading, spacing: 0) {
            Image(vm.LOGO_NAME)
                .resizable()
                .scaledToFit()
                .frame(
                    width: vm.LOGO_SIZE.width,
                    height: vm.LOGO_SIZE.height)
                .padding(.top, .spacing800)
                .padding(.bottom, .spacing200)
            SectionHeaderView(info: vm.TOP_TEXT_INFO)
                .padding(.bottom, .spacing800)
            newProjectButtonView()
        }
        .border(width: 1, edges: [.bottom], color: Color.systemGray100)
        .padding(.horizontal, vm.HORIZONTAL_PADDING)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private func bottomContainerView() -> some View {
        VStack(alignment: .leading, spacing: 0) {
            SectionHeaderView(info: vm.BOTTOM_TEXT_INFO)
                .padding(.top, .spacing800)
                .padding(.horizontal, vm.HORIZONTAL_PADDING)
            projectListView(files: AppFileManager.shared.files)
        }
    }
        
    // MARK: 새 프로젝트 생성하기 버튼 - 클릭 시 ImportPDFView sheet 열기
    private func newProjectButtonView() -> some View {
        VStack(spacing: .spacing200) {
            Image(systemName: vm.NEW_PROJECT_BUTTON_INFO.icon)
                .resizable()
                .scaledToFit()
                .foregroundColor(Color.systemGray200)
                .frame(width:  vm.SYMBOL_OUTER_SIZE, height: .spacing800, alignment: .top)
                .offset(x: 5, y: 5)
            Button {
                vm.isSheetActive.toggle()
            } label: {
                Text(vm.NEW_PROJECT_BUTTON_INFO.label)
                    .systemFont(.body)
            }
            .buttonStyle(AppButtonStyle(width: 180, height: 46))
            // MARK: - 개발 편의를 위한 네비게이션 버튼
//            NavigationLink {
//                ProjectDocumentView()
//                    .environmentObject(projectFileManager)
//                    .environmentObject(myData)
//                    .presentedWindowStyle(.titleBar)
//                    .navigationBarBackButtonHidden()
//                    .frame(maxWidth: .infinity)
//            } label: {
//                Text(vm.NEW_PROJECT_BUTTON_INFO.label)
//                    .font(Font.system(size: 16))
//            }
//            .buttonStyle(AppButtonStyle())
        }
        .frame(maxWidth: .infinity, alignment: .top)
        .padding(.bottom, .spacing800)
    }
    
    // MARK: 프로젝트 리스트
    private func projectListView(files: [KkoProject]) -> some View {
        Group {
            if files.isEmpty {
                emptyItemView()
                    .padding(.top, .spacing800)
            } else {
                GeometryReader { geometry in
                    let containerWidth = geometry.size.width - vm.HORIZONTAL_PADDING * 2
                    ScrollView(showsIndicators: false, content: {
                        projectCardContainerView(
                            files: files,
                            containerWidth: containerWidth
                        )
                        .padding(.bottom, 32)
                    })
                    .frame(width: containerWidth,
                           height: geometry.size.height)
                    .padding(.top, .spacing200)
                    .padding(.horizontal, vm.HORIZONTAL_PADDING)
                }
            }
        }
    }
    
    // MARK: 리스트가 없을 때 보여지는 뷰
    private func emptyItemView() -> some View {
        VStack(spacing: .spacing200) {
            Image(systemName: vm.EMPTY_TEXT_INFO.icon)
                .resizable()
                .scaledToFit()
                .foregroundColor(Color.systemGray200)
                .frame(width:  vm.SYMBOL_OUTER_SIZE, height: vm.SYMBOL_OUTER_SIZE)
            Text(vm.EMPTY_TEXT_INFO.label)
                .foregroundColor(Color.systemGray300)
                .systemFont(.body)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
    
    // MARK: 리스트가 있을 때 보여지는 그리드
    private func projectCardContainerView(
        files: [KkoProject],
        containerWidth: CGFloat) -> some View {
        LazyVGrid(
            columns: vm.requestCardListColumns(containerWidth: containerWidth),
            alignment: .leading,
            spacing: .spacing500) {
                ForEach(files, id: \.id) { file in
                    ProjectCardView(
                        path: file.path,
                        title: file.title,
                        date: file.createAt,
                        width: vm.calcCardWidth(containerWidth: containerWidth)
                    )
                    .onTapGesture {
                        // PDF파일의 경로를 통해서 해당 파일에 같이 있는 appProjectList.json을 읽는다.
                        // 해당 파일을 읽고 CodableProjectFileManager에 값을 초기화
                        // CodableProjectFileManager를 ProjectFileManager에 잘 넣고
                        // MyData에도 값을 잘 넣는다.
                        // PresentationView 화면으로 넘긴다.
                        let tempURL = file.path
                            .deletingLastPathComponent()
                            .appendingPathComponent(
                                "appProjectList.json",
                                conformingTo: .json
                            )
                        do {
                            let data = try Data(contentsOf: tempURL)
                            let decoder = JSONDecoder()
                            let codableProjectModel = try decoder.decode(CodableProjectModel.self, from: data)
                            projectFileManager.makeProjectModel(codableData: codableProjectModel, url: file.path)
                            // myData에 데이터넣기
                            myData.clear()
                            myData.url = file.path
                            myData.title = projectFileManager.projectMetadata!.projectName
                            myData.target = projectFileManager.projectMetadata!.projectTarget
                            myData.time = String(projectFileManager.projectMetadata!.presentationTime)
                            myData.purpose = projectFileManager.projectMetadata!.projectGoal
                            myData.images = convertPDFToImages(pdfDocument: PDFDocument(url: file.path)!)
                            for index in 0..<(projectFileManager.pdfDocument?.PDFPages.count)! {
                                myData.keywords.append((projectFileManager.pdfDocument?.PDFPages[index].keywords)!)
                                myData.script.append((projectFileManager.pdfDocument?.PDFPages[index].script)!)
                            }
                            for index in 0..<(projectFileManager.pdfDocument?.PDFGroups.count)! {
                                let start = projectFileManager.pdfDocument?.PDFGroups[index].range.start
                                let end = projectFileManager.pdfDocument?.PDFGroups[index].range.end
                                let minute = (projectFileManager.pdfDocument?.PDFGroups[index].setTime)! / 60
                                let second =  (projectFileManager.pdfDocument?.PDFGroups[index].setTime)! % 60
                                let name = projectFileManager.pdfDocument?.PDFGroups[index].name
                                
                                myData.groupData.append(
                                    [
                                        name!,
                                        String(minute),
                                        String(second),
                                        String(start!),
                                        String(end!)
                                    ]
                                )
                            }
                            //
                            vm.isNewProjectSettingDone = true
                        } catch {
                            print("JSON 실패")
                        }
                        
                    }
                }
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

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
