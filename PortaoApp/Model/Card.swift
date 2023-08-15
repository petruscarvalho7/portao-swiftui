//
//  Card.swift
//  PortaoApp
//
//  Created by Petrus Carvalho on 11/08/23.
//

import SwiftUI

struct Card: Identifiable {
    var id: UUID = .init()
    var cardColor: Color
    var cardName: String
    var cardBalance: String
}

var cardsMock: [Card] = [
    Card(cardColor: .cyan, cardName: "iPortao", cardBalance: "$2000"),
    Card(cardColor: .blue, cardName: "PressCard 💰", cardBalance: "Unlimited Money"),
    Card(cardColor: .purple, cardName: "iPeladao", cardBalance: "$5600"),
    Card(cardColor: .red, cardName: "iRobbedYou", cardBalance: "$10000")
]
