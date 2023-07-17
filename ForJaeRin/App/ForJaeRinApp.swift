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
        SclectProjectScene(projectFileManager: projectFileManager)
        DocumentGroup(newDocument: {KkoDocument()}, editor: { _ in ProjectDocumentView()
                .environmentObject(projectFileManager)
        })
//            .commandsRemoved()
        
//        WindowGroup(id: "Book Details") {
////            FileSystemView()
////            RecordView()
//            ContentView()
//                .toolbarBackground(Color.systemWhite)
//                .environmentObject(ProjectFileManager())
//        }
//        .commands {
//            ToolbarCommands()
//        }
//        .windowToolbarStyle(.unifiedCompact(showsTitle: false))
    }
}
