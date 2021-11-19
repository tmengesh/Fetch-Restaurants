//
//  RestaurantCell.swift
//  Fetch Restaurants
//
//  Created by Tewodros Mengesha on 17.11.2021.
//

import SwiftUI

@available(iOS 15.0, *)
struct RestaurantCell: View {
    
    let restaurant: Restaurant
    
    var body: some View {
        NavigationLink(destination: DetailView(selectedRestaurant: restaurant)) {
            HStack {
                //Image
                AsyncImage(url: restaurant.formattedImageUrl) {
                    image in
                    image.resizable()
                } placeholder: {
                    Color.gray
                }
                .frame(width: 110, height: 110)
                .cornerRadius(10)
                .padding(.small)
                
                //Labels
                VStack(alignment: .leading, spacing: .small){
                    Text(restaurant.formattedRestaurantName)
                    Text(restaurant.formattedCategory.capitalizingFirstLetter())
                    HStack {
                        Text(restaurant.formattedRating)
                        Image("star")
                    }
                }
                Spacer()
                
            }
        }
        

    }
}

//struct RestaurantCell_Previews: PreviewProvider{
//    static var previews: some View {
//        RestaurantCell()
//    }
//
//}
