//
//  ForJaeRinApp.swift
//  ForJaeRin
//
//  Created by Yun Dongbeom on 2023/07/06.
//

import SwiftUI

@main
struct ForJaeRinApp: App {
    var body: some Scene {
        WindowGroup {
//            FileSystemView()
//            RecordView()
            ContentView()
                .toolbarBackground(Color.systemWhite)
                .environmentObject(ProjectFileManager())
        }
        .commands {
            ToolbarCommands()
        }
        .windowToolbarStyle(.expanded)
    }
}
