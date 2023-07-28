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
    
    @Published var keywords: [Keywords] = []
    @Published var script: [String] = []
    
    @Published var groupData: [[String]] = [] {
        didSet {
            print(groupData)
        }
    }
    
    func clear() {
        self.images = [NSImage]()
        self.title = ""
        self.target = ""
        self.time = ""
        self.purpose = ""
        
        self.keywords = []
        self.script = []
        
        self.groupData = []
    }
    
    func checkIsGroupDataInit(index: Int) -> Bool {
        groupData[index][0] != ""
        && groupData[index][1] != ""
        && groupData[index][2] != ""
        && groupData[index][3] != "-1"
        && groupData[index][4] != "-1"
    }
}
