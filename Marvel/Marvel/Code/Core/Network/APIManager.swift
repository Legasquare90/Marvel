//
//  APIManager.swift
//  Marvel
//
//  Created by Jose Angel Cuadrado Mingo on 06/07/2020.
//

import Foundation
import Alamofire

class APIManager {
    
    private let session: Alamofire.Session
    
    init(session: Alamofire.Session = .default) {
        self.session = session
    }
    
    func executeRequest<T>(request: URLRequestConvertible, completion: @escaping (AFDataResponse<T>) -> Void) where T: Codable {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(formatter)
        let _ = session.request(request).validate(statusCode: 200..<300).responseDecodable(of: T.self, decoder: decoder)  { response in
            completion(response)
        }
    }

}
