//
//  MyData.swift
//  ForJaeRin
//
//  Created by 이재혁 on 2023/07/17.
//

import SwiftUI

class MyData: ObservableObject {
    @Published var url: URL = Bundle.main.url(forResource: "sample", withExtension: "pdf")!
    
    @Published var title: String = ""
    @Published var target: String = ""
    @Published var time: String = ""
    @Published var purpose: String = ""
    
    @Published var pageIndex: Int = 0
    
    @Published var keywords: [[String]] = []
    @Published var script: [String] = []
}
