//
//  ForJaeRinApp.swift
//  ForJaeRin
//
//  Created by Yun Dongbeom on 2023/07/06.
//

import SwiftUI

@main
struct ForJaeRinApp: App {
    @StateObject var projectFileManager = ProjectFileManager()
    @State var stack = NavigationPath()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                HomeView(myData: MyData())
                    .environmentObject(projectFileManager)
            }
            .presentedWindowToolbarStyle(.expanded)
            .frame(
                minWidth: 960,
                maxWidth: .infinity,
                minHeight: 640,
                maxHeight: .infinity,
                alignment: .topLeading
            )
        }
        .windowResizability(.contentMinSize)
    }
}
