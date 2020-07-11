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

    func getCharacters(nextPage: Int, completion:@escaping (_ characters: CharacterDataContainer?, _ error: String?) -> Void) {
        let router = CharacterRouter(endpoint: .getAllCharacters(nextPage: nextPage))

        networkManager.executeRequest(request: router) { (response: CharacterDataWrapper?, error: Error?) in
            completion(response?.data, error?.localizedDescription)
        }
    }

}
