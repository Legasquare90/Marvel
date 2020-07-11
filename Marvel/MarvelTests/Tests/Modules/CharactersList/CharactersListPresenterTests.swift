//
//  CharactersListPresenterTests.swift
//  MarvelTests
//
//  Created by Jose Angel Cuadrado Mingo on 11/07/2020.
//

import XCTest
import Nimble
@testable import Marvel

class CharactersListPresenterTests: XCTestCase {

    var interactorMock: CharactersListInteractorMock?
    var presenter: CharactersListPresenter?
    
    override func setUpWithError() throws {
        interactorMock = CharactersListInteractorMock()
        presenter = CharactersListPresenter(viewInterface: nil, interactor: interactorMock)
    }

    override func tearDownWithError() throws {
        interactorMock?.characters = []
        interactorMock?.charactersWithExtraSearch = []
        interactorMock?.nextPage = 0
        presenter = nil
    }

    func testCountCharacters() throws {
        // Given
        
        // When
        presenter?.getCharacters()
        let count = presenter?.countCharacters()
        
        // Then
        expect(count) == interactorMock?.characters.count
        expect(count) > 0
    }
    
    func testFilterWithSearchEmpty() throws {
        // Given

        // When
        presenter?.filterCharacters(search: "")
        
        // Then
        expect(self.presenter?.filterContent) == false
        expect(self.presenter?.filteredCharacters).to(beNil())
    }
    
    func testFilterWithSearch() throws {
        // Given
        let search = "3-D"

        // When
        presenter?.getCharacters()
        presenter?.filterCharacters(search: search)
        
        // Then
        expect(self.presenter?.filterContent) == true
        expect(self.presenter?.filteredCharacters).notTo(beNil())
        expect(self.presenter?.filteredCharacters?.count) > 0
        expect(self.presenter?.filteredCharacters?.first?.name?.lowercased()).to(contain(search.lowercased()))
    }
    
    func testCountCharactersWithFilter() throws {
        // Given
        let search = "3-D"
        
        // When
        presenter?.getCharacters()
        presenter?.filterCharacters(search: search)
        let count = presenter?.countCharacters()
        
        // Then
        expect(count) == presenter?.filteredCharacters?.count
        expect(count) > 0
    }

    func testCellDesign() throws {
        // Given

        // When
        presenter?.getCharacters()
        let design = presenter?.getDesign(index: 0)
        
        // Then
        expect(design?.name) == "3-D Man"
        expect(design?.imageURL) != "."
    }
    
    func testSearchCharacters() throws {
        // Given
        let search = "iron"
        
        // When
        presenter?.searchCharacters(search: search)
        presenter?.filterCharacters(search: search)
        
        // Then
        expect(self.presenter?.filteredCharacters).notTo(beNil())
        expect(self.presenter?.filteredCharacters?.count) > 0
        expect(self.presenter?.filteredCharacters?.first?.name?.lowercased()).to(contain(search.lowercased()))
    }
    
    func testIsMoreCharacters() throws {
        // Given
        
        // When
        presenter?.getCharacters()
        let result = presenter?.isThereMoreCharacters()
        
        // Then
        expect(result) == true
    }
    
    func testCheckPaginationWithFilter() throws {
        // Given
        let search = "3-D"
        let index = 0
        
        // When
        presenter?.getCharacters()
        presenter?.filterCharacters(search: search)
        let initialCount = presenter?.countCharacters()
        presenter?.checkPagination(index: index)
        let finalCount = presenter?.countCharacters()
        
        // Then
        expect(initialCount) == finalCount
    }
    
    func testCheckPaginationTooEarly() throws {
        // Given
        let index = 0
        
        // When
        presenter?.getCharacters()
        let initialCount = presenter?.countCharacters()
        presenter?.checkPagination(index: index)
        let finalCount = presenter?.countCharacters()
        
        // Then
        expect(initialCount) == finalCount
    }
    
    func testCheckPaginationSuccessful() throws {
        // Given
        
        // When
        presenter?.getCharacters()
        let initialCount = (presenter?.countCharacters() ?? 0)
        let index = initialCount - 6
        presenter?.checkPagination(index: index)
        let finalCount = (presenter?.countCharacters() ?? 0)
        
        // Then
        expect(initialCount) < finalCount
    }

}
