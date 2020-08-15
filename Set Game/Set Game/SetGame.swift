//
//  SetGame.swift
//  Set Game
//
//  Created by c.cruz.agra.lopes on 27/07/20.
//  Copyright © 2020 Carolina Lopes. All rights reserved.
//

import Foundation

struct SetGame {

    // MARK: - Properties

    // MARK: Cards

    private(set) var deck: [Card] = []
    private(set) var dealtCards: [Card] = []

    // MARK: Score

    private(set) var score: Int = 0

    // MARK: Card selection control

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

    // MARK: Bonus control

    private let bonusTimeLimit: TimeInterval = 20.0
    private var searchingInitialDate: Date!

    // MARK: Hint control

    var hasSet: Bool {
        if case .set = isSetAvaliable() {
            return true
        } else {
            return false
        }
    }

    private var hintIndexes: [Int] {
        if case let .set(index1, index2, index3) = isSetAvaliable() {
            return [index1, index2, index3]
        } else {
            return []
        }
    }

    private var lastHint: [Card] = []

    // MARK: Constants

    let numberOfCardsToDeal: Int = 3
    private let initialNumberOfCards: Int = 12

    // MARK: - Static Properties

    static private let numberOfCardsInASet: Int = 3

    // MARK: - Methods

    // MARK: Game logic

    mutating func startNewGame() {
        score = 0
        deck = Card.createDeck().shuffled()

        var cards = deck.deal(numberOfCards: initialNumberOfCards)
        for index in cards.indices {
            cards[index].isFaceUp = true
        }

        dealtCards = cards
        searchingInitialDate = Date()
    }

    mutating func dealMoreCards() {
        guard !deck.isEmpty else { return }

        removeMatchedCards()

        if dealtCards.count >= initialNumberOfCards && hasSet {
            score -= 50
        }

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

    mutating func giveHint() {
        lastHint = []
        for index in hintIndexes {
            dealtCards[index].state = .suggested
            lastHint.append(dealtCards[index])
        }
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
        guard selectedCards.count == SetGame.numberOfCardsInASet else { return }

        let indeces = selectedCardsIndeces

        if SetGame.isSet(selectedCards) {
            let searchingDuration = Date().timeIntervalSince(searchingInitialDate)
            searchingInitialDate = Date()

            if selectedCards == lastHint { // used hint
                score += 50
            } else {
                let timeBonus = max(0, Int(bonusTimeLimit - searchingDuration) * 4)
                score += 100 + timeBonus
            }

            for index in indeces {
                dealtCards[index].isMatched = true
            }
        } else {
            score -= 30

            for index in indeces {
                dealtCards[index].isMatched = false
            }
        }
    }

    private mutating func removeMatchedCards() {
        dealtCards = dealtCards.filter { !$0.isMatched }
    }

    private func isSetAvaliable() -> AvailableSet {
        let count = dealtCards.count
        guard count >= 3 else { return .none }

        for i in 0 ..< count - 3 where !dealtCards[i].isMatched {
            for j in i+1 ..< count - 2 where !dealtCards[j].isMatched {
                for k in j+1 ..< count - 1 where !dealtCards[k].isMatched {
                    if SetGame.isSet([dealtCards[i], dealtCards[j], dealtCards[k]]) {
                        return .set(i, j, k)
                    }
                }
            }
        }

        return .none
    }

    // MARK: - Static Methods

    static func isSet(_ cards: [Card]) -> Bool {
        guard cards.count == numberOfCardsInASet else { return false }
        guard cards[0] != cards[1], cards[0] != cards[2], cards[1] != cards[2] else { return false }

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

extension SetGame {

    private enum AvailableSet {
        case none
        case set(Int, Int, Int)
    }

}
