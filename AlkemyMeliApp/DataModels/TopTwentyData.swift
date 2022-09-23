//
//  TopTwenty.swift
//  AlkemyMeliApp
//
//  Created by Jacobo Ezequiel Corvalan on 17/09/2022.
//

import Foundation

// MARK: - TopTwenty
struct TopTwenty: Codable {
    let queryData: QueryData
    let content: [Content]

    enum CodingKeys: String, CodingKey {
        case queryData = "query_data"
        case content
    }
}

// MARK: - Content
struct Content: Codable {
    let id: String
    let position: Int
    let type: TypeEnum
}

enum TypeEnum: String, Codable {
    case item = "ITEM"
}

// MARK: - QueryData
struct QueryData: Codable {
    let highlightType, criteria, id: String

    enum CodingKeys: String, CodingKey {
        case highlightType = "highlight_type"
        case criteria, id
    }
}
