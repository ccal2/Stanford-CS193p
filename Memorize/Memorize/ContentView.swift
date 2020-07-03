//
//  ContentView.swift
//  Memorize
//
//  Created by c.cruz.agra.lopes on 02/07/20.
//  Copyright © 2020 Carolina Lopes. All rights reserved.
//

import SwiftUI

struct ContentView: View {

    var body: some View {
        HStack {
            ForEach(0 ..< 4) { _ in
                CardView(isFaceUp: false)
            }
        }
            .padding()  // this is applied only for the stack
            .foregroundColor(.orange)  // all views inside it will have a .orange foregroundColor
            .font(.largeTitle)  // this is applied to all texts inside the stack
    }
}

struct CardView: View {

    var isFaceUp: Bool

    var body: some View {
        ZStack {
            if isFaceUp {
                RoundedRectangle(cornerRadius: 10.0)
                    .fill(Color.white)
                RoundedRectangle(cornerRadius: 10.0)
                    .stroke(lineWidth: 3.0)
                Text("👻")
            } else {
                RoundedRectangle(cornerRadius: 10.0)
                    .fill()
            }
        }
    }
}









// MARK: - Preview

struct ContentView_Previews: PreviewProvider {

    static var previews: some View {
        ContentView()
    }

}
