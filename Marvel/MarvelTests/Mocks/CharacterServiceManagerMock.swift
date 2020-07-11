//
//  CharacterServiceManagerMock.swift
//  MarvelTests
//
//  Created by Jose Angel Cuadrado Mingo on 11/07/2020.
//

import Foundation
@testable import Marvel

class CharacterServiceManagerMock: CharacterServiceManager {
    
    override func getCharacters(nextPage: Int, completion:@escaping (_ characters: CharacterDataContainer?, _ error: Error?) -> Void) {
        let multipleWrapper = DecoderFile().decodeFile(name: "MultipleResults", extensionFile: "json")
        completion(multipleWrapper?.data, nil)
    }
    
    override func searchCharacters(search: String, completion:@escaping (_ characters: [Character]?, _ error: Error?) -> Void) {
        let ironWrapper = DecoderFile().decodeFile(name: "IronSearch", extensionFile: "json")
        completion(ironWrapper?.data?.results, nil)
    }
}
