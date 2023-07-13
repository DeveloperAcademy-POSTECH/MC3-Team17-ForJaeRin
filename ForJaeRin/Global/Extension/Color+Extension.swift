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
    
    static var primary: Self = .primary500
    
}

// MARK: Design Token - Primary Color
extension Color {
    /// 프라이머리 컬러
    static var primary500: Self {
        .init(hex: "#8B6DFF")
    }
    static var primary400: Self {
        .init(hex: "#C9C1FF")
    }
    static var primary300: Self {
        .init(hex: "#DED9FF")
    }
    static var primary200: Self {
        .init(hex: "#EAE7FF")
    }
    static var primary100: Self {
        .init(hex: "#F7F5FF")
    }
}

// swiftlint:enable identifier_name
