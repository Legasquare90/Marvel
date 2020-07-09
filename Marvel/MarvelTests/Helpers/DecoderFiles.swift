//
//  DecoderFiles.swift
//  MarvelTests
//
//  Created by Jose Angel Cuadrado Mingo on 09/07/2020.
//

import Foundation
@testable import Marvel

class DecoderFile {
    
    func decodeFile(name: String, extensionFile: String) -> CharacterDataWrapper? {
        if let filepath = Bundle(for: type(of: self)).path(forResource: name, ofType: extensionFile) {
            do {
                let contents = try String(contentsOfFile: filepath)
                let data = contents.data(using: .utf8)!
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .formatted(formatter)
                return try decoder.decode(CharacterDataWrapper.self, from: data)
            } catch let error {
                print(error.localizedDescription)
            }
        }
        return nil
    }

}
