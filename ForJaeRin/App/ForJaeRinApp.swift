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
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                HomeView()
                    .environmentObject(projectFileManager)
            }
            .presentedWindowToolbarStyle(.expanded)
        }
    }
}
