//
//  CharacterRouter.swift
//  Marvel
//
//  Created by Jose Angel Cuadrado Mingo on 08/07/2020.
//

import Foundation
import Alamofire

enum CharacterEndpoint {
    case getAllCharacters(nextPage: Int)
    case searchCharacters(search: String)
    case getMoreComics(characterID: Int, nextPage: Int)
    case getMoreStories(characterID: Int, nextPage: Int)
    case getMoreEvents(characterID: Int, nextPage: Int)
    case getMoreSeries(characterID: Int, nextPage: Int)
}

class CharacterRouter : BaseRouter {

    private var endpoint: CharacterEndpoint
    
    init(endpoint: CharacterEndpoint) {
        self.endpoint = endpoint
    }
    
    override var method: HTTPMethod {
        switch endpoint {
            case .getAllCharacters, .searchCharacters, .getMoreComics, .getMoreStories, .getMoreEvents, .getMoreSeries: return HTTPMethod.get
        }
    }
    
    override var path: String {
        switch endpoint {
            case .getAllCharacters, .searchCharacters: return "/characters"
            case .getMoreComics(let characterID, _): return "/characters/\(characterID)/comics"
            case .getMoreStories(let characterID, _): return "/characters/\(characterID)/stories"
            case .getMoreEvents(let characterID, _): return "/characters/\(characterID)/events"
            case .getMoreSeries(let characterID, _): return "/characters/\(characterID)/series"
        }
    }

    override var parameters: APIParams {
        switch endpoint {
            case .getAllCharacters(let nextPage):
                var dict: [String : AnyObject] = [:]
                dict.updateValue(Constants.contentsPerRequest as AnyObject, forKey: "limit")
                let offset = nextPage * Constants.contentsPerRequest
                dict.updateValue(offset as AnyObject, forKey: "offset")
                return dict
            case .searchCharacters(let search):
                var dict: [String : AnyObject] = [:]
                dict.updateValue(Constants.contentsPerRequest as AnyObject, forKey: "limit")
                dict.updateValue(search as AnyObject, forKey: "nameStartsWith")
                return dict
            case .getMoreComics(_, let nextPage):
                var dict: [String : AnyObject] = [:]
                let offset = nextPage * Constants.contentsInCollectionsPerRequest
                dict.updateValue(offset as AnyObject, forKey: "offset")
                return dict
            case .getMoreStories(_, let nextPage):
                var dict: [String : AnyObject] = [:]
                let offset = nextPage * Constants.contentsInCollectionsPerRequest
                dict.updateValue(offset as AnyObject, forKey: "offset")
                return dict
            case .getMoreEvents(_, let nextPage):
                var dict: [String : AnyObject] = [:]
                let offset = nextPage * Constants.contentsInCollectionsPerRequest
                dict.updateValue(offset as AnyObject, forKey: "offset")
                return dict
            case .getMoreSeries(_, let nextPage):
                var dict: [String : AnyObject] = [:]
                let offset = nextPage * Constants.contentsInCollectionsPerRequest
                dict.updateValue(offset as AnyObject, forKey: "offset")
                return dict
        }
    }
    
    override var encoding: ParameterEncoding {
        switch endpoint {
            default: return URLEncoding.default
        }
    }

}
