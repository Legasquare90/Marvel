//
//  CharacterServiceManagerTests.swift
//  MarvelTests
//
//  Created by Jose Angel Cuadrado Mingo on 09/07/2020.
//

import XCTest
import Nimble
@testable import Marvel

class CharacterServiceManagerTests: XCTestCase {
    
    let kMockErrorMessage = "Mock error"
    
    enum MyError: LocalizedError {
        case error(message: String)

        var errorDescription: String? {
            switch self {
            case let .error(message):
                return message
            }
        }
    }

    override func setUpWithError() throws { }

    override func tearDownWithError() throws { }

    func testSuccessfulOneCharacterResult() throws {
        // Given
        let nextPage = 0
        let hulkWrapper = DecoderFile().decodeFile(name: "Hulk", extensionFile: "json")
        let mock: APIManager = NetworkManagerMock(response: hulkWrapper, error: nil)
        let characterServiceManager = CharacterServiceManager(networkManager: mock)
        
        // When
        var result: [Character]?
        var errorMessage: String?
        characterServiceManager.getCharacters(nextPage: nextPage) { (characterContainer, error) in
            if let container = characterContainer {
                result = container.results
            }
            if let e = error {
                errorMessage = e.localizedDescription
            }
        }
        
        // Then
        expect(result).notTo(beNil())
        expect(errorMessage).to(beNil())
        
        expect(result?.count) == 1
        expect(result?.first?.name) == "Hulk"
        expect(result?.first?.modified).notTo(beNil())
    }
    
    func testSuccessfulNoResult() throws {
        // Given
        let nextPage = 0
        let noResultsWrapper = DecoderFile().decodeFile(name: "NoResults", extensionFile: "json")
        let mock: APIManager = NetworkManagerMock(response: noResultsWrapper, error: nil)
        let characterServiceManager = CharacterServiceManager(networkManager: mock)
        
        // When
        var result: [Character]?
        var errorMessage: String?
        characterServiceManager.getCharacters(nextPage: nextPage) { (characterContainer, error) in
            if let container = characterContainer {
                result = container.results
            }
            if let e = error {
                errorMessage = e.localizedDescription
            }
        }
        
        // Then
        expect(result).notTo(beNil())
        expect(errorMessage).to(beNil())

        expect(result?.count) == 0
    }
    
    func testSuccessfulMultipleResult() throws {
        // Given
        let nextPage = 0
        let multipleWrapper = DecoderFile().decodeFile(name: "MultipleResults", extensionFile: "json")
        let mock: APIManager = NetworkManagerMock(response: multipleWrapper, error: nil)
        let characterServiceManager = CharacterServiceManager(networkManager: mock)
        
        // When
        var result: [Character]?
        var errorMessage: String?
        characterServiceManager.getCharacters(nextPage: nextPage) { (characterContainer, error) in
            if let container = characterContainer {
                result = container.results
            }
            if let e = error {
                errorMessage = e.localizedDescription
            }
        }
        
        // Then
        expect(result).notTo(beNil())
        expect(errorMessage).to(beNil())

        expect(result?.count) == 20
        expect(result?[0].name) == "3-D Man"
        expect(result?[0].modified).notTo(beNil())
        expect(result?[19].name) == "Ajaxis"
        expect(result?[19].modified).notTo(beNil())
    }

    func testErrorResult() throws {
        let nextPage = 0
        let error = MyError.error(message: kMockErrorMessage)
        let mock: APIManager = NetworkManagerMock(response: nil, error: error)
        let characterServiceManager = CharacterServiceManager(networkManager: mock)
        
        // When
        var result: [Character]?
        var errorMessage: String?
        characterServiceManager.getCharacters(nextPage: nextPage) { (characterContainer, error) in
            if let container = characterContainer {
                result = container.results
            }
            if let e = error {
                errorMessage = e.localizedDescription
            }
        }
        
        // Then
        expect(result).to(beNil())
        expect(errorMessage).notTo(beNil())
        
        expect(errorMessage) == kMockErrorMessage
    }

}
