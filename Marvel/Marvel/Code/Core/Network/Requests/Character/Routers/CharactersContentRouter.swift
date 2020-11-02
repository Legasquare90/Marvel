//
//  CharactersContentRouter.swift
//  Marvel
//
//  Created by Jose Angel Cuadrado on 02/11/2020.
//

import Foundation
import Alamofire

enum CharacterContentType: String {
    case Comics = "comics"
    case Events = "events"
    case Series = "series"
    case Stories = "stories"
}

struct CharactersContentRouter: BaseRouter, URLRequestConvertible {
    
    var characterID: Int = 0
    var nextPage: Int = 0
    var contentType: CharacterContentType?

    var method: HTTPMethod {
        return HTTPMethod.get
    }
    
    var path: String {
        guard let contentType = contentType else {
            fatalError("Content type is needed")
        }
        
        return "/characters/\(characterID)/" + contentType.rawValue
    }
    
    var parameters: APIParams {
        var dict: [String : AnyObject] = [:]
        let offset = nextPage * Constants.contentsInCollectionsPerRequest
        dict.updateValue(offset as AnyObject, forKey: "offset")
        return dict
    }
    
    var encoding: ParameterEncoding {
        return URLEncoding.default
    }
    
}
