//
//  MyData.swift
//  ForJaeRin
//
//  Created by 이재혁 on 2023/07/17.
//

import SwiftUI

class MyData: ObservableObject {
    @Published var url: URL = Bundle.main.url(forResource: "sample", withExtension: "pdf")!
    
    @Published var images: [NSImage] = [NSImage]()
    
    @Published var title: String = ""
    @Published var target: String = ""
    @Published var time: String = ""
    @Published var purpose: String = ""
    
    @Published var pageIndex: Int = 0
    
    @Published var keywords: [Keywords] = []
    @Published var script: [String] = []
    
    // [그룹이름, 그룹에 할당된 분, 그룹에 할당된 초, 그룹에 할당된 첫번째 인덱스, 그룹에 할당된 마지막 인덱스]
    @Published var groupData: [[String]] = []
    
    func clear() {
        self.images = [NSImage]()
        self.title = ""
        self.target = ""
        self.time = ""
        self.purpose = ""
        
        self.pageIndex = 0
        
        self.keywords = []
        self.script = []
        
        self.groupData = []
    }
    
}
