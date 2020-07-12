//
//  CharacterDetailPresenterTests.swift
//  MarvelTests
//
//  Created by Jose Angel Cuadrado Mingo on 12/07/2020.
//

import XCTest
import Nimble
@testable import Marvel

class CharacterDetailPresenterTests: XCTestCase {

    var interactorMock: CharacterDetailInteractorMock?
    var presenter: CharacterDetailPresenter?

    override func setUpWithError() throws {
        interactorMock = CharacterDetailInteractorMock()
        presenter = CharacterDetailPresenter(viewInterface: nil, interactor: interactorMock)
    }

    override func tearDownWithError() throws {
        interactorMock?.comics = []
        interactorMock?.stories = []
        interactorMock?.events = []
        interactorMock?.series = []

        interactorMock?.nextComicPage = 0
        interactorMock?.nextStoryPage = 0
        interactorMock?.nextEventPage = 0
        interactorMock?.nextSeriePage = 0
        
        presenter = nil
    }

    func testSaveCharacter() throws {
        // Given
        let hulkWrapper = DecoderFile().decodeFile(name: "Hulk", extensionFile: "json")
        guard let hulk = hulkWrapper?.data?.results?.first else {
            XCTFail()
            return
        }
        
        // When
        presenter?.saveData(character: hulk)
        
        // Then
        expect(self.interactorMock?.comics.count) > 0
        expect(self.interactorMock?.series.count) > 0
        expect(self.interactorMock?.stories.count) > 0
        expect(self.interactorMock?.events.count) > 0
        expect(self.interactorMock?.nextComicPage) == 1
        expect(self.interactorMock?.nextSeriePage) == 1
        expect(self.interactorMock?.nextStoryPage) == 1
        expect(self.interactorMock?.nextEventPage) == 1
        expect(self.interactorMock?.characterID) == hulk.characterID
    }
    
    func testCountComicRows() throws {
        // Given
        let hulkWrapper = DecoderFile().decodeFile(name: "Hulk", extensionFile: "json")
        guard let hulk = hulkWrapper?.data?.results?.first else {
            XCTFail()
            return
        }
        
        // When
        presenter?.saveData(character: hulk)
        let count = presenter?.numberOfRows(section: .Comics)

        // Then
        expect(count) == 20
    }
    
    func testCountSerieRows() throws {
        // Given
        let hulkWrapper = DecoderFile().decodeFile(name: "Hulk", extensionFile: "json")
        guard let hulk = hulkWrapper?.data?.results?.first else {
            XCTFail()
            return
        }
        
        // When
        presenter?.saveData(character: hulk)
        let count = presenter?.numberOfRows(section: .Series)

        // Then
        expect(count) == 20
    }
    
    func testCountStoryRows() throws {
        // Given
        let hulkWrapper = DecoderFile().decodeFile(name: "Hulk", extensionFile: "json")
        guard let hulk = hulkWrapper?.data?.results?.first else {
            XCTFail()
            return
        }
        
        // When
        presenter?.saveData(character: hulk)
        let count = presenter?.numberOfRows(section: .Stories)

        // Then
        expect(count) == 20
    }
    
    func testCountEventRows() throws {
        // Given
        let hulkWrapper = DecoderFile().decodeFile(name: "Hulk", extensionFile: "json")
        guard let hulk = hulkWrapper?.data?.results?.first else {
            XCTFail()
            return
        }
        
        // When
        presenter?.saveData(character: hulk)
        let count = presenter?.numberOfRows(section: .Events)

        // Then
        expect(count) == 20
    }
    
    func testGetFirstComicName() throws {
        // Given
        let hulkWrapper = DecoderFile().decodeFile(name: "Hulk", extensionFile: "json")
        guard let hulk = hulkWrapper?.data?.results?.first else {
            XCTFail()
            return
        }
        
        // When
        presenter?.saveData(character: hulk)
        let title = presenter?.getContentTitle(index: 0, section: .Comics)

        // Then
        expect(title) == "5 Ronin (Hardcover)"
    }
    
    func testGetFirstSerieName() throws {
        // Given
        let hulkWrapper = DecoderFile().decodeFile(name: "Hulk", extensionFile: "json")
        guard let hulk = hulkWrapper?.data?.results?.first else {
            XCTFail()
            return
        }
        
        // When
        presenter?.saveData(character: hulk)
        let title = presenter?.getContentTitle(index: 0, section: .Series)

        // Then
        expect(title) == "5 Ronin (2011)"
    }
    
    func testGetFirstStoryName() throws {
        // Given
        let hulkWrapper = DecoderFile().decodeFile(name: "Hulk", extensionFile: "json")
        guard let hulk = hulkWrapper?.data?.results?.first else {
            XCTFail()
            return
        }
        
        // When
        presenter?.saveData(character: hulk)
        let title = presenter?.getContentTitle(index: 0, section: .Stories)

        // Then
        expect(title) == "INCREDIBLE HULK (1999) #62"
    }
    
    func testGetFirstEventName() throws {
        // Given
        let hulkWrapper = DecoderFile().decodeFile(name: "Hulk", extensionFile: "json")
        guard let hulk = hulkWrapper?.data?.results?.first else {
            XCTFail()
            return
        }
        
        // When
        presenter?.saveData(character: hulk)
        let title = presenter?.getContentTitle(index: 0, section: .Events)

        // Then
        expect(title) == "Acts of Vengeance!"
    }
    
    func testCheckComicPaginationTooEarly() throws {
        // Given
        let hulkWrapper = DecoderFile().decodeFile(name: "Hulk", extensionFile: "json")
        guard let hulk = hulkWrapper?.data?.results?.first else {
            XCTFail()
            return
        }
        let index = 0
        
        // When
        presenter?.saveData(character: hulk)
        let initialCount = interactorMock?.comics.count
        presenter?.checkPagination(index: index, section: .Comics)
        let finalCount = interactorMock?.comics.count
        
        // Then
        expect(initialCount) == finalCount
    }
    
    func testCheckComicPaginationSuccessful() throws {
        // Given
        let hulkWrapper = DecoderFile().decodeFile(name: "Hulk", extensionFile: "json")
        guard let hulk = hulkWrapper?.data?.results?.first else {
            XCTFail()
            return
        }

        // When
        presenter?.saveData(character: hulk)
        let initialCount = interactorMock?.comics.count ?? 0
        let index = initialCount - 3
        presenter?.checkPagination(index: index, section: .Comics)
        let finalCount = interactorMock?.comics.count ?? 0

        // Then
        expect(initialCount) < finalCount
    }
    
    func testCheckSeriePaginationTooEarly() throws {
        // Given
        let hulkWrapper = DecoderFile().decodeFile(name: "Hulk", extensionFile: "json")
        guard let hulk = hulkWrapper?.data?.results?.first else {
            XCTFail()
            return
        }
        let index = 0
        
        // When
        presenter?.saveData(character: hulk)
        let initialCount = interactorMock?.series.count
        presenter?.checkPagination(index: index, section: .Series)
        let finalCount = interactorMock?.series.count
        
        // Then
        expect(initialCount) == finalCount
    }
    
    func testCheckSeriePaginationSuccessful() throws {
        // Given
        let hulkWrapper = DecoderFile().decodeFile(name: "Hulk", extensionFile: "json")
        guard let hulk = hulkWrapper?.data?.results?.first else {
            XCTFail()
            return
        }

        // When
        presenter?.saveData(character: hulk)
        let initialCount = interactorMock?.series.count ?? 0
        let index = initialCount - 3
        presenter?.checkPagination(index: index, section: .Series)
        let finalCount = interactorMock?.series.count ?? 0

        // Then
        expect(initialCount) < finalCount
    }
    
    func testCheckStoryPaginationTooEarly() throws {
        // Given
        let hulkWrapper = DecoderFile().decodeFile(name: "Hulk", extensionFile: "json")
        guard let hulk = hulkWrapper?.data?.results?.first else {
            XCTFail()
            return
        }
        let index = 0
        
        // When
        presenter?.saveData(character: hulk)
        let initialCount = interactorMock?.stories.count
        presenter?.checkPagination(index: index, section: .Stories)
        let finalCount = interactorMock?.stories.count
        
        // Then
        expect(initialCount) == finalCount
    }
    
    func testCheckStoryPaginationSuccessful() throws {
        // Given
        let hulkWrapper = DecoderFile().decodeFile(name: "Hulk", extensionFile: "json")
        guard let hulk = hulkWrapper?.data?.results?.first else {
            XCTFail()
            return
        }

        // When
        presenter?.saveData(character: hulk)
        let initialCount = interactorMock?.stories.count ?? 0
        let index = initialCount - 3
        presenter?.checkPagination(index: index, section: .Stories)
        let finalCount = interactorMock?.stories.count ?? 0

        // Then
        expect(initialCount) < finalCount
    }

    func testCheckEventPaginationTooEarly() throws {
        // Given
        let hulkWrapper = DecoderFile().decodeFile(name: "Hulk", extensionFile: "json")
        guard let hulk = hulkWrapper?.data?.results?.first else {
            XCTFail()
            return
        }
        let index = 0
        
        // When
        presenter?.saveData(character: hulk)
        let initialCount = interactorMock?.events.count
        presenter?.checkPagination(index: index, section: .Events)
        let finalCount = interactorMock?.events.count
        
        // Then
        expect(initialCount) == finalCount
    }
    
    func testCheckEventPaginationSuccessful() throws {
        // Given
        let hulkWrapper = DecoderFile().decodeFile(name: "Hulk", extensionFile: "json")
        guard let hulk = hulkWrapper?.data?.results?.first else {
            XCTFail()
            return
        }

        // When
        presenter?.saveData(character: hulk)
        let initialCount = interactorMock?.events.count ?? 0
        let index = initialCount - 3
        presenter?.checkPagination(index: index, section: .Events)
        let finalCount = interactorMock?.events.count ?? 0

        // Then
        expect(initialCount) < finalCount
    }

}

