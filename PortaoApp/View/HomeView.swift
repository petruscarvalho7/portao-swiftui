//
//  HomeView.swift
//  PortaoApp
//
//  Created by Petrus Carvalho on 11/08/23.
//

import SwiftUI
import Charts

struct HomeView: View {
    var size: CGSize
    
    // animation properties
    @State private var expandCards: Bool = false
    
    //detail view
    @State private var showDetailView: Bool = false
    @State private var showDetailContent: Bool = false
    @State private var selectedCard: Card?
    @Namespace private var namespace
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Button {
                    
                } label: {
                    Image(systemName: "line.3.horizontal")
                        .font(.title2)
                        .foregroundColor(.black)
                }
                
                Spacer()
                
                VStack {
                    Text("Your Balance")
                        .font(.caption)
                        .foregroundColor(.black)
                    
                    Text("$2880.79")
                        .font(.title2)
                        .fontWeight(.bold)
                }
            }
            .padding([.horizontal, .top], 15)
            
            // Cards
            CardsView()
                .padding(.horizontal, 15)
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 15) {
                    BottomScrollView()
                }
                .padding(.top, 30)
                .padding([.horizontal, .bottom], 15)
            }
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
            .background {
                // CustomCorner
                CustomCornerShape(corners: [.topLeft, .topRight], radius: 30)
                    .fill(.white)
                    .ignoresSafeArea()
                    .shadow(color: .black.opacity(0.05), radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x: 0, y: -5)
            }
            .padding(.top, 20)
        }
        .background {
            Rectangle()
                .fill(.black.opacity(0.05))
                .ignoresSafeArea()
        }
        .overlay {
            Rectangle()
                .fill(.ultraThinMaterial)
                .ignoresSafeArea()
                .overlay(alignment: .top) {
                    if !showDetailView {
                        // top navigation
                        HStack {
                            Image(systemName: "chevron.left")
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    withAnimation(.easeInOut(duration: 0.3)) {
                                        expandCards = false
                                    }
                                }
                            
                            Spacer()
                            
                            Text("All Cards")
                                .font(.title2)
                                .fontWeight(.bold)
                        }
                        .padding(15)
                    }
                }
                .opacity(expandCards ? 1 : 0)
        }
        .overlay(content: {
            if let selectedCard, showDetailView {
                CardDetailView(selectedCard)
                    .transition(.asymmetric(insertion: .identity, removal: .offset(y: 5)))
            }
        })
        .overlayPreferenceValue(CardRectKey.self) { preferences in
            if let cardPreferences = preferences["CardRect"] {
                GeometryReader { proxy in
                    let cardRect = proxy[cardPreferences]
                    
                    CardContent()
                        .frame(width: cardRect.width, height: expandCards ? nil : cardRect.height)
                        .offset(x: cardRect.minX, y: cardRect.minY)
                }
                .allowsHitTesting(!showDetailView)
            }
        }
    }
}

// aux components
extension HomeView {
    @ViewBuilder
    func BottomScrollView() -> some View {
        VStack(spacing: 15) {
            VStack(alignment: .leading, spacing: 8) {
                Text("Favorite Transfer")
                    .font(.title3)
                    .fontWeight(.bold)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack (spacing: 15) {
                        ForEach(1...7, id: \.self) { index in
                            Image("pic-\(index)")
                                .resizable()
                                .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                                .frame(width: 55, height: 55)
                                .clipShape(Circle())
                        }
                    }
                    .padding(.horizontal, 15)
                    .padding(.top, 8)
                }
                .padding(.horizontal, -15)
            }
            
            // Charts
            VStack(alignment: .center, spacing: 8) {
                HStack {
                    Text("Overview")
                        .font(.title3)
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    Text("Last 4 Months")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                
                Chart(invoicesMock) { invoice in
                    ForEach(invoice.value) { data in
                        BarMark(x: .value("Month", data.month, unit: .month), y: .value(invoice.type.rawValue, data.amount))
                    }
                    .foregroundStyle(by: .value("Type", invoice.type.rawValue))
                    .position(by: .value("Type", invoice.type.rawValue))
                }
                .chartForegroundStyleScale(range: [Color.green.gradient, Color.red.gradient])
                .frame(height: 220)
                .padding(.top, 25)
                
            }
            .padding(.top, 15)
        }
    }
    
    @ViewBuilder
    func CardsView() -> some View {
        Rectangle()
            .foregroundColor(.clear)
            .frame(height: 245)
            .anchorPreference(key: CardRectKey.self, value: .bounds) { anchor in
                return ["CardRect": anchor]
            }
    }
    
    @ViewBuilder
    func CardContent() -> some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 0) {
                ForEach(cardsMock.reversed()) { card in
                    let index = CGFloat(cardIndexOf(card))
                    let reversedIndex = CGFloat(cardsMock.count - 1) - index
                    // displaying first three cards on the stack
                    let displayingStackIndex = min(index, 2)
                    let displayScale = (displayingStackIndex / CGFloat(cardsMock.count)) * 0.15
                    
                    ZStack {
                        if selectedCard?.id == card.id && showDetailView {
                            Rectangle()
                                .foregroundColor(.clear)
                        } else {
                            CardView(card)
                                //applying 3d rotation
                                .rotation3DEffect(
                                    .init(degrees: expandCards ? (showDetailView ? 0 : -15) : 0),
                                    axis: (x: 1, y: 0, z: 0),
                                    anchor: .top
                                )
                                // hero effect
                                .matchedGeometryEffect(id: card.id, in: namespace)
                                // hiding cards when the detail is displayed
                                .offset(y: showDetailView ? size.height : 0)
                                .onTapGesture {
                                    if expandCards {
                                        // expanding selected card
                                        selectedCard = card
                                        withAnimation(.easeInOut(duration: 0.3)) {
                                            showDetailView = true
                                        }
                                        
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                                            withAnimation(.easeInOut(duration: 0.3)) {
                                                showDetailContent = true
                                            }
                                        }
                                    } else {
                                        withAnimation(.easeInOut(duration: 0.35)) {
                                            expandCards = true
                                        }
                                    }
                                }
                        }
                    }
                    .frame(height: 200)
                    // applying scale
                    .scaleEffect(1 - (expandCards ? 0 : displayScale))
                    .offset(y: expandCards ? 0 : displayingStackIndex * -15)
                    // stacking one on another
                    .offset(y: reversedIndex * -200)
                    .padding(.top, expandCards ? (reversedIndex == 0 ? 0 : 80) : 0)
                }
            }
            // aplying remain height as padding
            .padding(.top, 45)
            // reducing size
            .padding(.bottom, CGFloat(cardsMock.count - 1) * -200)
        }
        .scrollDisabled(!expandCards)
    }
    
    @ViewBuilder
    func CardView(_ card: Card) -> some View {
        GeometryReader {
            let size = $0.size
            
            VStack(spacing: 0) {
                Rectangle()
                    .fill(card.cardColor.gradient)
                    .overlay(alignment: .top) {
                        VStack {
                            HStack {
                                Image("simcard")
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 55, height: 55)
                                
                                Spacer(minLength: 0)
                                
                                Image(systemName: "wave.3.right")
                                    .font(.largeTitle.bold())
                            }
                            
                            Text(card.cardBalance)
                                .font(.title2)
                                .fontWeight(.bold)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .offset(y: 5)
                        }
                        .padding(20)
                        .foregroundColor(.black)
                    }
                Rectangle()
                    .fill(.black)
                    .frame(height: size.height / 3.5)
                    .overlay {
                        HStack {
                            Text(card.cardName)
                                .fontWeight(.semibold)
                            
                            Spacer(minLength: 0)
                            
                            Image("visa")
                                .resizable()
                                .renderingMode(.template)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 40, height: 40)
                        }
                        .foregroundColor(.white)
                        .padding(15)
                    }
            }
            .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
        }
    }
    
    @ViewBuilder
    func CardDetailView(_ card: Card) -> some View {
        VStack(spacing: 0) {
            HStack {
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        showDetailContent = false
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            showDetailView = false
                        }
                    }
                }, label: {
                    Image(systemName: "chevron.left")
                        .font(.title3)
                        .fontWeight(.bold)
                })
                
                Spacer()
                
                Text("Transactions")
                    .font(.title2.bold())
            }
            .foregroundColor(.black)
            .padding(15)
            .opacity(showDetailContent ? 1 : 0)
            
            //CardView
            CardView(card)
                //applying 3d rotation
                .rotation3DEffect(
                    .init(degrees: showDetailContent ? 0 : -15),
                    axis: (x: 1, y: 0, z: 0),
                    anchor: .top
                )
                .matchedGeometryEffect(id: card.id, in: namespace)
                .frame(height: 200)
                .padding([.horizontal, .top], 15)
                .zIndex(1000)
            
            // expenses list
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 15) {
                    ForEach(expensesMock) { expense in
                        HStack(spacing: 12) {
                            Image(expense.productIcon)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 50, height: 50)
                                .clipShape(Circle())
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text(expense.product)
                                    .fontWeight(.bold)
                                
                                Text(expense.spendType)
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                            
                            Spacer(minLength: 0)
                            
                            Text(expense.amountSpent)
                                .fontWeight(.semibold)
                        }
                        
                        Divider()
                    }
                }
                .padding(.top, 25)
                .padding([.horizontal, .bottom], 15)
            }
            .background {
                CustomCornerShape(corners: [.topLeft, .topRight], radius: 30)
                    .fill(.white)
                    .padding(.top, -120)
                    .ignoresSafeArea()
            }
            // sliding effect
            .offset(y: !showDetailContent ? (size.height * 0.7) : 0)
            .opacity(showDetailContent ? 1 : 0)
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .background {
            Rectangle()
                .fill(.pink.opacity(0.2))
                .ignoresSafeArea()
                .opacity(showDetailContent ? 1 : 0)
        }
    }
}

extension HomeView {
    func cardIndexOf(_ card: Card) -> Int {
        return cardsMock.firstIndex {
            card.id == $0.id
        } ?? 0
    }
}

#Preview {
    ContentView()
}
