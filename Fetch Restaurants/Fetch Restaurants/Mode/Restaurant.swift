//
//  Restaurant.swift
//  Fetch Restaurants
//
//  Created by Tewodros Mengesha on 16.11.2021.
//


import Foundation
import MapKit

// MARK: - Restaurant
struct Restaurant : Codable {

        let address : String?
        let city : String?
        let customerSupportPhone : String?
        let descriptionField : [Description]?
        let favourite : Bool?
        let foodTags : [String]?
        let id : Id?
        let itemid : Itemid?
        let listimage : String?
        let listimageBlurhash : String?
        let location : Location?
        let mainimage : String?
        let mainimageBlurhash : String?
        let name : [Name]?
        let online : Bool?
        let phone : String?
        let postCode : String?
        let priceRange : Int?
        let productLine : String?
        let publicUrl : String?
        let rating : Rating?
        let shortDescription : [ShortDescription]?
        let website : String?

        enum CodingKeys: String, CodingKey {
                case address = "address"
                case city = "city"
                case customerSupportPhone = "customer_support_phone"
                case descriptionField = "description"
                case favourite = "favourite"
                case foodTags = "food_tags"
                case id = "id"
                case itemid = "itemid"
                case listimage = "listimage"
                case listimageBlurhash = "listimage_blurhash"
                case location = "location"
                case mainimage = "mainimage"
                case mainimageBlurhash = "mainimage_blurhash"
                case name = "name"
                case online = "online"
                case phone = "phone"
                case postCode = "post_code"
                case priceRange = "price_range"
                case productLine = "product_line"
                case publicUrl = "public_url"
                case rating = "rating"
                case shortDescription = "short_description"
                case website = "website"
        }
    
    init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                address = try values.decodeIfPresent(String.self, forKey: .address)
                city = try values.decodeIfPresent(String.self, forKey: .city)
                customerSupportPhone = try values.decodeIfPresent(String.self, forKey: .customerSupportPhone)
                descriptionField = try values.decodeIfPresent([Description].self, forKey: .descriptionField)
                favourite = try values.decodeIfPresent(Bool.self, forKey: .favourite)
                foodTags = try values.decodeIfPresent([String].self, forKey: .foodTags)
                id = try values.decodeIfPresent(Id.self, forKey: .id)
                itemid = try values.decodeIfPresent(Itemid.self, forKey: .itemid)
                listimage = try values.decodeIfPresent(String.self, forKey: .listimage)
                listimageBlurhash = try values.decodeIfPresent(String.self, forKey: .listimageBlurhash)
                location = try values.decodeIfPresent(Location.self, forKey: .location)
                mainimage = try values.decodeIfPresent(String.self, forKey: .mainimage)
                mainimageBlurhash = try values.decodeIfPresent(String.self, forKey: .mainimageBlurhash)
                name = try values.decodeIfPresent([Name].self, forKey: .name)
                online = try values.decodeIfPresent(Bool.self, forKey: .online)
                phone = try values.decodeIfPresent(String.self, forKey: .phone)
                postCode = try values.decodeIfPresent(String.self, forKey: .postCode)
                priceRange = try values.decodeIfPresent(Int.self, forKey: .priceRange)
                productLine = try values.decodeIfPresent(String.self, forKey: .productLine)
                publicUrl = try values.decodeIfPresent(String.self, forKey: .publicUrl)
                rating = try values.decodeIfPresent(Rating.self, forKey: .rating)
                shortDescription = try values.decodeIfPresent([ShortDescription].self, forKey: .shortDescription)
                website = try values.decodeIfPresent(String.self, forKey: .website)
            }

}

extension Restaurant {
     
    var formattedRestaurantName: String {
        name![0].value ?? "no name"
    }
    
    var isFavourite: Bool {
        favourite!
    }
    
    var formattedDescription: String {
        descriptionField![0].value ?? "no description"
    }
    
    var formattedCategory: String {
        foodTags?.first ?? "none"
    }
    
    var formattedRating: String {
        "\(rating?.rating ?? 0)"
    }
    
    var formattedAddress: String {
        address ?? ""
    }
    
    var formattedCity: String {
        city ?? ""
    }
    
    var formattedPhoneNumber: String {
        phone ?? ""
    }
    
    var formattedImageUrl: URL? {
        if let imageUrl = listimage {
            return URL(string: imageUrl)
        }
        return nil
    }
    
    var formattedImageUrlForCard: URL? {
        if let imageUrl = mainimage {
            return URL(string: imageUrl)
        }
        return nil
    }
    
    var formattedLatitude: Double{
        Double(location?.coordinates![1] ?? 0.0)
    }
    
    var formattedLongitude: Double{
        Double(location?.coordinates![0] ?? 0.0)
    }

    var formattedRegion: MKCoordinateRegion{
        return MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: formattedLatitude, longitude: formattedLongitude), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    }
    
}

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}

// MARK: - Description
struct Description : Codable {

        let lang : String?
        let value : String?

        enum CodingKeys: String, CodingKey {
                case lang = "lang"
                case value = "value"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                lang = try values.decodeIfPresent(String.self, forKey: .lang)
                value = try values.decodeIfPresent(String.self, forKey: .value)
        }
}

// MARK: - ShortDescription
struct ShortDescription : Codable {

        let lang : String?
        let value : String?

        enum CodingKeys: String, CodingKey {
                case lang = "lang"
                case value = "value"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                lang = try values.decodeIfPresent(String.self, forKey: .lang)
                value = try values.decodeIfPresent(String.self, forKey: .value)
        }

}

// MARK: - Id
struct Id : Codable {

        let oid : String?

        enum CodingKeys: String, CodingKey {
                case oid = "$oid"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                oid = try values.decodeIfPresent(String.self, forKey: .oid)
        }

}

// MARK: - Itemid
struct Itemid : Codable {

        let oid : String?

        enum CodingKeys: String, CodingKey {
                case oid = "$oid"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                oid = try values.decodeIfPresent(String.self, forKey: .oid)
        }

}

// MARK: - Location
struct Location : Codable {

        let coordinates : [Float]?
        let type : String?

        enum CodingKeys: String, CodingKey {
                case coordinates = "coordinates"
                case type = "type"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                coordinates = try values.decodeIfPresent([Float].self, forKey: .coordinates)
                type = try values.decodeIfPresent(String.self, forKey: .type)
        }

}

// MARK: - Name
struct Name : Codable {

        let lang : String?
        let value : String?

        enum CodingKeys: String, CodingKey {
                case lang = "lang"
                case value = "value"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                lang = try values.decodeIfPresent(String.self, forKey: .lang)
                value = try values.decodeIfPresent(String.self, forKey: .value)
        }

}

// MARK: - Rating
struct Rating : Codable {

        let negativePercentage : Int?
        let neutralPercentage : Int?
        let positivePercentage : Int?
        let rating : Int?
        let score : Double?
        let text : String?
        let volume : Int?

        enum CodingKeys: String, CodingKey {
                case negativePercentage = "negative_percentage"
                case neutralPercentage = "neutral_percentage"
                case positivePercentage = "positive_percentage"
                case rating = "rating"
                case score = "score"
                case text = "text"
                case volume = "volume"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                negativePercentage = try values.decodeIfPresent(Int.self, forKey: .negativePercentage)
                neutralPercentage = try values.decodeIfPresent(Int.self, forKey: .neutralPercentage)
                positivePercentage = try values.decodeIfPresent(Int.self, forKey: .positivePercentage)
                rating = try values.decodeIfPresent(Int.self, forKey: .rating)
                score = try values.decodeIfPresent(Double.self, forKey: .score)
                text = try values.decodeIfPresent(String.self, forKey: .text)
                volume = try values.decodeIfPresent(Int.self, forKey: .volume)
        }

}

