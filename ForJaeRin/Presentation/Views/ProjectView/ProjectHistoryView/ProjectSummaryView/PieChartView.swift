//
//  PieChartView.swift
//  ForJaeRin
//
//  Created by Yun Dongbeom on 2023/07/26.
//

import SwiftUI

// MARK: - 원 그래프

struct PieChartView: View {
    @State var slices: [(Double, Color)]
    
    var body: some View {
        Canvas { context, size in
            //도넛 모양
            let donut = Path { path in
                path.addEllipse(in: CGRect(origin: .zero, size: size))
                path.addEllipse(in: CGRect(x: size.width * 0.1, y: size.height * 0.1, width: size.width * 0.8, height: size.height * 0.8))
            }
            context.clip(to: donut, style: .init(eoFill: true))
            
            let total = slices.reduce(0) { $0 + $1.0 }
            context.translateBy(x: size.width * 0.5, y: size.height * 0.5)
            var pieContext = context
            pieContext.rotate(by: .degrees(-90))
            let radius = min(size.width, size.height)

            var startAngle = Angle.zero
            for (value, color) in slices {
                let angle = Angle(degrees: 360 * (value / total))
                let endAngle = startAngle + angle
                let path = Path { path in
                    path.move(to: .zero)
                    path.addArc(center: .zero, radius: radius, startAngle: startAngle + Angle(degrees: 0), endAngle: endAngle, clockwise: false)
                    path.closeSubpath()
                }
                pieContext.fill(path, with: .color(color))
                startAngle = endAngle
            }
        }
        .aspectRatio(1, contentMode: .fit)
    }
}
