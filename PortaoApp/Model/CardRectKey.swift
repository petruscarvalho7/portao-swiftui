//
//  CardRectKey.swift
//  PortaoApp
//
//  Created by Petrus Carvalho on 11/08/23.
//

import SwiftUI

struct CardRectKey: PreferenceKey {
    static var defaultValue: [String: Anchor<CGRect>] = [:]
    
    static func reduce(value: inout [String: Anchor<CGRect>], nextValue: () -> [String: Anchor<CGRect>]) {
        value.merge(nextValue()) { $1 }
    }
}
