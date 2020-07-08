//
//  Serie.swift
//  Marvel
//
//  Created by Jose Angel Cuadrado Mingo on 08/07/2020.
//

import Foundation

struct SeriesCollection: Codable {
    let available: Int?
    let collectionURI: String?
    let items: [Serie]?
    let returned: Int?
}

struct Serie: Codable {
    let resourceURI: String?
    let name: String?
}
