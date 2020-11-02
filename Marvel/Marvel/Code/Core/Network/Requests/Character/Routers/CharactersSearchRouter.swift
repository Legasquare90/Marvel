//
//  CharactersSearchRouter.swift
//  Marvel
//
//  Created by Jose Angel Cuadrado on 02/11/2020.
//

import Foundation
import Alamofire

struct CharactersSearchRouter: BaseRouter, URLRequestConvertible {
    
    var searchText: String = ""
    
    var method: HTTPMethod {
        return HTTPMethod.get
    }
    
    var path: String {
        return "/characters"
    }
    
    var parameters: APIParams {
        var dict: [String : AnyObject] = [:]
        dict.updateValue(Constants.contentsPerRequest as AnyObject, forKey: "limit")
        dict.updateValue(searchText as AnyObject, forKey: "nameStartsWith")
        return dict
    }
    
    var encoding: ParameterEncoding {
        return URLEncoding.default
    }
    
}
