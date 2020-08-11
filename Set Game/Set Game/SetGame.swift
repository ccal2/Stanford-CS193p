//
//  SetGame.swift
//  Set Game
//
//  Created by c.cruz.agra.lopes on 27/07/20.
//  Copyright © 2020 Carolina Lopes. All rights reserved.
//

struct SetGame {

    // MARK: - Properties

    // MARK: Cards

    private(set) var deck: [Card] = []
    private(set) var dealtCards: [Card] = []

    // MARK: Control

    private var selectedCards: [Card] {
        dealtCards.filter { $0.isSelected }
    }

    private var selectedCardsIndeces: [Int] {
        var indeces: [Int] = []

        for (index, card) in dealtCards.enumerated() where card.isSelected {
            indeces.append(index)
        }

        return indeces
    }

    // MARK: Constants

    let numberOfCardsToDeal: Int = 3
    private let initialNumberOfCards: Int = 12

    // MARK: - Static Properties

    static private let numberOfCardsInASet: Int = 3

    // MARK: - Methods

    // MARK: Game logic

    mutating func startNewGame() {
        deck = Card.createDeck().shuffled()

        var cards = deck.deal(numberOfCards: initialNumberOfCards)
        for index in cards.indices {
            cards[index].isFaceUp = true
        }

        dealtCards = cards
    }

    mutating func dealMoreCards() {
        removeMatchedCards()

        var cards = deck.deal(numberOfCards: numberOfCardsToDeal)
        for index in cards.indices {
            cards[index].isFaceUp = true
        }

        dealtCards += cards
    }

    mutating func select(_ card: Card) {
        handleLastMatchTest()

        guard let selectedCardIndex = dealtCards.firstIndex(matching: card) else { return }

        dealtCards[selectedCardIndex].isSelected.toggle()
        performMatchTest()
    }

    private mutating func handleLastMatchTest() {
        guard selectedCards.count == SetGame.numberOfCardsInASet else { return }

        if dealtCards[selectedCardsIndeces[0]].isMatched {
            removeMatchedCards()
            if dealtCards.count < initialNumberOfCards {
                dealMoreCards()
            }
        } else {
            for index in dealtCards.indices {
                dealtCards[index].state.revertMatchTest()
            }
        }
    }

    private mutating func performMatchTest() {
        if selectedCards.count == SetGame.numberOfCardsInASet {
            let indeces = selectedCardsIndeces
            if SetGame.isSet(selectedCards) {
                for index in indeces {
                    dealtCards[index].isMatched = true
                }
            } else {
                for index in indeces {
                    dealtCards[index].isMatched = false
                }
            }
        }
    }

    private mutating func removeMatchedCards() {
        dealtCards = dealtCards.filter { !$0.isMatched }
    }

    // MARK: - Static Methods

    static func isSet(_ cards: [Card]) -> Bool {
        guard cards.count == numberOfCardsInASet else { return false }

        let shapes = cards.map { $0.shape }
        let quantities = cards.map { $0.quantity }
        let shadings = cards.map { $0.shading }
        let colors = cards.map { $0.color }

        return shapes.isAllEqualOrAllDifferent()
            && quantities.isAllEqualOrAllDifferent()
            && shadings.isAllEqualOrAllDifferent()
            && colors.isAllEqualOrAllDifferent()
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
