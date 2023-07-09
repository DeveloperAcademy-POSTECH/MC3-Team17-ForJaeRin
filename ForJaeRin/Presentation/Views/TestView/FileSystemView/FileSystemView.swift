//
//  FileSystemView.swift
//  ForJaeRin
//
//  Created by Yun Dongbeom on 2023/07/10.
//

import SwiftUI

struct FileSystemView: View {
    var body: some View {
        HStack {
            /// URL 경로 조회 버튼
            Button {
                AppFileManager.shared.printDocumentUrl()
            } label: {
                Text("URL 경로 조회")
            }
            /// Create New Child Directory
            Button {
                AppFileManager.shared.createNewDirectory()
            } label: {
                Text("Add New Directory")
            }
            /// Create New Child File
            Button {
                AppFileManager.shared.createNewFile()
            } label: {
                Text("Add New File")
            }
            /// Read File
            Button {
                AppFileManager.shared.readFile()
            } label: {
                Text("Read File")
            }
            /// Remove File
            Button {
                AppFileManager.shared.removeFile()
            } label: {
                Text("Remove File")
            }
            /// Remove Directory
            Button {
                AppFileManager.shared.removeDirectory()
            } label: {
                Text("Remove Directory")
            }
        }
    }
}

struct FileSystemView_Previews: PreviewProvider {
    static var previews: some View {
        FileSystemView()
    }
}
