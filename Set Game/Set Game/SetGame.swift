//
//  SetGame.swift
//  Set Game
//
//  Created by c.cruz.agra.lopes on 27/07/20.
//  Copyright © 2020 Carolina Lopes. All rights reserved.
//

struct SetGame {

    // MARK: - Properties

    private(set) var deck: [Card]

    // MARK: - Methods

    // MARK: Initializer

    init() {
        deck = []

        for shape in Shape.allCases {
            for quantity in Quantity.allCases {
                for shading in Shading.allCases {
                    for color in Color.allCases {
                        deck.append(Card(shape: shape, quantity: quantity, shading: shading, color: color))
                    }
                }
            }
        }

        deck.shuffle()
    }

    // MARK: Game logic

    func testAction() {
        print("The deck has \(deck.count) cards:")
        for card in deck {
            print(card)
        }
        print()
    }

}

// MARK: - Card

extension SetGame {

    struct Card: CustomStringConvertible {

        // MARK: - Properties

        // MARK: Content

        let shape: Shape
        let quantity: Quantity
        let shading: Shading
        let color: Color

        // MARK: CustomStringConvertible

        var description: String {
            "(shape: \(shape), quantity: \(quantity), shading: \(shading), color: \(color))"
        }

    }

}

// MARK: - Enums

extension SetGame {

    enum Shape: String, CaseIterable {
        case diamond
        case rectangle
        case oval

        var description: String {
            rawValue
        }
    }

    enum Quantity: Int, CaseIterable {
        case one = 1
        case two
        case three

        var description: String {
            String(rawValue)
        }
    }

    enum Shading: String, CaseIterable {
        case open
        case striped
        case solid

        var description: String {
            rawValue
        }
    }

    enum Color: String, CaseIterable {
        case red
        case green
        case purple

        var description: String {
            rawValue
        }
    }

}
