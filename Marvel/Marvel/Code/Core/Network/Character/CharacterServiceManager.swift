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
    
    func getMoreComics(characterID: Int, nextPage: Int, completion:@escaping (_ comicContainter: ComicDataContainer?, _ error: Error?) -> Void) {
        let router = CharacterRouter(endpoint: .getMoreComics(characterID: characterID, nextPage: nextPage))
        
        networkManager.executeRequest(request: router) { (response: ComicDataWrapper?, error: Error?) in
            completion(response?.data, error)
        }
    }
    
    func getMoreStories(characterID: Int, nextPage: Int, completion:@escaping (_ storyContainter: StoryDataContainer?, _ error: Error?) -> Void) {
        let router = CharacterRouter(endpoint: .getMoreStories(characterID: characterID, nextPage: nextPage))
        
        networkManager.executeRequest(request: router) { (response: StoryDataWrapper?, error: Error?) in
            completion(response?.data, error)
        }
    }
    
    func getMoreEvents(characterID: Int, nextPage: Int, completion:@escaping (_ eventContainter: EventDataContainer?, _ error: Error?) -> Void) {
        let router = CharacterRouter(endpoint: .getMoreEvents(characterID: characterID, nextPage: nextPage))
        
        networkManager.executeRequest(request: router) { (response: EventDataWrapper?, error: Error?) in
            completion(response?.data, error)
        }
    }
    
    func getMoreSeries(characterID: Int, nextPage: Int, completion:@escaping (_ serieContainter: SerieDataContainer?, _ error: Error?) -> Void) {
        let router = CharacterRouter(endpoint: .getMoreSeries(characterID: characterID, nextPage: nextPage))
        
        networkManager.executeRequest(request: router) { (response: SerieDataWrapper?, error: Error?) in
            completion(response?.data, error)
        }
    }

}
