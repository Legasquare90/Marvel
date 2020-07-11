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
}

class CharacterRouter : BaseRouter {

    private var endpoint: CharacterEndpoint
    
    init(endpoint: CharacterEndpoint) {
        self.endpoint = endpoint
    }
    
    override var method: HTTPMethod {
        switch endpoint {
            case .getAllCharacters, .searchCharacters: return HTTPMethod.get
        }
    }
    
    override var path: String {
        switch endpoint {
            case .getAllCharacters, .searchCharacters: return "/characters"
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
        }
    }
    
    override var encoding: ParameterEncoding {
        switch endpoint {
            default: return URLEncoding.default
        }
    }

}
