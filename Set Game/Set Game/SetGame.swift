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
    private(set) var dealtCards: [Card]

    private var numberOfSelectedCards: Int {
        var count = 0

        for card in dealtCards where card.isSelected {
            count += 1
        }

        return count
    }

    private var selectedCardsIndexes: [Int] {
        var indexes: [Int] = []

        for (index, card) in dealtCards.enumerated() where card.isSelected {
            indexes.append(index)
        }

        return indexes
    }

    // MARK: Constant

    let initialNumberOfCards: Int = 12

    // MARK: - Methods

    // MARK: Initializer

    init() {
        deck = []
        dealtCards = []
        startNewGame()
    }

    // MARK: Game logic

    mutating func startNewGame() {
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

        dealtCards = deck.deal(numberOfCards: initialNumberOfCards)
    }

    mutating func deal3Cards() {
        resolveMatch()
        dealtCards += deck.deal(numberOfCards: 3)
    }

    mutating func select(_ card: Card) {
        if numberOfSelectedCards == 3 {
            if dealtCards[selectedCardsIndexes[0]].isMatched {
                resolveMatch()
                if dealtCards.count < 12 {
                    deal3Cards()
                }
            } else {
                for index in dealtCards.indices {
                    dealtCards[index].state.revertMatchTest()
                }
            }
        }

        guard let index = dealtCards.firstIndex(matching: card) else {
            return
        }

        if numberOfSelectedCards < 3 || dealtCards[index].isSelected {
            dealtCards[index].isSelected.toggle()
        }

        if numberOfSelectedCards == 3 {
            let indexes = selectedCardsIndexes
            if isSet(dealtCards[indexes[0]], dealtCards[indexes[1]], card3: dealtCards[indexes[2]]) {
                dealtCards[indexes[0]].isMatched = true
                dealtCards[indexes[1]].isMatched = true
                dealtCards[indexes[2]].isMatched = true
            } else {
                dealtCards[indexes[0]].isMatched = false
                dealtCards[indexes[1]].isMatched = false
                dealtCards[indexes[2]].isMatched = false
            }
        }
    }

    mutating func resolveMatch() {
        dealtCards = dealtCards.filter { !$0.isMatched }
    }

    private func isSet(_ card1: Card, _ card2: Card, card3: Card) -> Bool {
        if  ( allEqual(card1.shape, card2.shape, card3.shape) || allDifferent(card1.shape, card2.shape, card3.shape) )
            && ( allEqual(card1.quantity, card2.quantity, card3.quantity) || allDifferent(card1.quantity, card2.quantity, card3.quantity) )
            && ( allEqual(card1.shading, card2.shading, card3.shading) || allDifferent(card1.shading, card2.shading, card3.shading) )
            && ( allEqual(card1.color, card2.color, card3.color) || allDifferent(card1.color, card2.color, card3.color) )
        {
            return true
        } else {
            return false
        }
    }

}

// MARK: - Card

extension SetGame {

    struct Card: Identifiable {

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

        // MARK: Identifiable

        var id: String {
            "(shape: \(shape), quantity: \(quantity), shading: \(shading), color: \(color))"
        }

        // MARK: - State

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

}


// MARK: - Enums

extension SetGame {

    enum Shape: CaseIterable {
        case diamond
        case rectangle
        case oval
    }

    enum Quantity: Int, CaseIterable {
        case one = 1
        case two
        case three
    }

    enum Shading: CaseIterable {
        case open
        case striped
        case solid
    }

    enum Color: CaseIterable {
        case red
        case green
        case purple
    }

}
