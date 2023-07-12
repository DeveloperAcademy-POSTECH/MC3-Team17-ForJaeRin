//
//  Color+Extension.swift
//  ForJaeRin
//
//  Created by Yun Dongbeom on 2023/07/12.
//
// swiftlint:disable identifier_name
import Foundation
import SwiftUI

extension Color {
    
    // MARK: 컬러를 Hex값을 사용하기 위해 확장한 생성자
    init(hex: String) {
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#")
        
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        
        let r = Double((rgb >> 16) & 0xFF) / 255.0
        let g = Double((rgb >>  8) & 0xFF) / 255.0
        let b = Double((rgb >>  0) & 0xFF) / 255.0
        self.init(red: r, green: g, blue: b)
    }
}
// swiftlint:enable identifier_name
