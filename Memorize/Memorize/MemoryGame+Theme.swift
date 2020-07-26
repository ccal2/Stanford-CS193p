//
//  MemoryGame+Theme.swift
//  Memorize
//
//  Created by c.cruz.agra.lopes on 08/07/20.
//  Copyright © 2020 Carolina Lopes. All rights reserved.
//

import struct SwiftUI.Color

extension MemoryGame {

    struct Theme: Hashable {

        // MARK: - Properties

        let name: String
        let content: Set<CardContent>
        let gradientColors: [Color]
        let numberOfPairsOfCards: Int?

        // MARK: - Initializers

        init(name: String, content: Set<CardContent>, gradientColors: [Color], numberOfPairsOfCards: Int? = nil) {
            self.name = name
            self.content = content
            self.gradientColors = gradientColors
            self.numberOfPairsOfCards = numberOfPairsOfCards
        }

    }

}

// MARK: - Basic Themes for String CardContent

extension MemoryGame.Theme where CardContent == String {

    static let allBasics: Set = [halloween, animals, sports, faces, professions, clothings]

    static let halloween = MemoryGame.Theme(name: "Halloween",
                                            content: ["👻", "🎃", "🕷", "🧟‍♀️", "🔮", "🦇", "🕸", "🧛🏻‍♀️", "🤡", "⚰️",
                                                      "🔪", "🩸"],
                                            gradientColors: [.orange, .purple])

    static let animals = MemoryGame.Theme(name: "Animals",
                                          content: ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐨", "🐯",
                                                    "🦁", "🐮", "🐷", "🐸", "🐵", "🐔", "🐧", "🐦", "🐤", "🐺",
                                                    "🐗", "🐴", "🦄", "🐝", "🐛", "🦋", "🐌", "🐞", "🐜", "🐢",
                                                    "🐙", "🦑", "🐳"],
                                          gradientColors: [.green, .yellow],
                                          numberOfPairsOfCards: 5)

    static let sports = MemoryGame.Theme(name: "Sports",
                                         content: ["⚽️", "🏀", "🏈", "⚾️", "🥎", "🎾", "🏐", "🏉"],
                                         gradientColors: [.gray, .green],
                                         numberOfPairsOfCards: 2)

    static let faces = MemoryGame.Theme(name: "Faces",
                                        content: ["😄", "😂", "☺️", "😇", "🙃", "😍", "😘", "😋", "🤪", "🧐",
                                                  "😎", "🤩", "🥳", "😏", "😞", "😕", "😣", "😫", "🥺", "😭",
                                                  "😤", "🤬", "🤯", "😳", "🥶", "😱", "🤗", "🤫", "😬", "🙄",
                                                  "😴", "🤤", "🤮", "🤧", "😷", "🤠"],
                                        gradientColors: [.yellow, .blue],
                                        numberOfPairsOfCards: 3)

    static let professions = MemoryGame.Theme(name: "Professions",
                                              content: ["👮‍♀️", "👷‍♀️", "🕵️‍♀️", "👩‍⚕️", "👩‍🌾", "👩‍🍳", "👩‍🎤", "👩‍🏫", "👩‍🏭", "👩‍💻",
                                                        "👩‍🔧", "👩‍🔬", "👩‍🎨", "👩‍🚒", "👩‍✈️", "👩‍🚀", "👩‍⚖️"],
                                              gradientColors: [.blue, .red])

    static let clothings = MemoryGame.Theme(name: "Clothings",
                                            content: ["🧥", "🥼", "🦺", "👚", "👕", "👖", "🩲", "🩳", "👔", "👗",
                                                      "👙", "👘", "🥻", "🩱", "🧦", "🧤", "🧣"],
                                            gradientColors: [.purple, .pink])

}
