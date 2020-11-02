//
//  CharactersListRouter.swift
//  Marvel
//
//  Created by Jose Angel Cuadrado Mingo on 08/07/2020.
//

import Foundation
import Alamofire

struct CharactersListRouter: BaseRouter, URLRequestConvertible {
    
    var nextPage: Int = 0
    
    var method: HTTPMethod {
        return HTTPMethod.get
    }
    
    var path: String {
        return "/characters"
    }
    
    var parameters: APIParams {
        var dict: [String : AnyObject] = [:]
        dict.updateValue(Constants.contentsPerRequest as AnyObject, forKey: "limit")
        let offset = nextPage * Constants.contentsPerRequest
        dict.updateValue(offset as AnyObject, forKey: "offset")
        return dict
    }
    
    var encoding: ParameterEncoding {
        return URLEncoding.default
    }
    
}
