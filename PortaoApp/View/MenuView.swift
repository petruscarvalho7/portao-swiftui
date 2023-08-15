//
//  MenuView.swift
//  PortaoApp
//
//  Created by Petrus Carvalho on 15/08/23.
//

import SwiftUI

enum TabsSelection: String {
    case invoice = "Invoice"
    case charts = "Charts"
    case cards = "Cards"
    case transfer = "Transfer"
}

struct MenuView: View {
    @Binding var tabSelected: TabsSelection
    @Binding var showMenu: Bool
    
    // smooth transition
    @Namespace var namespace
    
    var body: some View {
        VStack {
            // Profile
            HStack {
                Image("defaultProfile")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 45, height: 45)
                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                
                Text("Monkey D. Luffy")
                    .font(.title3)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .foregroundColor(.white)
                
            }
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
            .padding()
            
            VStack(alignment: .leading, spacing: 15) {
                TabButton(iconName: "dollarsign.arrow.circlepath", tab: .invoice)
                
                TabButton(iconName: "chart.bar.xaxis", tab: .charts)
                
                TabButton(iconName: "creditcard", tab: .cards)
                
                TabButton(iconName: "paperplane", tab: .transfer)

            }
            .frame(width: getRect().width / 2, alignment: .leading)
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
            .padding()
            .padding(.top, 40)
            
            Spacer()
            
            Button {
                
            } label: {
                HStack {
                    Image(systemName: "rectangle.portrait.and.arrow.right")
                        .foregroundColor(.white)
                    
                    Text("Logout")
                        .font(.callout)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
            }
            .padding(30)
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)

        }
        .frame(maxHeight: .infinity, alignment: .top)
        .background(
            Color("NavyColor")
        )
    }
}

// tab buttons
extension MenuView {
    @ViewBuilder
    func TabButton(iconName: String, tab: TabsSelection) -> some View {
        Button {
            withAnimation {
                tabSelected = tab
            }
        } label: {
            HStack {
                Image(systemName: iconName)
                    .font(.title3)
                    .frame(width: tabSelected == tab ? 48 : nil, height: 48)
                    .background(
                        ZStack {
                            if tabSelected == tab {
                                Color.white
                                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                                    .matchedGeometryEffect(id: "tabCircle", in: namespace)
                            }
                        }
                    )
                    .foregroundColor(tabSelected == tab ? nil : .white)
                
                Text(tab.rawValue)
                    .font(.callout)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                
            }
            .padding(.trailing)
            .background(
                ZStack {
                    if tabSelected == tab {
                        Color("AccentColor")
                            .clipShape(Capsule())
                            .matchedGeometryEffect(id: "tabCapsule", in: namespace)
                    }
                }
            )
        }
        .offset(x: tabSelected == tab ? 15 : 0)
            
    }
}

#Preview {
    MenuView(tabSelected: .constant(.invoice), showMenu: .constant(true))
}
