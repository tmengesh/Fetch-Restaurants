//
//  Fetch_RestaurantsApp.swift
//  Fetch Restaurants
//
//  Created by Tewodros Mengesha on 16.11.2021.
//

import SwiftUI

@available(iOS 15.0, *)
@main
struct Fetch_RestaurantsApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(HomeViewModel())
        }
    }
}

