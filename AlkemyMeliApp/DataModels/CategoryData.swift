//
//  ManagerAPI.swift
//  AlkemyMeliApp
//
//  Created by Jacobo Ezequiel Corvalan on 14/09/2022.
//

import Foundation

// MARK: - PreCategoryElement
struct PreCategoryElement: Codable {
    let domainID, domainName, categoryID, categoryName: String
    let attributes: [Attribute]

    enum CodingKeys: String, CodingKey {
        case domainID = "domain_id"
        case domainName = "domain_name"
        case categoryID = "category_id"
        case categoryName = "category_name"
        case attributes
    }
}

// MARK: - Attribute
struct Attribute: Codable {
    let id, name, valueID, valueName: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case valueID = "value_id"
        case valueName = "value_name"
    }
}

typealias PreCategory = [PreCategoryElement]

