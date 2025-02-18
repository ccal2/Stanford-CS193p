//
//  SetGame+Card.swift
//  Set Game
//
//  Created by Carolina Cruz Agra Lopes on 08/08/20.
//  Copyright © 2020 Carolina Lopes. All rights reserved.
//

extension SetGame {

    struct Card {

        // MARK: - Properties

        // MARK: Content

        let shape: Shape
        let quantity: Quantity
        let shading: Shading
        let color: Color

        // MARK: Control

        var state: State = .unselected

        var isSelected: Bool {
            get {
                state == .selected || state == .matched || state == .unmatched
            }
            set {
                if newValue {
                    state = .selected
                } else {
                    state = .unselected
                }
            }
        }

        var isMatched: Bool {
            get {
                state == .matched
            }
            set {
                if newValue {
                    state = .matched
                } else {
                    state = .unmatched
                }
            }
        }

        // MARK: - Methods

        // MARK: Static

        static func createDeck() -> [Card] {
            var deck: [Card] = []

            for shape in Shape.allCases {
                for quantity in Quantity.allCases {
                    for shading in Shading.allCases {
                        for color in Color.allCases {
                            deck.append(Card(shape: shape, quantity: quantity, shading: shading, color: color))
                        }
                    }
                }
            }

            return deck
        }

    }

}

// MARK: - Identifiable & Equatable

extension SetGame.Card: Identifiable {

    var id: String {
        "(shape: \(shape), quantity: \(quantity), shading: \(shading), color: \(color))"
    }

}

// MARK: - State

extension SetGame.Card {
    
    enum State {
        case unselected
        case selected
        case matched
        case unmatched
        
        mutating func revertMatchTest() {
            if case .unmatched = self {
                self = .unselected
            }
        }
    }
    
}
