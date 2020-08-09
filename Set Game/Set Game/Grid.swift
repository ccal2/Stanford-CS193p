//
//  Grid.swift
//  Memorize
//
//  Created by c.cruz.agra.lopes on 08/07/20.
//  Copyright © 2020 Carolina Lopes. All rights reserved.
//

import SwiftUI

struct Grid<Item: Identifiable, ItemVIew: View>: View {

    // MARK: - Properties

    private var items: [Item]
    private var viewForItem: (Item) -> ItemVIew

    // MARK: - Body

    var body: some View {
        GeometryReader { geometry in
            self.body(for: GridLayout(itemCount: self.items.count, in: geometry.size))
        }
    }

    private func body(for layout: GridLayout) -> some View {
        ForEach(items) { item in
            self.viewForItem(item)
                .frame(width: layout.itemSize.width, height: layout.itemSize.height)
                .position(layout.location(ofItemAt: self.items.firstIndex(matching: item)!))
        }
    }

    // MARK: - Methods

    // MARK: Itializer

    init(_ items: [Item], viewForItem: @escaping (Item) -> ItemVIew) {
        self.items = items
        self.viewForItem = viewForItem
    }

}
