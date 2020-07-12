//
//  Event.swift
//  Marvel
//
//  Created by Jose Angel Cuadrado Mingo on 08/07/2020.
//

import Foundation

struct EventDataWrapper: Codable {
    let code: Int?
    let status: String?
    let copyright: String?
    let attributionText: String?
    let attributionHTML: String?
    let etag: String?
    let data: EventDataContainer?
}

struct EventDataContainer: Codable {
    let offset: Int?
    let limit: Int?
    let total: Int?
    let count: Int?
    let results: [Event]?
}

struct EventsCollection: Codable {
    let available: Int?
    let collectionURI: String?
    let items: [Event]?
    let returned: Int?
}

struct Event: Codable {
    let resourceURI: String?
    let name: String?
    let titleDetail: String?
    
    enum CodingKeys: String, CodingKey {
        case resourceURI
        case name
        case titleDetail = "title"
    }
}
