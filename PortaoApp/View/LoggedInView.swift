//
//  LoggedInView.swift
//  PortaoApp
//
//  Created by Petrus Carvalho on 15/08/23.
//

import SwiftUI

struct LoggedInView: View {
    var size: CGSize

    // Menu
    @State var tabSelected: TabsSelection = .invoice
    @State var showMenu: Bool = false

    var body: some View {
        ZStack {
            MenuView(tabSelected: $tabSelected, showMenu: $showMenu)
            
            HomeView(size: size, showMenu: $showMenu)
        }
    }
}

#Preview {
    ContentView()
}
