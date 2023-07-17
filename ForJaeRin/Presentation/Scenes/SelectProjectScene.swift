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
                .environmentObject(projectFileManager)
        }
        .windowResizability(.contentMinSize)
    }
}
