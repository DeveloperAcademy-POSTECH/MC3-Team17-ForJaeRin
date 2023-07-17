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
        Window("Activity", id: "activity") {
            
            Text("hello")
            TestWindowButtonView()
        }
        WindowGroup(id: "Book Details") {
//            FileSystemView()
//            RecordView()
            ContentView()
                .toolbarBackground(Color.systemWhite)
                .environmentObject(ProjectFileManager())
        }
        .commands {
            ToolbarCommands()
        }
        .windowToolbarStyle(.unifiedCompact(showsTitle: false))
    }
}

struct TestWindowButtonView: View {
    @Environment(\.openWindow) private var openWindow

    var body: some View {
        Button("Open Activity Window") {
            openWindow(id: "Book Details")
        }
    }
}
