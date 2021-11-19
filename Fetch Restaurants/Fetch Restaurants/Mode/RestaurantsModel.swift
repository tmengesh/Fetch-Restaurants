//
//  RestaurantsModel.swift
//  Fetch Restaurants
//
//  Created by Tewodros Mengesha on 16.11.2021.
//


import Foundation

// MARK: - SearchResult
struct SearchResult : Codable {

        let restaurants : [Restaurant]
        let status : String?

        enum CodingKeys: String, CodingKey {
            case restaurants = "results"
            case status = "status"
        }
    
        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            status = try values.decodeIfPresent(String.self, forKey: .status)
            restaurants = try values.decodeIfPresent([Restaurant].self, forKey: .restaurants)!
        }

}
