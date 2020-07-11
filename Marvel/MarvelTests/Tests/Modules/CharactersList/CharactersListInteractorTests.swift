//
//  CharactersListInteractorTests.swift
//  MarvelTests
//
//  Created by Jose Angel Cuadrado Mingo on 11/07/2020.
//

import XCTest
import Nimble
@testable import Marvel

class CharactersListInteractorTests: XCTestCase {

    var serviceManagerMock: CharacterServiceManagerMock?
    var interactor: CharactersListInteractor?

    override func setUpWithError() throws {
        serviceManagerMock = CharacterServiceManagerMock()
        interactor = CharactersListInteractor(presenter: nil, characterServiceManager: serviceManagerMock)
    }

    override func tearDownWithError() throws {
        interactor = nil
    }

    func testGetCharacters() throws {
        // Given
        
        // When
        interactor?.getCharacters()
        
        // Then
        expect(self.interactor?.nextPage) == 1
        expect(self.interactor?.characters.count) > 0
        expect(self.interactor?.charactersWithExtraSearch.count) > 0
    }
    
    func testSearchCharacters() throws {
        // Given
        let search = "iron"
        
        // When
        interactor?.getCharacters()
        interactor?.searchCharacters(search: search)
        
        // Then
        expect(self.interactor?.nextPage) == 1
        expect(self.interactor?.characters.count) > 0
        expect(self.interactor?.charactersWithExtraSearch.count) > 0
        expect(self.interactor?.charactersWithExtraSearch.count) > self.interactor?.characters.count ?? 0
    }

    func testAddExtraCharacters() throws {
        // Given
        let multipleWrapper = DecoderFile().decodeFile(name: "MultipleResults", extensionFile: "json")
        let ironWrapper = DecoderFile().decodeFile(name: "IronSearch", extensionFile: "json")
        let characters = multipleWrapper?.data?.results ?? []
        let charactersReceived = ironWrapper?.data?.results ?? []
        interactor?.characters = characters
        interactor?.charactersWithExtraSearch = characters
        
        // When
        interactor?.addNewCharacters(charactersReceived: charactersReceived)
        
        // Then
        expect(self.interactor?.charactersWithExtraSearch.count) > self.interactor?.characters.count ?? 0
        expect(self.interactor?.charactersWithExtraSearch.count) == characters.count + charactersReceived.count
    }
    
    func testExtraCharactersRepeated() throws {
        // Given
        let multipleWrapper = DecoderFile().decodeFile(name: "MultipleResults", extensionFile: "json")
        let characters = multipleWrapper?.data?.results ?? []
        interactor?.characters = characters
        interactor?.charactersWithExtraSearch = characters
        
        // When
        interactor?.addNewCharacters(charactersReceived: characters)
        
        // Then
        expect(self.interactor?.charactersWithExtraSearch.count) == self.interactor?.characters.count ?? 0
    }
}
