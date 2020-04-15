//
//  ContentView.swift
//  simmerEffect
//
//  Created by Roman Emperor on 4/15/20.
//  Copyright © 2020 Emperors. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Home()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Home : View {
    @State var data = [String]()
    @State var show = false
    
    var body: some View {
        NavigationView{
            ScrollView(.vertical, showsIndicators: false) {
                VStack{
                    if self.data.isEmpty {
                        ForEach(0...10,id:\.self){_ in
                            CardShimmer()
                            
                        }
                    }else {
                        ForEach(self.data, id:\.self){ i in
                            CellView(pic:i)
                                .onTapGesture {
                                    self.show.toggle()
                            }
                        }
                    }
                }
            }
            .navigationBarTitle("Shimmer",displayMode: .inline)
        .navigationBarItems(trailing:
                Button(action: {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                        for i in 1...5 {
                            self.data.append("\(i)")
                        }
                    }

                    
                }, label: {
                    Image(systemName: "plus")
                    .resizable()
                        .frame(width: 18, height: 18)
                        .foregroundColor(.blue)
                })
            )
        }
        .sheet(isPresented: self.$show){
            TextShimmer()
        }
    }
}

struct CellView: View {
    var pic: String
    var body: some View {
        Image(pic)
            .resizable()
                .frame(height:200)
                    .cornerRadius(10)
                        .padding(.horizontal)
                            .padding(.top)
        
    }
}

struct TextShimmer : View {
    @State var show = false
    var body: some View {
        
        ZStack{
            
            Color.black.edgesIgnoringSafeArea(.all)
            
            ZStack{
                Text("ROMAN")
                    .foregroundColor(Color.white.opacity(0.4))
                    .font(.system(size: 50))
                
                Text("ROMAN")
                    .foregroundColor(.white)
                    .font(.system(size: 50))
                .mask(
                    Capsule()
                        .fill(LinearGradient(gradient: .init(colors: [.clear,.white,.clear]), startPoint: .top, endPoint: .bottom))
                        .rotationEffect(.init(degrees: 30.0))
                        .offset(x:self.show ? 180 : -130)
                    )
            }
        }
        .onAppear{
            withAnimation(
            Animation.default
                .speed(0.13)
                .delay(0.01)
                .repeatForever(autoreverses: false)){
                self.show.toggle()
            }
            
        }
    }
}
    
struct CardShimmer: View {
    @State var show = false
    var center = (UIScreen.main.bounds.width / 2) + 110
    
    var body: some View {
        
        ZStack{
            
         Color.black
            .opacity(0.09)
            .frame(height:200)
            .cornerRadius(10)

            Color.white
                .frame(height:200)
                .cornerRadius(10)
                .mask(
                    Rectangle()
                        .fill(LinearGradient(gradient: .init(colors: [.clear, Color.white.opacity(0.48),.clear]), startPoint: .top, endPoint: .bottom))
                        .rotationEffect(.init(degrees: 70))
                        .offset(x: self.show ? center : -center)
                    )

        
        }
        .padding(.horizontal)
        .padding(.top)
        .onAppear{
            withAnimation(
            Animation.default
                .speed(0.15)
                .delay(0)
                .repeatForever(autoreverses: false)){
                self.show.toggle()
            }
        }
    }
}
