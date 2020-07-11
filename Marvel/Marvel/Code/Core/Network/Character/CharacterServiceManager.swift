//
//  CharacterServiceManager.swift
//  Marvel
//
//  Created by Jose Angel Cuadrado Mingo on 08/07/2020.
//

import Foundation

class CharacterServiceManager {

    private let networkManager: APIManager
    
    init(networkManager: APIManager = AlamofireManager()) {
        self.networkManager = networkManager
    }

    func getCharacters(nextPage: Int, completion:@escaping (_ characters: CharacterDataContainer?, _ error: Error?) -> Void) {
        let router = CharacterRouter(endpoint: .getAllCharacters(nextPage: nextPage))

        networkManager.executeRequest(request: router) { (response: CharacterDataWrapper?, error: Error?) in
            completion(response?.data, error)
        }
    }
    
    func searchCharacters(search: String, completion:@escaping (_ characters: [Character]?, _ error: Error?) -> Void) {
        let router = CharacterRouter(endpoint: .searchCharacters(search: search))

        networkManager.executeRequest(request: router) { (response: CharacterDataWrapper?, error: Error?) in
            completion(response?.data?.results, error)
        }

    }

}
