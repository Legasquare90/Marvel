//
//  Constants.swift
//  Marvel
//
//  Created by Jose Angel Cuadrado Mingo on 06/07/2020.
//

import Foundation

/**
 URLs of Marvel API
 */
struct URLS {
    /**
     Principal URL of Public Marvel API to use it as base in server requests
     */
    static let Server = "https://gateway.marvel.com:443/v1/public"
}

/**
 Keys of Marvel API
 */
struct APIKeys {
    /**
     Public key to add in server requests
     */
    static let Public = "a09ea31d9b7c1deb2b1871cca11eb442"
    
    /**
     Private key to add in MD5 hash
     
     - Important:
     The private key must not be written explicitly in the code. Instead, the team can save the private key in a file and don't push it to the repository, but share it internally with another security process.
     */
    static let Private = "ae4ccc55f294697f67ff4e5126d2f7311cabc467"
}

/**
 General constants
 */
struct Constants {
    /**
     Limit each request to Marvel API to return this number of contents
     */
    static let contentsPerRequest = 30
    
    /**
     Limit each request to Marvel API to return this number of contents in character collections
     */
    static let contentsInCollectionsPerRequest = 20

}
