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
        DocumentGroup(newDocument: {KkoDocument()}, editor: { _ in ProjectDocumentView()})
            .commandsRemoved()
        
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

struct TestWindowButtonView2: View {
    var documentURL: URL
    @Environment(\.openDocument) private var openDocument

    var body: some View {
        Button("Open Document") {
           Task {
               do {
                   try await openDocument(at: documentURL)
               } catch {
                   // Handle error
               }
           }
       }
    }
}
