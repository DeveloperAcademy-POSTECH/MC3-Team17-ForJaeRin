//
//  RoundedCornerView.swift
//  ForJaeRin
//
//  Created by Yun Dongbeom on 2023/07/27.
//

import SwiftUI

struct RoundedCornerView: Shape {
    var topLeft: CGFloat = 0.0
    var topRight: CGFloat = 0.0
    var bottomLeft: CGFloat = 0.0
    var bottomRight: CGFloat = 0.0

    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height

        // Ensure the corner radii don't exceed the size of the rectangle
        let topRight = min(self.topRight, width/2, height/2)
        let topLeft = min(self.topLeft, width/2, height/2)
        let bottomLeft = min(self.bottomLeft, width/2, height/2)
        let bottomRight = min(self.bottomRight, width/2, height/2)

        path.move(to: CGPoint(x: width / 2.0, y: 0))
        path.addLine(to: CGPoint(x: width - topRight, y: 0))
        path.addArc(
            center: CGPoint(x: width - topRight, y: topRight),
            radius: topRight,
            startAngle: Angle(degrees: -90),
            endAngle: Angle(degrees: 0),
            clockwise: false
        )
        path.addLine(to: CGPoint(x: width, y: height - bottomRight))
        path.addArc(
            center: CGPoint(x: width - bottomRight, y: height - bottomRight),
            radius: bottomRight,
            startAngle: Angle(degrees: 0),
            endAngle: Angle(degrees: 90),
            clockwise: false)
        path.addLine(to: CGPoint(x: bottomLeft, y: height))
        path.addArc(
            center: CGPoint(x: bottomLeft, y: height - bottomLeft),
            radius: bottomLeft,
            startAngle: Angle(degrees: 90),
            endAngle: Angle(degrees: 180),
            clockwise: false)
        path.addLine(to: CGPoint(x: 0, y: topLeft))
        path.addArc(
            center: CGPoint(x: topLeft, y: topLeft),
            radius: topLeft, startAngle: Angle(degrees: 180),
            endAngle: Angle(degrees: 270),
            clockwise: false
        )
        return path
    }
}

struct RoundedCornerView_Previews: PreviewProvider {
    static var previews: some View {
        RoundedCornerView()
    }
}
