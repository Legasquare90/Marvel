//
//  Character.swift
//  Marvel
//
//  Created by Jose Angel Cuadrado Mingo on 06/07/2020.
//

import Foundation

struct CharacterDataWrapper: Codable {

    let data: CharacterDataContainer?

    enum CodingKeys: String, CodingKey {
        case data
    }

}

struct CharacterDataContainer: Codable {
    
    let offset: Int?
    let limit: Int?
    let total: Int?
    let count: Int?
    let results: Character?
    
    enum CodingKeys: String, CodingKey {
        case offset
        case limit
        case total
        case count
        case results
    }

}

struct Character: Codable {
    
    let characterID: Int?
    let name: String?
    let description: String?
    let modified: Date?
    let resourceURI: String?
    
    enum CodingKeys: String, CodingKey {
        case characterID = "id"
        case name
        case description
        case modified
        case resourceURI
    }

}
