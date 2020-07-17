//
//  Pie.swift
//  Memorize
//
//  Created by c.cruz.agra.lopes on 17/07/20.
//  Copyright © 2020 Carolina Lopes. All rights reserved.
//

import SwiftUI

struct Pie: Shape {

    // MARK: - Properties

    var startAngle: Angle
    var endAngle: Angle
    var clockwise: Bool = true

    // MARK: - Methods

    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2
        let start = CGPoint(
            x: center.x + radius * cos(CGFloat(startAngle.radians)),
            y: center.y + radius * sin(CGFloat(startAngle.radians))
        )
        var path = Path()

        path.move(to: center)
        path.addLine(to: start)
        path.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: clockwise)
        path.addLine(to: center)

        return path
    }

}
