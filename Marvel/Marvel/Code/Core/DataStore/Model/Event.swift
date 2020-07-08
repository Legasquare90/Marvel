//
//  Event.swift
//  Marvel
//
//  Created by Jose Angel Cuadrado Mingo on 08/07/2020.
//

import Foundation

struct EventsCollection: Codable {
    let available: Int?
    let collectionURI: String?
    let items: [Event]?
    let returned: Int?
}

struct Event: Codable {
    let resourceURI: String?
    let name: String?
}
