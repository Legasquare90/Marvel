//
//  Comic.swift
//  Marvel
//
//  Created by Jose Angel Cuadrado Mingo on 08/07/2020.
//

import Foundation

struct ComicsCollection: Codable {
    let available: Int?
    let collectionURI: String?
    let items: [Comic]?
    let returned: Int?
}

struct Comic: Codable {
    let resourceURI: String?
    let name: String?
}
