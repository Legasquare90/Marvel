//
//  Story.swift
//  Marvel
//
//  Created by Jose Angel Cuadrado Mingo on 08/07/2020.
//

import Foundation

enum ItemType: String, Codable {
    case cover = "cover"
    case empty = ""
    case interiorStory = "interiorStory"
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
    let type: ItemType?
}
