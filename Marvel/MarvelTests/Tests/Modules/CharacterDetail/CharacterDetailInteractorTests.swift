//
//  CharacterDetailInteractorTests.swift
//  MarvelTests
//
//  Created by Jose Angel Cuadrado Mingo on 12/07/2020.
//

import XCTest
import Nimble
@testable import Marvel

class CharacterDetailInteractorTests: XCTestCase {

    var serviceManagerMock: CharacterServiceManagerMock?
    var interactor: CharacterDetailInteractor?

    override func setUpWithError() throws {
        serviceManagerMock = CharacterServiceManagerMock()
        interactor = CharacterDetailInteractor(presenter: nil, characterServiceManager: serviceManagerMock)
    }

    override func tearDownWithError() throws {
        interactor = nil
    }

    func testGetComics() throws {
        // Given
        let initialCount = interactor?.comics.count ?? 0

        // When
        interactor?.getMoreComics()
        
        // Then
        expect(self.interactor?.nextComicPage) == 1
        expect(self.interactor?.comics.count) > initialCount
    }
    
    func testGetStories() throws {
        // Given
        let initialCount = interactor?.stories.count ?? 0

        // When
        interactor?.getMoreStories()
        
        // Then
        expect(self.interactor?.nextStoryPage) == 1
        expect(self.interactor?.stories.count) > initialCount
    }
    
    func testGetEvents() throws {
        // Given
        let initialCount = interactor?.events.count ?? 0

        // When
        interactor?.getMoreEvents()
        
        // Then
        expect(self.interactor?.nextEventPage) == 1
        expect(self.interactor?.events.count) > initialCount
    }
    
    func testGetSeries() throws {
        // Given
        let initialCount = interactor?.series.count ?? 0

        // When
        interactor?.getMoreSeries()
        
        // Then
        expect(self.interactor?.nextSeriePage) == 1
        expect(self.interactor?.series.count) > initialCount
    }

}
