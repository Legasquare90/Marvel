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
    
    func testSuccessfulNoCharacters() throws {
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
    
    func testSuccessfulGetMultipleCharacters() throws {
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

    func testErrorGettingCharacters() throws {
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
    
    func testSuccessfulSearchCharacter() throws {
        // Given
        let search = "j. jonah"
        let jjjWrapper = DecoderFile().decodeFile(name: "JJJ", extensionFile: "json")
        let mock: APIManager = NetworkManagerMock(response: jjjWrapper, error: nil)
        let characterServiceManager = CharacterServiceManager(networkManager: mock)
        
        // When
        var result: [Character]?
        var errorMessage: String?
        characterServiceManager.searchCharacters(search: search, completion: { (characters, error) in
            if let characters = characters {
                result = characters
            }
            if let e = error {
                errorMessage = e.localizedDescription
            }
        })
        
        // Then
        expect(result).notTo(beNil())
        expect(errorMessage).to(beNil())
        
        expect(result?.count) == 1
        expect(result?.first?.name?.lowercased()).to(contain(search))
    }
    
    func testSuccessfulSearchSeveralCharacters() throws {
        // Given
        let search = "iron"
        let ironWrapper = DecoderFile().decodeFile(name: "IronSearch", extensionFile: "json")
        let mock: APIManager = NetworkManagerMock(response: ironWrapper, error: nil)
        let characterServiceManager = CharacterServiceManager(networkManager: mock)
        
        // When
        var result: [Character]?
        var errorMessage: String?
        characterServiceManager.searchCharacters(search: search, completion: { (characters, error) in
            if let characters = characters {
                result = characters
            }
            if let e = error {
                errorMessage = e.localizedDescription
            }
        })
        
        // Then
        expect(result).notTo(beNil())
        expect(errorMessage).to(beNil())
        
        expect(result?.count) > 0
        for character in (result ?? []) {
            expect(character.name?.lowercased()).to(contain(search))
        }
    }
    
    func testErrorSearchingCharacters() throws {
        let search = "hulk"
        let error = MyError.error(message: kMockErrorMessage)
        let mock: APIManager = NetworkManagerMock(response: nil, error: error)
        let characterServiceManager = CharacterServiceManager(networkManager: mock)
        
        // When
        var result: [Character]?
        var errorMessage: String?
        characterServiceManager.searchCharacters(search: search, completion: { (characters, error) in
            if let characters = characters {
                result = characters
            }
            if let e = error {
                errorMessage = e.localizedDescription
            }
        })
        
        // Then
        expect(result).to(beNil())
        expect(errorMessage).notTo(beNil())
        
        expect(errorMessage) == kMockErrorMessage
    }
    
    func testSuccessfulPaginationComics() throws {
        // Given
        let nextPage = 0
        let characterID = 1009351
        let comicsWrapper = DecoderFile().decodeComicFile(name: "Comics", extensionFile: "json")
        let mock: APIManager = NetworkManagerMock(response: comicsWrapper, error: nil)
        let characterServiceManager = CharacterServiceManager(networkManager: mock)
        
        // When
        var result: [Comic]?
        var errorMessage: String?
        characterServiceManager.getMoreComics(characterID: characterID, nextPage: nextPage) { (comicContainer, error) in
            if let container = comicContainer {
                result = container.results
            }
            if let e = error {
                errorMessage = e.localizedDescription
            }
        }
        
        // Then
        expect(result).notTo(beNil())
        expect(errorMessage).to(beNil())
        expect(result?.count) > 0
    }
    
    func testErrorPaginationComics() throws {
        // Given
        let nextPage = 0
        let characterID = 1009351
        let error = MyError.error(message: kMockErrorMessage)
        let mock: APIManager = NetworkManagerMock(response: nil, error: error)
        let characterServiceManager = CharacterServiceManager(networkManager: mock)
        
        // When
        var result: [Comic]?
        var errorMessage: String?
        characterServiceManager.getMoreComics(characterID: characterID, nextPage: nextPage) { (comicContainer, error) in
            if let container = comicContainer {
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
    
    func testSuccessfulPaginationEvents() throws {
        // Given
        let nextPage = 0
        let characterID = 1009351
        let eventsWrapper = DecoderFile().decodeEventFile(name: "Events", extensionFile: "json")
        let mock: APIManager = NetworkManagerMock(response: eventsWrapper, error: nil)
        let characterServiceManager = CharacterServiceManager(networkManager: mock)
        
        // When
        var result: [Event]?
        var errorMessage: String?
        characterServiceManager.getMoreEvents(characterID: characterID, nextPage: nextPage) { (eventContainer, error) in
            if let container = eventContainer {
                result = container.results
            }
            if let e = error {
                errorMessage = e.localizedDescription
            }
        }
        
        // Then
        expect(result).notTo(beNil())
        expect(errorMessage).to(beNil())
        expect(result?.count) > 0
    }
    
    func testErrorPaginationEvents() throws {
        // Given
        let nextPage = 0
        let characterID = 1009351
        let error = MyError.error(message: kMockErrorMessage)
        let mock: APIManager = NetworkManagerMock(response: nil, error: error)
        let characterServiceManager = CharacterServiceManager(networkManager: mock)
        
        // When
        var result: [Event]?
        var errorMessage: String?
        characterServiceManager.getMoreEvents(characterID: characterID, nextPage: nextPage) { (eventContainer, error) in
            if let container = eventContainer {
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
    
    func testSuccessfulPaginationStories() throws {
        // Given
        let nextPage = 0
        let characterID = 1009351
        let storiesWrapper = DecoderFile().decodeStoryFile(name: "Stories", extensionFile: "json")
        let mock: APIManager = NetworkManagerMock(response: storiesWrapper, error: nil)
        let characterServiceManager = CharacterServiceManager(networkManager: mock)
        
        // When
        var result: [Story]?
        var errorMessage: String?
        characterServiceManager.getMoreStories(characterID: characterID, nextPage: nextPage) { (storyContainer, error) in
            if let container = storyContainer {
                result = container.results
            }
            if let e = error {
                errorMessage = e.localizedDescription
            }
        }
        
        // Then
        expect(result).notTo(beNil())
        expect(errorMessage).to(beNil())
        expect(result?.count) > 0
    }
    
    func testErrorPaginationStories() throws {
        // Given
        let nextPage = 0
        let characterID = 1009351
        let error = MyError.error(message: kMockErrorMessage)
        let mock: APIManager = NetworkManagerMock(response: nil, error: error)
        let characterServiceManager = CharacterServiceManager(networkManager: mock)
        
        // When
        var result: [Story]?
        var errorMessage: String?
        characterServiceManager.getMoreStories(characterID: characterID, nextPage: nextPage) { (storyContainer, error) in
            if let container = storyContainer {
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
    
    func testSuccessfulPaginationSeries() throws {
        // Given
        let nextPage = 0
        let characterID = 1009351
        let seriesWrapper = DecoderFile().decodeSerieFile(name: "Series", extensionFile: "json")
        let mock: APIManager = NetworkManagerMock(response: seriesWrapper, error: nil)
        let characterServiceManager = CharacterServiceManager(networkManager: mock)
        
        // When
        var result: [Serie]?
        var errorMessage: String?
        characterServiceManager.getMoreSeries(characterID: characterID, nextPage: nextPage) { (serieContainer, error) in
            if let container = serieContainer {
                result = container.results
            }
            if let e = error {
                errorMessage = e.localizedDescription
            }
        }
        
        // Then
        expect(result).notTo(beNil())
        expect(errorMessage).to(beNil())
        expect(result?.count) > 0
    }
    
    func testErrorPaginationSeries() throws {
        // Given
        let nextPage = 0
        let characterID = 1009351
        let error = MyError.error(message: kMockErrorMessage)
        let mock: APIManager = NetworkManagerMock(response: nil, error: error)
        let characterServiceManager = CharacterServiceManager(networkManager: mock)
        
        // When
        var result: [Serie]?
        var errorMessage: String?
        characterServiceManager.getMoreSeries(characterID: characterID, nextPage: nextPage) { (serieContainer, error) in
            if let container = serieContainer {
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
