//
//  InputScriptVM.swift
//  ForJaeRin
//
//  Created by Yun Dongbeom on 2023/07/30.
//

import Foundation

class InputScriptVM: ObservableObject {
    @Published var script: [String] = []
    @Published var pageNumber: Int = 0
    
    func isScriptEmpty() -> Bool {
        return script.isEmpty
    }
}
