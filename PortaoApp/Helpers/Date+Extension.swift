//
//  Date+Extension.swift
//  PortaoApp
//
//  Created by Petrus Carvalho on 11/08/23.
//

import Foundation

extension Date {
    static func addMonth(_ numberOfMonths: Int) -> Self {
        let currentDate = Date()
        var dateComponent = DateComponents()
        
        dateComponent.month = numberOfMonths
        
        if let returnDate = Calendar.current.date(byAdding: dateComponent, to: currentDate) {
            return returnDate
        } else {
            return currentDate
        }
    }
}
