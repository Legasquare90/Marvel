//
//  Character.swift
//  Marvel
//
//  Created by Jose Angel Cuadrado Mingo on 06/07/2020.
//

import Foundation

struct CharacterDataWrapper: Codable {
    let code: Int?
    let status: String?
    let copyright: String?
    let attributionText: String?
    let attributionHTML: String?
    let etag: String?
    let data: CharacterDataContainer?
}

struct CharacterDataContainer: Codable {
    let offset: Int?
    let limit: Int?
    let total: Int?
    let count: Int?
    let results: [Character]?
}

struct Character: Codable {
    let characterID: Int?
    let name: String?
    let resultDescription: String?
    let modified: Date?
    let thumbnail: Thumbnail?
    let resourceURI: String?
    let comics: ComicsCollection?
    let series: SeriesCollection?
    let stories: StoriesCollection?
    let events: EventsCollection?
    let urls: [Link]?

    enum CodingKeys: String, CodingKey {
        case characterID = "id"
        case name
        case resultDescription = "description"
        case modified
        case thumbnail
        case resourceURI
        case comics
        case series
        case stories
        case events
        case urls
    }
}
