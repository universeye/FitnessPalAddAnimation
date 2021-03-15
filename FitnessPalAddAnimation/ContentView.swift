//
//  ContentView.swift
//  FitnessPalAddAnimation
//
//  Created by Terry Kuo on 2021/3/3.
//

import SwiftUI
import PureSwiftUI


private let buttunBlue = Color(red: 42/255, green: 99/255, blue: 228/255)

private typealias TitleAndSymbol = (title: String, symbol: String) //define a tuple for extracting subview

private let buttunTitlesAndSymbols: [[TitleAndSymbol]] = [
    [("Favorite", "star"), ("Tag", "tag"), ("Share", "square.and.arrow.up")],
    [("Comment", "text.bubble"), ("Delete", "trash")]
]

struct ContentView: View {
    
    @State var homeLoacation: CGFloat = 0
    @State var showingButtuns = true
    
    var body: some View {
        
        
        ZStack {
            Color.black.opacity(showingButtuns ? 0.8 : 0).ignoresSafeArea().animation(.easeIn)
            
            VStack(spacing: 50) {
                Spacer()
                //buttunTitlesAndSymbols.count = 2
                ForEach(0 ..< buttunTitlesAndSymbols.count) { rowIndex in
                    HStack {
                        ForEach(0 ..< buttunTitlesAndSymbols[rowIndex].count) { colIndex in
                            MyFitnessPalButtun(titleAndSymbol: buttunTitlesAndSymbols[rowIndex][colIndex])
                                .opacity(showingButtuns ? 10 : 0)
                                .offsetToPositionIfNot(showingButtuns, 195.1, 770)
                                
                                //.offset(x:showingButtuns ? 0 : homeLoacation + 0, y: showingButtuns ? 0 : homeLoacation + 94)
                                .frame(width: 90, height: 50)
                                .animation(.spring())
                            
                        }
                    }
                }
               
                plusButton()
                    .rotationEffect(showingButtuns ? .degrees(-45) : .degrees(0))
                    .animation(.spring())
                    .onTapGesture {
                        showingButtuns.toggle()
                    }
                    
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct MyFitnessPalButtun: View {
    
    fileprivate let titleAndSymbol: TitleAndSymbol
    
    var body: some View {
        Circle()
            .fill(Color.white)
            .overlay(Image(systemName: titleAndSymbol.symbol).foregroundColor(.black))
            .overlay(
                Text(titleAndSymbol.title.uppercased())
                    .foregroundColor(.white)
                    //.font(.system(size: 10.5))
                    .font(Font.caption.weight(.semibold))
                    //.fixedSize()
                    .offset(y: 38))
            .frame(width: 90, height: 48)
    }
}

struct plusButton: View {
    
    @State var homeLoacation: CGFloat = 0
    
    var body: some View {
        GeometryReader { (geo: GeometryProxy) in
            
            Circle()
                .fill(buttunBlue)
                .overlay(Image(systemName: "plus").foregroundColor(.white))
                
                .frame(width: 48, height: 48)
                
                
            //Text("\(geo.frame(in: .global).midX)") //769.6
            //Text("\(geo.frame(in: .global).midY)") //195.1
           
        }
        .frame(width: 48, height: 48)
    }
}
