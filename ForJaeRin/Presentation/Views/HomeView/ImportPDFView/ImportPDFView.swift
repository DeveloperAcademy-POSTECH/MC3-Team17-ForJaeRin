//
//  ImportPdfView.swift
//  ForJaeRin
//
//  Created by Yun Dongbeom on 2023/07/12.
//

import SwiftUI

/**
 1. 창에서 기본 상단 x(닫기)버튼을 누를 시, 초기 화면으로 되돌아감
 2. 파일 추가하기 버튼 누르기 -> PDF 파일 가져오기 Finder Open
 3. 프로젝트 생성 - 세부 내용 작성(발표제목 / 발표 목적 / 발표 대상 / 발표 예정 소요시간)
 4. 스크립트 입력 기능 - 각 PDF 페이지 별 키워드 및 스크립트 작성
 5. 발표자료 그룹화 기능 - PDF 그룹화하기
 
 각 스텝별로 하위 뷰를 생성하여 작업하면 좋을 것 같습니다.
 
 */
// MARK: 새 프로젝트를 생성하기 위한 시트뷰
struct ImportPDFView: View {
    @EnvironmentObject var projectFileManager: ProjectFileManager
    @EnvironmentObject var myData: MyData
    @StateObject var vm = ImportPDFVM()

    // MARK: Sheet 창을 닫기 위한 바인딩 값
    @Binding var isSheetActive: Bool
    
    let mentions: [String] = ["PDF 가져오기", "PDF 가져오기", "발표 정보 입력하기", "스크립트 입력하기", "그룹 설정하기", ""]
    
    var body: some View {
        VStack {
            headerContainerView()
            bodyContainerView()
            footerContainerView()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .environmentObject(vm)
    }
    
    func previousButtonFuction () -> Bool {
        if vm.step == .importPDFFile {
            return true
        }
        return false
    }
    
    func nextButtonFuction () -> Bool {
        if vm.step == .importPDFFile && myData.url == Bundle.main.url(forResource: "sample", withExtension: "pdf") {
            return true
        }
        
        if vm.step.rawValue == 2 {
            if myData.title == "" || myData.purpose == "" || myData.target == "" || myData.time == "" {
                return true
            }
        }
        return false
    }
    
    func sendMyData() {
        var tempStr = myData.time
        tempStr.removeLast()
        var tempInt = Int(tempStr)
        var projectMetaData = ProjectMetadata(projectName: myData.title, projectGoal: myData.purpose, presentationTime: tempInt!, creatAt: Date())
        
        var pdfDocumentManager = PDFDocumentManager(url: myData.url, PDFPages: [], PDFGroups: [])
        
        var projectFileManager = ProjectFileManager()
    }
}

extension ImportPDFView {
    // MARK: 헤더 컨테이너 뷰
    func headerContainerView() -> some View {
        HStack {
            HStack {
                Text(mentions[vm.step.rawValue])
                    .font(.system(size: 24))
                Text("\(vm.step.rawValue)/4")
                    .font(.system(size: 15))
                    .opacity(0.3)
                    .padding(EdgeInsets(top: 12, leading: 16, bottom: 0, trailing: 0))
            }
            .padding(EdgeInsets(top: 48, leading: 40, bottom: 0, trailing: 0))
            
            Spacer()
            
            Button {
                print("닫기")
                isSheetActive = false
            } label: {
                Image(systemName: "xmark")
                    // .frame(width: 20, height: 20)
            }
            .padding(EdgeInsets(top: 46, leading: 0, bottom: 0, trailing: 40))
        }
        .frame(width: 868, height: 77)
    }
    
    // MARK: 바디 컨테이너 뷰 - 스탭별로 바뀌는 뷰
    func bodyContainerView() -> some View {
        VStack {
            if vm.step == .importPDFFile {
                Spacer()
                FileImporterButtonView()
                    .environmentObject(myData)
                    .buttonStyle(AppButtonStyle(backgroundColor: Color(hex: "8B6DFF")))
                Spacer()
            } else if vm.step == .setMetaData {
                Spacer()
                InputPresentationInfoView()
                    .environmentObject(myData)
                Spacer()
            } else if vm.step == .setScripts {
                Spacer()
                InputScriptView()
                    .environmentObject(myData)
                Spacer()
            } else if vm.step == .setGroup {
                SettingGroupView(
                    groupIndex: Array(repeating: -1, count: myData.images.count)
                ).environmentObject(myData)
            } else {
                // JSON 파일 생성 후 저장 및 PDF 파일 복사본 같이 저장
                
                //
            }
            
        }
    }
    
    // MARK: 푸터 컨테이너 뷰
    func footerContainerView() -> some View {
        HStack {
            if vm.step != .importPDFFile {

            }
            
            Spacer()
            
            Button {
                print("next")
                vm.step = ImportPDFStep.allCases[vm.step.rawValue + 1]
            } label: {
                Text("다음")
            }

            .buttonStyle(nextButtonFuction() ?
                         AppButtonStyle(backgroundColor: Color(hex: "2F2F2F").opacity(0.25), width: 92)
                            : AppButtonStyle(width: 92))
            .padding(EdgeInsets(top: 24, leading: 0, bottom: 29, trailing: 40))
            .disabled(nextButtonFuction())

        }
        .padding(.top, 24)
        .padding(.bottom, 32)
        .background(Color.sub100)
    }
    
//    if vm.step.rawValue > 1 {
//        vm.step = ImportPDFStep.allCases[vm.step.rawValue - 1]
//    }
    
    func footerButtonView(isActive: Bool, action: @escaping () -> Void) -> some View {
        Button {
            action()
        } label: {
            Text("이전")
        }
        .buttonStyle(
            previousButtonFuction()
            ? AppButtonStyle(backgroundColor : Color(hex: "2F2F2F").opacity(0.25), width: 92)
                        : AppButtonStyle(width: 92))
        .padding(EdgeInsets(top: 24, leading: 40, bottom: 29, trailing: 0))
        .disabled(previousButtonFuction())
    }
}


struct ImportPDFView_Previews: PreviewProvider {
    static var previews: some View {
        @State var isSheetActive = false
        ImportPDFView(isSheetActive: $isSheetActive)
    }
}
