//
//  CustomBorderModifier.swift
//  ForJaeRin
//
//  Created by Yun Dongbeom on 2023/07/16.
//

import Foundation
import SwiftUI

struct DottedBorder: Shape {
    var lineWidth: CGFloat = 1
    var dash: [CGFloat] = [4, 4] // Customize the dash pattern here

    func path(in rect: CGRect) -> Path {
        var path = Path()
        let cgLineDash = dash.map { CGFloat($0) }
        path.addRect(rect)
        return path.applying(CGAffineTransform(scaleX: 1, y: 1)).strokedPath(StrokeStyle(lineWidth: lineWidth, dash: cgLineDash))
    }
}
