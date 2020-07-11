//
//  CharactersListInteractorMock.swift
//  MarvelTests
//
//  Created by Jose Angel Cuadrado Mingo on 11/07/2020.
//

import Foundation
@testable import Marvel

class CharactersListInteractorMock: CharactersListInteractorInput {
    var characters: [Character] = []
    var charactersWithExtraSearch: [Character] = []
    var nextPage: Int = 0
    
    func getCharacters() {
        let multipleWrapper = DecoderFile().decodeFile(name: "MultipleResults", extensionFile: "json")
        characters += multipleWrapper?.data?.results ?? []
        charactersWithExtraSearch += multipleWrapper?.data?.results ?? []
        nextPage += 1
    }
    
    func searchCharacters(search: String) {
        let ironWrapper = DecoderFile().decodeFile(name: "IronSearch", extensionFile: "json")
        charactersWithExtraSearch += ironWrapper?.data?.results ?? []
    }
    
}
