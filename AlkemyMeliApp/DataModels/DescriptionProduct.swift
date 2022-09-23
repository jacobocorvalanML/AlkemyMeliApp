//
//  DetailProductItem.swift
//  AlkemyMeliApp
//
//  Created by Jacobo Ezequiel Corvalan on 18/09/2022.
//


import Foundation

// MARK: - Nuevo
struct DescriptionProduct: Codable {
    let text, plainText, lastUpdated, dateCreated: String
    let snapshot: Snapshot

    enum CodingKeys: String, CodingKey {
        case text
        case plainText = "plain_text"
        case lastUpdated = "last_updated"
        case dateCreated = "date_created"
        case snapshot
    }
}

// MARK: - Snapshot
struct Snapshot: Codable {
}
