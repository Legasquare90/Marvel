//
//  BaseRouter.swift
//  Marvel
//
//  Created by Jose Angel Cuadrado Mingo on 06/07/2020.
//

import Foundation
import Alamofire

typealias APIParams = [String : AnyObject]?

protocol BaseRouter {
    var method: HTTPMethod { get }
    var encoding: ParameterEncoding { get }
    var path: String { get }
    var parameters: APIParams { get }
    var baseUrl: String { get }
    var headers: [String:String] { get }
}

extension BaseRouter {
    
    var baseUrl: String {
        let baseUrl = URLS.Server
        return baseUrl
    }
    
    var headers: [String : String] {
        fatalError("Override if needed")
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = URL(string: baseUrl)
        guard let urlPath = url?.appendingPathComponent(path) else {
            throw NSError(domain: "", code: 418, userInfo: nil)
        }

        var urlRequest = URLRequest(url: urlPath)
        urlRequest.httpMethod = method.rawValue
        
        let timestamp = Date().timeIntervalSince1970
        let publicKey = APIKeys.Public
        let privateKey = APIKeys.Private
        let hash = md5Hash(str: "\(timestamp)" + privateKey + publicKey)
        
        var params = parameters ?? [:]
        params["ts"] = timestamp as AnyObject
        params["apikey"] = publicKey as AnyObject
        params["hash"] = hash as AnyObject
        
        do {
            return try encoding.encode(urlRequest, with: params)
        } catch {
            return urlRequest
        }
    }
}
