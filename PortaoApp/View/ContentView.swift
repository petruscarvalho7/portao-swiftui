//
//  ContentView.swift
//  PortaoApp
//
//  Created by Petrus Carvalho on 11/08/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        GeometryReader {
            let size = $0.size
            
            LoggedInView(size: size)
        }
        .preferredColorScheme(.light)
    }
}

#Preview {
    ContentView()
}
