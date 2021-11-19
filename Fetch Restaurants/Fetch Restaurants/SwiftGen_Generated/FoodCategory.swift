//
//  FoodCategory.swift
//  Fetch Restaurants
//
//  Created by Tewodros Mengesha on 16.11.2021.
//

import Foundation

/*
 "food_tags": [
 "alcohol",
 "wine",
 "beer",
 "Gin",
 "party"
 ]
 */
enum FoodCategory: String, CaseIterable, Equatable {
    case all, salad, burger, pizza
    case coffee, beer, wine

    var emoji: String {
        switch self {
        case .all:
            return "\u{1F959}"
        case .salad:
            return "\u{1F957}"
        case .burger:
            return "\u{1F354}"
        case .pizza:
            return "\u{1F355}"
        case .coffee:
            return "\u{2615}"
        case .beer:
            return "\u{1F37A}"
        case .wine:
            return "\u{1F377}"
        }
    }

    var alias: String {
        switch self {
        case .all:
            return "restaurants"
        case .salad:
            return "salad"
        case .burger:
            return "burger"
        case .pizza:
            return "pizza"
        case .coffee:
            return "coffee"
        case .beer:
            return "beer"
        case .wine:
            return "wine"
        }
    }
}
