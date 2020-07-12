//
//  Story.swift
//  Marvel
//
//  Created by Jose Angel Cuadrado Mingo on 08/07/2020.
//

import Foundation

struct StoryDataWrapper: Codable {
    let code: Int?
    let status: String?
    let copyright: String?
    let attributionText: String?
    let attributionHTML: String?
    let etag: String?
    let data: StoryDataContainer?
}

struct StoryDataContainer: Codable {
    let offset: Int?
    let limit: Int?
    let total: Int?
    let count: Int?
    let results: [Story]?
}

struct StoriesCollection: Codable {
    let available: Int?
    let collectionURI: String?
    let items: [Story]?
    let returned: Int?
}

struct Story: Codable {
    let resourceURI: String?
    let name: String?
    let titleDetail: String?
    
    enum CodingKeys: String, CodingKey {
        case resourceURI
        case name
        case titleDetail = "title"
    }
}
