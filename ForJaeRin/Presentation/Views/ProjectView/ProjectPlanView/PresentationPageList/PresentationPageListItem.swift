//
//  PresentationPageListItem.swift
//  ForJaeRin
//
//  Created by Yun Dongbeom on 2023/07/14.
//

import SwiftUI

struct PresentationPageListItem: View {
    @EnvironmentObject var projectFileManager: ProjectFileManager
    @State var groupIndex: Int
    @State var pageIndex: Int
    @State private var isShowingFullScreenImage = false //린 추가
    @State var pdfGroup: PDFGroup // 뷰모델이 만들어지면 인덱스로 조회해오자.
    // @State var pdfPage: PDFPage
    // 그룹의 첫번째 인덱스 == 페이지 인덱스
    @State var pageScript = ""
    @State var keywords: Keywords = []
    @FocusState var isFocus: Bool
    let scriptPlaceHolder = "스크립트를 입력해주세요."
    
    @Binding var clickedKeywordIndex: Int?
    @FocusState var focusField: Int?
    @Binding var lastIndexes: [Int]
    @State var currentHeight: CGFloat = 200.0
    
    @EnvironmentObject var myData: MyData
    
    var body: some View {
        VStack(spacing: 0) {
            if checkGroupFirstItem() {
                groupNotiView()
            }
            HStack(spacing: 0) {
                // 그룹 인디케이터
                groupIndicator()
                // 프레젠테이션(PDF) 컨테이너
                pdfContainer(pageIndex: pageIndex)
                    .sheet(isPresented: $isShowingFullScreenImage) {
                                            FullScreenImageView(isPresented: $isShowingFullScreenImage, pageIndex: pageIndex)
                                                .environmentObject(myData) // 환경 객체를 sheet로 전달합니다.
                                        } // 린 추가
                dottedDivider()
                // 스크립트 컨테이너
                scriptContainer()
                dottedDivider()
                // 키워드 컨테이너
                keywordContainer()
            }
            .background(Color.systemWhite)
            .cornerRadius(10)
            .padding(.bottom, .spacing300)
            // MARK: 이거 확인
            .frame(maxWidth: .infinity, minHeight: 200)
        }
        //.frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.horizontal, .spacing1000)
        .onAppear {
            // pageScript = pdfPage.script
            // keywords = pdfPage.keywords
        }
    }
    
    private func checkGroupFirstItem() -> Bool {
        if pageIndex == pdfGroup.range.start {
            return true
        } else {
            return false
        }
    }
}

extension PresentationPageListItem {
    private func groupNotiView() -> some View {
        ZStack {
            GeometryReader { geometry in
                Path { path in
                    let startPoint = CGPoint(x: 0, y: geometry.size.height / 2)
                    let endPoint = CGPoint(x: geometry.size.width, y: geometry.size.height / 2)
                    path.move(to: startPoint)
                    path.addLine(to: endPoint)
                }
                .stroke(style: StrokeStyle(lineWidth: 1, dash: [6]))
                .foregroundColor(GroupColor.allCases[groupIndex].text)
            }
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: 256, height: 28)
                .background(.white)
                .cornerRadius(30)
                .overlay(
                    RoundedRectangle(cornerRadius: 30)
                        .inset(by: 0.5)
                        .stroke(GroupColor.allCases[groupIndex].text, lineWidth:1)
                )
            TextField("그룹명을 작성해주세요", text: $pdfGroup.name)
                .fixedSize()
                .textFieldStyle(.plain)
                .systemFont(.caption1)
                .foregroundColor(GroupColor.allCases[groupIndex].text)
                .multilineTextAlignment(.center)
        }
        .padding(.top, myData.isOnboardingActive && pdfGroup.range.start == 0
                 ? .spacing300
                 :  pdfGroup.range.start == 0
                 ? .spacing600
                 : 0
        )
        .frame(maxWidth: .infinity, minHeight: 28)
        .padding(.bottom, .spacing300)
//        .padding(.horizontal, .spacing1000)
    }
    
    // MARK: 그룹 인디케이터
    private func groupIndicator() -> some View {
        Rectangle()
            .frame(width: 20)
            .foregroundColor(GroupColor.allCases[groupIndex].color)
    }
    
    // MARK: 프레젠테이션(PDF) 컨테이너 - 로키가 잘 해줄꺼야
    private func pdfContainer(pageIndex: Int) -> some View {
        // let pdfUrl = Bundle.main.url(forResource: "sample", withExtension: "pdf")!
        
        return ZStack(alignment: .topLeading) {
            Text("\(pageIndex + 1)")
                .offset(x: 6, y: -24)
                .zIndex(1)
                .systemFont(.caption1)
                .foregroundColor(Color.systemGray400)
            VStack {
                Image(nsImage: myData.images[pageIndex])
                    .resizable()
                    .frame(width: 212, height: 118)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.systemGray100,lineWidth:1)
                            .foregroundColor(Color.clear)
                            .cornerRadius(10)
                    )
            }
            .padding(.leading, .spacing500)
            .padding(.trailing, .spacing500)
            .frame(maxWidth: 318)
            .onTapGesture {
                           isShowingFullScreenImage = true
                       } //린 추가
        }
    }
    
    // MARK: 스크립트 컨테이너
    private func scriptContainer() -> some View {
        HStack {
            ZStack(alignment: .topLeading) {
                if myData.script[pageIndex].isEmpty {
                    Text(scriptPlaceHolder)
                        .systemFont(.body)
                        .foregroundColor(Color.systemGray100)
                        .zIndex(1)
                        .onTapGesture {
                            isFocus = true
                        }
                        .padding(.leading, 4)
                        .padding(.top, 12)
                }
                TextEditor(text: $myData.script[pageIndex])
                    .systemFont(.body)
                    .foregroundColor(Color.systemGray400)
                    .frame(minHeight: 182-48, maxHeight: .infinity)
            }
        }
        .frame(maxWidth: 206, maxHeight: .infinity)
        .padding(.leading, 8)
        .border(.blue)
//        .padding(.trailing, .spacing500)
    }
    
    // MARK: 키워드 컨테이너
    private func keywordContainer() -> some View {
        ZStack(alignment:.topLeading) {
            KeywordView(
                pageNumber: pageIndex,
                lastIndexes: $lastIndexes,
                currentHeight: $currentHeight,
                focusField: _focusField,
                clickedKeywordIndex: $clickedKeywordIndex)
            .border(.blue)
            .padding(.vertical, 12)
            .padding(.leading, .spacing400)
            .padding(.trailing, .spacing600)
        }
        .border(.red)
    }
    
    //린 추가 : 이미지 눌렀을 때 뜨는 창
        struct FullScreenImageView: View {
            @EnvironmentObject var myData: MyData
            @Binding var isPresented: Bool
            let pageIndex: Int

            var body: some View {
                ZStack {
                    Image(nsImage: myData.images[pageIndex])
                        .resizable()
//                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 1134, maxHeight: 632)
                        .fixedSize()
                        .padding(.all, 0)
                        .onTapGesture {
                            isPresented = false
                        }
                }
                .edgesIgnoringSafeArea(.all) // 창 크기를 조절할 수 없도록 설정
                .background(Color.clear) // 흰색 여백을 없애기 위해 배경을 clear로 설정
            }
        }
    
    private func dottedDivider() -> some View {
        Rectangle()
            .strokeBorder(style: StrokeStyle(lineWidth: 1, dash: [3]))
            .foregroundColor(Color.systemGray100)
            .frame(minWidth:1, maxWidth: 1)
            .padding(.vertical, 24)
    }
}
