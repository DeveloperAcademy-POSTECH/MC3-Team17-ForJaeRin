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
    static var systemPoint: Self = .point500
    
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

extension Color {
    static var point500: Self {
        .init(hex: "#2F2F2F")
    }
    static var sub100: Self {
        .init(hex: "#F6F5FA")
    }
    static var sub50: Self {
        .init(hex: "#FBFAFD")
    }
}

// MARK: Design Token - System Gray Color
extension Color {
    static var systemBlack: Self {
        .init(hex: "#000000")
    }
    static var systemGray500: Self {
        .init(hex: "#2F2F2F")
    }
    static var systemGray400: Self {
        .init(hex: "#2F2F2F").opacity(0.65)
    }
    static var systemGray300: Self {
        .init(hex: "#2F2F2F").opacity(0.45)
    }
    static var systemGray200: Self {
        .init(hex: "#2F2F2F").opacity(0.25)
    }
    static var systemGray100: Self {
        .init(hex: "#2F2F2F").opacity(0.1)
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
    static var groupPurpleText: Self {
        .init(hex: "#5000FF")
    }
    static var groupYellowText: Self {
        .init(hex: "#FFB300")
    }
    static var groupGreenText: Self {
        .init(hex: "#40C3B4")
    }
    static var groupPinkText: Self {
        .init(hex: "#FFACD9")
    }
    static var groupOrangeText: Self {
        .init(hex: "#FF7A00")
    }
    static var groupBlueText: Self {
        .init(hex: "#74AEFF")
    }
    static var groupGrayText: Self {
        .init(hex: "#848484")
    }
}

extension Color {
    static var detailLayoutBackground = sub100
}

// swiftlint:enable identifier_name

enum GroupColor: CaseIterable {
    case groupPurple
    case groupYellow
    case groupGreen
    case groupPink
    case groupOrange
    case groupBlue
    case groupGray
    
    var color: Color {
        switch self {
        case .groupPurple:
            return Color.groupPurple
        case .groupYellow:
            return Color.groupYellow
        case .groupGreen:
            return Color.groupGreen
        case .groupPink:
            return Color.groupPink
        case .groupOrange:
            return Color.groupOrange
        case .groupBlue:
            return Color.groupBlue
        case .groupGray:
            return Color.groupGray
        }
    }
    
    var text: Color {
        switch self {
        case .groupPurple:
            return Color.groupPurpleText
        case .groupYellow:
            return Color.groupYellowText
        case .groupGreen:
            return Color.groupGreenText
        case .groupPink:
            return Color.groupPinkText
        case .groupOrange:
            return Color.groupOrangeText
        case .groupBlue:
            return Color.groupBlueText
        case .groupGray:
            return Color.groupGrayText
        }
    }
}
