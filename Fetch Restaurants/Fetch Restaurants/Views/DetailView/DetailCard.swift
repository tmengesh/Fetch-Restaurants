//
//  DetailCard.swift
//  Fetch Restaurants
//
//  Created by Tewodros Mengesha on 18.11.2021.
//

import SwiftUI

@available(iOS 15.0, *)
struct DetailCard: View {
    let selectedRestaurant: Restaurant
    @State var isFavourate : Bool


    var body: some View {
        VStack(alignment: .leading) {
            Group{
                
                
                Text(selectedRestaurant.formattedRestaurantName)
                    .bold()
                HStack {
                    Text(selectedRestaurant.formattedDescription)
                    Spacer()
                    
                    //isFavourate toggle
                    Button(action: {
                       self.isFavourate.toggle()
                    }) {
                        Image(systemName: self.isFavourate == true ? "heart.fill" : "heart")
                              .resizable()
                              .frame(width: 20, height: 20)
                    }
                }
            }
            
            
            
            Group {
                
                
                HStack {
                    Image("map")
                    Text(selectedRestaurant.formattedAddress)
                    Text(",")
                    Text(selectedRestaurant.formattedCity)

                }.font(.subheadline)
                
            }
            
            Group {
                HStack {
                    Image("phone")
                    Text(selectedRestaurant.formattedPhoneNumber)
                    
                    if(selectedRestaurant.rating?.rating != nil) {
                        Text("Rating: ")
                        ForEach(0..<(selectedRestaurant.rating?.rating!)!) {_ in
                            Image("star")
                        }
                    } else {
                        Text("Rating: Not available")
                    }
                   
                }
                .font(.subheadline)
                .padding(.bottom, .small)
            }
            
            Group {
                //Image
                AsyncImage(url: selectedRestaurant.formattedImageUrlForCard) {
                    image in
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                } placeholder: {
                    Color.gray
                }
            }.cornerRadius(.large)
        }
        .padding().padding()
        .background(Color.white)
        .cornerRadius(20)
        .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.height * 0.65)
    }
    
}

//struct DetailCard_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailCard()
//    }
//}
