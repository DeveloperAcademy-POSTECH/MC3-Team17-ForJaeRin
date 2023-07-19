//
//  Font+Extension.swift
//  ForJaeRin
//
//  Created by Yun Dongbeom on 2023/07/17.
//

import Foundation
import SwiftUI
import Pretendard

extension Font {
    static var systemHeadline = Font.custom(Pretendard.bold.fontName, size: 24)
    static var systemSubtitle = Font.custom(Pretendard.semibold.fontName, size: 18)
    static var systemBody = Font.custom(Pretendard.medium.fontName, size: 16)
    static var systemCaption1 = Font.custom(Pretendard.regular.fontName, size: 14)
    static var systemCaption2 = Font.custom(Pretendard.regular.fontName, size: 12)
}
