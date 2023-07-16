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
    
    static var systemPrimary: Self = .primary500
    
}

// MARK: Design Token - Primary Color
extension Color {
    /// 프라이머리 컬러
    static var primary500: Self {
        .init(hex: "#8B6DFF")
    }
    static var primary400: Self {
        .init(hex: "#AC9FFF").opacity(0.65)
    }
    static var primary300: Self {
        .init(hex: "#AC9FFF").opacity(0.4)
    }
    static var primary200: Self {
        .init(hex: "#AC9FFF").opacity(0.25)
    }
    static var primary100: Self {
        .init(hex: "#AC9FFF").opacity(0.1)
    }
}

// MARK: Design Token - System Gray Color
extension Color {
    static var systemBlack: Self {
        .init(hex: "#000000")
    }
    static var systemGray500: Self {
        .init(hex: "#353535")
    }
    static var systemGray400: Self {
        .init(hex: "#565656")
    }
    static var systemGray300: Self {
        .init(hex: "#6D6D6D")
    }
    static var systemGray200: Self {
        .init(hex: "#9A9A9A")
    }
    static var systemGray100: Self {
        .init(hex: "#DDDDDD")
    }
    static var systemWhite: Self {
        .init(hex: "#FFFFFF")
    }
}

// MARK: Design Token - PDF Group Color
extension Color {
    static var groupPurple: Self {
        .init(hex: "#E3D8FB")
    }
    static var groupYellow: Self {
        .init(hex: "#FCEABF")
    }
    static var groupGreen: Self {
        .init(hex: "#BDE1DD")
    }
    static var groupPink: Self {
        .init(hex: "#FFDFF0")
    }
    static var groupOrange: Self {
        .init(hex: "#FFDCBC")
    }
    static var groupBlue: Self {
        .init(hex: "#D4E3F8")
    }
    static var groupGray: Self {
        .init(hex: "#D9D9D9")
    }
}

extension Color {
    static var detailLayoutBackground: Self {
        .init(hex: "#F6F5FA")
    }
}

// swiftlint:enable identifier_name
