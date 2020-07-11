//
//  Story.swift
//  Marvel
//
//  Created by Jose Angel Cuadrado Mingo on 08/07/2020.
//

import Foundation

struct StoriesCollection: Codable {
    let available: Int?
    let collectionURI: String?
    let items: [Story]?
    let returned: Int?
}

struct Story: Codable {
    let resourceURI: String?
    let name: String?
    let type: String?
}
