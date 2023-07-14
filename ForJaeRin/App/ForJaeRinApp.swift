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
                .toolbar(id: "main") {
                    ToolbarView()
                }
                .edgesIgnoringSafeArea(.top)
        }
        .commands {
            ToolbarCommands()
        }
        .windowToolbarStyle(.expanded)
    }
}
