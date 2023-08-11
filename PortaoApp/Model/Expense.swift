//
//  Expense.swift
//  PortaoApp
//
//  Created by Petrus Carvalho on 11/08/23.
//

import SwiftUI

struct Expense: Identifiable {
    var id: UUID = .init()
    var amountSpent: String
    var product: String
    var productIcon: String
    var spendType: String
}

var expensesMock: [Expense] = [
    Expense(amountSpent: "$99", product: "Amazon", productIcon: "Amazon", spendType: "Groceries"),
    Expense(amountSpent: "$9.99", product: "Youtube", productIcon: "Youtube", spendType: "Streaming"),
    Expense(amountSpent: "$49", product: "Nintendo", productIcon: "Nintendo", spendType: "Games"),
    Expense(amountSpent: "$59", product: "Playstation", productIcon: "Playstation", spendType: "Games"),
    Expense(amountSpent: "$14.99", product: "Crunchyroll", productIcon: "Crunchyroll", spendType: "Streaming"),
    Expense(amountSpent: "$40", product: "UberEats", productIcon: "UberEats", spendType: "Groceries"),
    Expense(amountSpent: "$24.99", product: "Netflix", productIcon: "Netflix", spendType: "Streaming"),
    Expense(amountSpent: "$154.99", product: "Airbnb", productIcon: "Airbnb", spendType: "Travel"),
]
