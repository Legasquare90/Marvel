//
//  AFSessionMock.swift
//  MarvelTests
//
//  Created by Jose Angel Cuadrado Mingo on 09/07/2020.
//

import Foundation
import Alamofire
@testable import Marvel

class NetworkManagerMock: APIManager {
    
    private let response: Codable?
    private let error: Error?
    
    init(response: Codable?, error: Error?) {
        self.response = response
        self.error = error
    }
    
    func executeRequest<T>(request: URLRequestConvertible, completion: @escaping (T?, Error?) -> Void) where T: Codable {
        completion(self.response as? T, self.error)
    }
}
