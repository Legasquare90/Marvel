//
//  Comic.swift
//  Marvel
//
//  Created by Jose Angel Cuadrado Mingo on 08/07/2020.
//

import Foundation

struct ComicDataWrapper: Codable {
    let code: Int?
    let status: String?
    let copyright: String?
    let attributionText: String?
    let attributionHTML: String?
    let etag: String?
    let data: ComicDataContainer?
}

struct ComicDataContainer: Codable {
    let offset: Int?
    let limit: Int?
    let total: Int?
    let count: Int?
    let results: [Comic]?
}

struct ComicsCollection: Codable {
    let available: Int?
    let collectionURI: String?
    let items: [Comic]?
    let returned: Int?
}

struct Comic: Codable {
    let resourceURI: String?
    let name: String?
    let titleDetail: String?
    
    enum CodingKeys: String, CodingKey {
        case resourceURI
        case name
        case titleDetail = "title"
    }
}
