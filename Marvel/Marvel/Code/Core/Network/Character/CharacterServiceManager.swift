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

    func getCharacters(completion:@escaping (_ characters: [Character]?, _ error: String?) -> Void) {
        let router = CharacterRouter(endpoint: .getAllCharacters)

        networkManager.executeRequest(request: router) { (response: CharacterDataWrapper?, error: Error?) in
            completion(response?.data?.results, error?.localizedDescription)
        }
    }

}
