//
//  Reusables.swift
//  AlkemyMeliApp
//
//  Created by Jacobo Ezequiel Corvalan on 21/09/2022.
//

import Foundation
import Alamofire

struct Knetworking {
    
   static let token: HTTPHeaders = [.authorization(bearerToken:
            "APP_USR-7403433960309127-092208-51fdb85f75074b1309d788df9b1fdbe0-273848914")]
    
    static let categoryUrl = "https://api.mercadolibre.com/sites/MLA/domain_discovery/search?limit=1&q="
    static let topTwentyUrl = "https://api.mercadolibre.com/highlights/MLA/category/"
    static let detailsProductsUrl = "https://api.mercadolibre.com/items?ids="
    
}
