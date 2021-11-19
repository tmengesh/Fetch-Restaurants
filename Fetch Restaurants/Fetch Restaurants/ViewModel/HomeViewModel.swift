//
//  HomeViewModel.swift
//  Fetch Restaurants
//
//  Created by Tewodros Mengesha on 16.11.2021.
//

import Foundation
import Combine
import MapKit
import ExtensionKit

final class HomeViewModel: ObservableObject {
    
    @Published var restaurants = [Restaurant]()
    @Published var searchText : String
    @Published var selectedCategory : FoodCategory
    @Published var region : MKCoordinateRegion
    @Published var restaurant : Restaurant?
    @Published var showModal : Bool
    @Published var cityName = ""
    
    
    let manager = CLLocationManager()

    
    init() {
        searchText = ""
        selectedCategory = .all
        region = .init()
        restaurant = nil
        showModal = manager.authorizationStatus == .notDetermined
        //Helps to bring better user experience by fetching location quicker with less consumption of battery compared to kCLLocationAccuracyBest
        manager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        
        request()
    }
    
    func requestPermission() {
        manager
            .requestLocationWhenInUseAuthorization()
            .map{ $0 == .notDetermined}
            .assign(to: &$showModal)
    }
    
    func getLocation() -> AnyPublisher<CLLocation, Never> {
        manager.receiveLocationUpdates(oneTime: true)
            .replaceError(with: [])
            .compactMap(\.first)
            .eraseToAnyPublisher()
    }
    
    func request(service: WoltAPiService = .live) {
        let location = getLocation().share()
        
        $searchText
            .combineLatest($selectedCategory, location)
            .flatMap { (term, category, location) in
                service.request(
//                    .search(
//                        term: term,
//                        location: location,
//                        category: term.isEmpty ? category : nil
//                    )
                    .listAll(location: location)
                        
                )
            }
            .assign(to: &$restaurants)
        
        location
            .flatMap {
                $0.reverseGeocode()
            }
            .compactMap(\.first)
            .compactMap(\.locality)
            .replaceError(with: "No city name")
            .assign(to: &$cityName)
    }
    
  
}
