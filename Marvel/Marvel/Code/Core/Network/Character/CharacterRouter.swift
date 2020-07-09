//
//  CharacterRouter.swift
//  Marvel
//
//  Created by Jose Angel Cuadrado Mingo on 08/07/2020.
//

import Foundation
import Alamofire

enum CharacterEndpoint {
    case getAllCharacters
}

class CharacterRouter : BaseRouter {

    private var endpoint: CharacterEndpoint
    
    init(endpoint: CharacterEndpoint) {
        self.endpoint = endpoint
    }
    
    override var method: HTTPMethod {
        switch endpoint {
            case .getAllCharacters: return HTTPMethod.get
        }
    }
    
    override var path: String {
        switch endpoint {
            case .getAllCharacters: return "/characters"
        }
    }

    override var parameters: APIParams {
        switch endpoint {
            default: return nil
        }
    }
    
    override var encoding: ParameterEncoding {
        switch endpoint {
            default: return URLEncoding.default
        }
    }

}
