//
//  CharactersRouterFactory.swift
//  Marvel
//
//  Created by Jose Angel Cuadrado on 02/11/2020.
//

import Foundation
import Alamofire

class CharactersRouterFactory {
    
    class func getCharacters(nextPage: Int) -> URLRequestConvertible {
        return CharactersListRouter(nextPage: nextPage)
    }
    
    class func searchCharacter(search: String) -> URLRequestConvertible {
        return CharactersSearchRouter(searchText: search)
    }
    
    class func getCharacterContent(characterID: Int, nextPage: Int, contentType: CharacterContentType) -> URLRequestConvertible {
        return CharactersContentRouter(characterID: characterID, nextPage: nextPage, contentType: contentType)
    }
    
}
