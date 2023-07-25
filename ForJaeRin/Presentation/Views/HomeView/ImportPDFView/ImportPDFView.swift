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
    
    var body: some View {
        VStack(spacing: 0) {
            headerContainerView()
            bodyContainerView()
            footerContainerView()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .environmentObject(vm)
        .environmentObject(myData)
    }
//    func sendMyData() {
//        var tempStr = myData.time
//        tempStr.removeLast()
//        let tempInt = Int(tempStr)
//        var projectMetaData = ProjectMetadata(
//            projectName: myData.title,
//            projectGoal: myData.purpose,
//            presentationTime: tempInt!,
//            creatAt: Date()
//        )
//
//        var pdfDocumentManager = PDFDocumentManager(
//            url: myData.url,
//            PDFPages: [],
//            PDFGroups: []
//        )
//
//        var projectFileManager = ProjectFileManager()
//    }
}

extension ImportPDFStep {
    var view: any View {
        switch self {
        case .importPDFFile:
            return FileImporterButtonView()
        case .setMetaData:
            return InputPresentationInfoView()
        case .setScripts:
            return InputScriptView()
        case .setGroup:
            return SettingGroupView()
        }
    }
}

extension ImportPDFView {
    // MARK: 헤더 컨테이너 뷰
    func headerContainerView() -> some View {
        HStack {
            HStack(spacing: 16) {
                Text(vm.step.title)
                    .systemFont(.headline)
                Text("\(vm.step.rawValue + 1)/4")
                    .systemFont(.caption1)
                    .opacity(0.3)
            }
            Spacer()
            Button {
                isSheetActive = false
            } label: {
                Image(systemName: "xmark")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 16, maxHeight: 16)
                    .foregroundColor(Color.systemGray200)
            }
            .buttonStyle(.plain)
            .frame(maxWidth: 24, maxHeight: 24)
        }
        .padding(.top, 48)
        .padding(.horizontal, 40)
        .frame(maxWidth: .infinity, alignment: .topLeading)
    }
    
    // MARK: 바디 컨테이너 뷰 - 스탭별로 바뀌는 뷰
    func bodyContainerView() -> some View {
        VStack {
            AnyView(vm.step.view)
        }
        .padding(.vertical, 40)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    // MARK: 푸터 컨테이너 뷰
    func footerContainerView() -> some View {
        HStack {
            if vm.step != .importPDFFile {
                footerButtonView(
                    info: vm.PREV_BUTTON_INFO,
                    isActive: vm.checkIsStepFirst()) {
                        vm.handlePrevButton()
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            footerButtonView(
                info: vm.NEXT_BUTTON_INFO,
                isActive: vm.checkIsCanGoToNext(myData: myData)) {
                    vm.handleNextButton()
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .padding(.vertical, 28)
        .padding(.horizontal, 40)
        .background(Color.sub100)
        .frame(maxWidth: .infinity)
    }
    
    // MARK: label로 변환해주기
    func footerButtonView(
        info: (icon: String, label: String),
        isActive: Bool,
        action: @escaping () -> Void
    ) -> some View {
        Button {
            action()
        } label: {
            Text(info.label)
        }
        .buttonStyle(
            !isActive
            ? AppButtonStyle(
                backgroundColor: Color.systemGray200,
                width: vm.FOOTER_BUTTON_SIZE,
                height: 42
            )
            : AppButtonStyle(
                backgroundColor: Color.systemPoint,
                width: vm.FOOTER_BUTTON_SIZE,
                height: 42
            )
        )
        .disabled(!isActive)
    }
}

struct ImportPDFView_Previews: PreviewProvider {
    static var previews: some View {
        @State var isSheetActive = false
        ImportPDFView(isSheetActive: $isSheetActive)
    }
}
