
import Foundation
import SwiftUI

typealias Multiget = [MultigetElement]

struct MultigetElement: Codable {
    let code: Int
    let body: Body
}

// MARK: - Body
struct Body: Codable {
    let id: String
//    let siteId: String
    let title: String
//   let subtitle: String?
//    let sellerId: Int
//    let categoryId: String
    let price: Double
//    let condition: String
//    let currencyId: String
//    let initialQuantity: Int
//    let availableQuantity: Int
//    let soldQuantity: Int
//    let secureThumbnail: String
    let thumbnail: String
    let secure_thumbnail: String
    let pictures: [Picture]
//    let acceptsMercadopago: Bool
//    let internationalDeliveryMode: String
//    let listingSource: String
//    let status: String
    
    let seller_address: Seller_Address
    
}

struct Seller_Address: Codable{
    let city: City
    let state: State
    let country: Country
}

struct City: Codable{
    let name: String
}

struct State: Codable{
    let name: String
}

struct Country: Codable{
    let name: String
}


struct Picture: Codable {
    let id: String
    let url: String
    let secureURL: String
    let size, maxSize, quality: String
    
    enum CodingKeys: String, CodingKey {
        case id, url
        case secureURL = "secure_url"
        case size
        case maxSize = "max_size"
        case quality
    }
}


