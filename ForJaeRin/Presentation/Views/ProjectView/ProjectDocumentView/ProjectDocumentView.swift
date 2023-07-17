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
