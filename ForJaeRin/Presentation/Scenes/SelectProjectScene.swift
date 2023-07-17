//
//  SelectProjectScene.swift
//  ForJaeRin
//
//  Created by Yun Dongbeom on 2023/07/17.
//

import Foundation
import SwiftUI

struct SclectProjectScene: Scene {
    @ObservedObject var projectFileManager: ProjectFileManager

    var body: some Scene {
        Window("Home", id: "Home") {
            HomeView()
                .onAppear {
                    print(projectFileManager.pdfDocument?.PDFPages[0].script)
                    
                }
        }
        .windowResizability(.contentMinSize)
    }
}
struct TestWindowButtonView: View {
    @Environment(\.newDocument) private var newDocument

    var body: some View {
        Button("Open Activity Window") {
            newDocument({KkoDocument()})
        }
    }
}
