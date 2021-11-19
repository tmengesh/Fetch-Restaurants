//
//  WoltApiService.swift
//  Fetch Restaurants
//
//  Created by Tewodros Mengesha on 16.11.2021.
//

import Foundation
import CoreLocation
import Combine

enum Endpoint {
    case listAll(location: CLLocation)
    case search(term: String?, location: CLLocation, category: FoodCategory?)
    case detail(id: String)
    
    var path: String {
        //With available endpoints, it's easier to do searching by keyword and filter by category.
        switch self {
        case .listAll:
            return "/v3/venues"
        case .search:
            return "/v3/venues?lat=60.1675&lon=24.9311"
        case .detail(let id):
            return "/v3/restaurants/\(id))"
        }
    }
    
    var queryItems: [URLQueryItem] {
        switch self {
        case .listAll(let location):
            return [
                .init(name: "lat", value: String(location.coordinate.latitude)),
                .init(name: "lon", value: String(location.coordinate.longitude)),
            ]
        case .search(term: let term, location: let location, category: let category):
            return [
                .init(name: "term", value: term),
                .init(name: "lat", value: String(location.coordinate.latitude)),
                .init(name: "lon", value: String(location.coordinate.longitude)),
                .init(name: "categories", value: category?.rawValue ?? FoodCategory.all.rawValue)
            ]
        case .detail:
            return []
        }
    }
    

    var request: URLRequest {
        //url component for Wolt endpoint
        let defaultURL = "https://restaurant-api.wolt.fi/v3/venues?lat=0.0&lon=0.0"
        
        var urlComponents = URLComponents(string: "https://restaurant-api.wolt.fi/")!
        urlComponents.path = path
        urlComponents.queryItems = queryItems
        let url = urlComponents.url != nil ? urlComponents.url : URL(string: defaultURL)
        let request = URLRequest(url: url!)
        return request
    }

}

struct WoltAPiService {
    var request : (Endpoint) -> AnyPublisher<[Restaurant], Never>
}

extension WoltAPiService {
    static let live = WoltAPiService { endpoint in
        return  URLSession.shared.dataTaskPublisher(for: endpoint.request)
            .map(\.data)
            .decode(type: SearchResult.self, decoder: JSONDecoder())
            .map(\.restaurants)
            .replaceError(with: [])
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}


