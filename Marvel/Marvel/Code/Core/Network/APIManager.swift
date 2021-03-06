//
//  APIManager.swift
//  Marvel
//
//  Created by Jose Angel Cuadrado Mingo on 06/07/2020.
//

import Foundation
import Alamofire

protocol APIManager {
    func executeRequest<T>(request: URLRequestConvertible, completion: @escaping (T?, Error?) -> Void) where T: Codable
}

class AlamofireManager: APIManager {
    
    private let session: Alamofire.Session
    private let logger = Logger()
    private var retry = 0
    
    init(session: Alamofire.Session = .default) {
        self.session = session
    }
    
    func executeRequest<T>(request: URLRequestConvertible, completion: @escaping (T?, Error?) -> Void) where T: Codable {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(formatter)
        let _ = session.request(request).validate(statusCode: 200..<300).responseDecodable(of: T.self, decoder: decoder)  { response in
            self.logger.logService(request: request.urlRequest, statusCode: response.response?.statusCode, data: response.data, error: response.error)
            do {
                try completion(response.result.get(), nil)
                self.retry = 0
            } catch let error {
                if response.response?.statusCode == 401 && self.retry < 5 {
                    self.retry += 1
                    self.executeRequest(request: request, completion: completion)
                } else {
                    completion(nil, error)
                    self.retry = 0
                }
            }
        }
    }

}
