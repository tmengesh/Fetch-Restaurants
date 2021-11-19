//
//  DetailView.swift
//  Fetch Restaurants
//
//  Created by Tewodros Mengesha on 18.11.2021.
//

import SwiftUI
import MapKit

struct RestaurantLocation: Identifiable {
    let id = UUID()
        let name: String
        let coordinate: CLLocationCoordinate2D
}

@available(iOS 15.0, *)
struct DetailView: View {
    
    let selectedRestaurant: Restaurant
    
    @EnvironmentObject var viewModel : HomeViewModel
    
    @State private var locations: [Location] = []
    @State var region = MKCoordinateRegion(center: CLLocationCoordinate2D(
       latitude: 24.9305454, longitude: 60.1667953),
       latitudinalMeters: 250, longitudinalMeters: 250 )

    @State var annotation = [
        RestaurantLocation(name: "Restaurant Name", coordinate: CLLocationCoordinate2D(latitude: 24.9305454, longitude: 60.1667953))
    ]
    
    private func setRegion() {
        region = MKCoordinateRegion(center: CLLocationCoordinate2D(
            latitude: selectedRestaurant.formattedLatitude, longitude: selectedRestaurant.formattedLongitude),
                span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        updateAnnotation()
     }
    
    private func updateAnnotation() {
        annotation[0] = RestaurantLocation(name: selectedRestaurant.formattedRestaurantName,coordinate: CLLocationCoordinate2D(latitude: selectedRestaurant.formattedLatitude, longitude: selectedRestaurant.formattedLongitude))
    }
    
    
    
    
    var body: some View {
        ZStack(alignment: .top) {
            //Spacer
            Rectangle()
                .fill(Color.clear)
            
           //Map
            Map(coordinateRegion: $region, annotationItems: annotation) {
                MapPin(coordinate: $0.coordinate)
//                MapMarker(coordinate: $0.coordinate)
            }
            .frame(width: 400, height: 300)
                .onAppear {self.setRegion()}
                .frame(height: UIScreen.main.bounds.height * 0.45)
            
        }.overlay(
            DetailCard(selectedRestaurant: selectedRestaurant, isFavourate: selectedRestaurant.isFavourite),
            alignment: .bottom
        )
        .ignoresSafeArea(edges: [.top, .bottom])
    }
}

//struct DetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailView(id: "60a63ff9fc52ff0aceecf648")
//            .environmentObject(HomeViewModel())
//    }
//}
