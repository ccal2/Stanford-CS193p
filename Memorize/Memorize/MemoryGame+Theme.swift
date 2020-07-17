//
//  MemoryGame+Theme.swift
//  Memorize
//
//  Created by c.cruz.agra.lopes on 08/07/20.
//  Copyright © 2020 Carolina Lopes. All rights reserved.
//

import SwiftUI

extension MemoryGame {

    struct Theme: Hashable {

        // MARK: - Properties

        let name: String
        let content: Set<CardContent>
        let color: Color
        let numberOfPairsOfCards: Int?

        // MARK: - Initializers

        init(name: String, content: Set<CardContent>, color: Color, numberOfPairsOfCards: Int? = nil) {
            self.name = name
            self.content = content
            self.color = color
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
                                            color: .orange)

    static let animals = MemoryGame.Theme(name: "Animals",
                                          content: ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐨", "🐯",
                                                    "🦁", "🐮", "🐷", "🐸", "🐵", "🐔", "🐧", "🐦", "🐤", "🐺",
                                                    "🐗", "🐴", "🦄", "🐝", "🐛", "🦋", "🐌", "🐞", "🐜", "🐢",
                                                    "🐙", "🦑", "🐳"],
                                          color: .green,
                                          numberOfPairsOfCards: 5)

    static let sports = MemoryGame.Theme(name: "Sports",
                                         content: ["⚽️", "🏀", "🏈", "⚾️", "🥎", "🎾", "🏐", "🏉"],
                                         color: .gray,
                                         numberOfPairsOfCards: 2)

    static let faces = MemoryGame.Theme(name: "Faces",
                                        content: ["😄", "😂", "☺️", "😇", "🙃", "😍", "😘", "😋", "🤪", "🧐",
                                                  "😎", "🤩", "🥳", "😏", "😞", "😕", "😣", "😫", "🥺", "😭",
                                                  "😤", "🤬", "🤯", "😳", "🥶", "😱", "🤗", "🤫", "😬", "🙄",
                                                  "😴", "🤤", "🤮", "🤧", "😷", "🤠"],
                                        color: .yellow,
                                        numberOfPairsOfCards: 3)

    static let professions = MemoryGame.Theme(name: "Professions",
                                              content: ["👮‍♀️", "👷‍♀️", "🕵️‍♀️", "👩‍⚕️", "👩‍🌾", "👩‍🍳", "👩‍🎤", "👩‍🏫", "👩‍🏭", "👩‍💻",
                                                        "👩‍🔧", "👩‍🔬", "👩‍🎨", "👩‍🚒", "👩‍✈️", "👩‍🚀", "👩‍⚖️"],
                                              color: .blue)

    static let clothings = MemoryGame.Theme(name: "Clothings",
                                            content: ["🧥", "🥼", "🦺", "👚", "👕", "👖", "🩲", "🩳", "👔", "👗",
                                                      "👙", "👘", "🥻", "🩱", "🧦", "🧤", "🧣"],
                                            color: .purple)

}
