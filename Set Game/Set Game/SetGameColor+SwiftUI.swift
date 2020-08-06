//
//  SetGameColor+SwiftUI.swift
//  Set Game
//
//  Created by c.cruz.agra.lopes on 06/08/20.
//  Copyright © 2020 Carolina Lopes. All rights reserved.
//

import struct SwiftUI.Color

extension SetGame.Color {

    var rawValue: SwiftUI.Color {
        switch self {
        case .red:
            return .red
        case .green:
            return .green
        case .purple:
            return .purple
        }
    }

}
