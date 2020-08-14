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
        var isFaceUp: Bool = false

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

        // MARK: - Static Methods

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

// MARK: - Identifiable

extension SetGame.Card: Identifiable {

    var id: String {
        "(\(shape), \(quantity), \(shading), \(color))"
    }

}

// MARK: - Equatable

extension SetGame.Card: Equatable { }

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
