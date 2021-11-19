//
//  PermissionView.swift
//  Fetch Restaurants
//
//  Created by Tewodros Mengesha on 16.11.2021.
//

import SwiftUI
import Foundation

struct PermissionView: View {
    
    //State for animation
    @State var isAnimating = false
    let action: () -> Void
    
    var animation: Animation {
        .interpolatingSpring(stiffness: 0.5, damping: 0.5)
            .repeatForever()
            .delay(isAnimating ? .random(in: 0...1) : 0)
            .speed(isAnimating ? .random(in: 0.1...1) : 0)
    }
    
    var body: some View {
        GeometryReader { proxy in
            VStack {
                
                //Images
                ZStack {
                    ForEach(1 ..< 14) { i in
                        Image("food\(i % 7)")
                            .position(
                                x: .random(in: 0...proxy.size.width),
                                y: .random(in: 0...proxy.size.height / 2)
                            )
                            .animation(animation)
                    }
                    
                }.frame(height: proxy.size.height / 3)
                    .padding().padding().padding()
                
                
                //Text and Button
                Text("What to eat? 😋")
                    .font(.title)
                
                Text("Find restaurants Near You!")
                    .font(.headline)
           
                Spacer()
                
                
                Button(action: action) {
                    Text("Get Started")
                        .bold()
                }
                .padding()
                .frame(maxWidth: proxy.size.width - 50)
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(50)
                .shadow(radius: 10)
                .foregroundColor(.white)
            }
        }.onAppear {
            isAnimating.toggle()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PermissionView() {}
    }
}
