//
//  InvoiceModel.swift
//  PortaoApp
//
//  Created by Petrus Carvalho on 11/08/23.
//

import SwiftUI

struct InvoiceModel: Identifiable {
    var id: UUID = .init()
    var type: InvoiceType
    var value: [InvoiceValue]
}

struct InvoiceValue: Identifiable {
    var id: UUID = .init()
    var month: Date
    var amount: Double
}

enum InvoiceType: String {
    case income = "Income"
    case expense = "Expense"
}

var invoicesMock: [InvoiceModel] = [
    InvoiceModel(
        type: .income,
        value: [
            InvoiceValue(month: .addMonth(-4), amount: 2550),
            InvoiceValue(month: .addMonth(-3), amount: 1850),
            InvoiceValue(month: .addMonth(-2), amount: 3980),
            InvoiceValue(month: .addMonth(-1), amount: 2370),
        ]
    ),
    InvoiceModel(
        type: .expense,
        value: [
            InvoiceValue(month: .addMonth(-4), amount: 2871),
            InvoiceValue(month: .addMonth(-3), amount: 1678),
            InvoiceValue(month: .addMonth(-2), amount: 897),
            InvoiceValue(month: .addMonth(-1), amount: 1987),
        ]
    )
]
