//
//  ProjectDocumentView.swift
//  ForJaeRin
//
//  Created by Yun Dongbeom on 2023/07/17.
//

import SwiftUI

struct ProjectDocumentView: View {
    
    @EnvironmentObject var document: KkoDocument
    @Environment(\.undoManager) var undoManager
    
    var body: some View {
        VStack {
            Text(document.kkoProject.title)
            OpenWindowButton()
        }
        .onAppear {
            print(document.kkoProject.path)
        }
        
    }
}

struct ProjectDocumentView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectDocumentView()
    }
}

struct OpenWindowButton: View {
    @Environment(\.openWindow) private var openWindow

    var body: some View {
        Button("Open Activity Window") {
            openWindow(id: "Home")
        }
    }
}
