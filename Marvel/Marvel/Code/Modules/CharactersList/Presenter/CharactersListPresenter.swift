//
//  CharactersListPresenter.swift
//  Marvel
//
//  Created by Jose Angel Cuadrado Mingo on 09/07/2020.
//

import Foundation

class CharactersListPresenter: CharactersListPresenterInput {

    var filteredCharacters: [Character]?
    var filterContent = false
    
    // MARK: - Architecture

    private var interactor: CharactersListInteractorInput?
    private var viewInterface: CharactersListPresenterOutput?
    
    private func makeInteractor() -> CharactersListInteractorInput {
        return CharactersListInteractor(presenter: self)
    }
    
    init(viewInterface: CharactersListPresenterOutput?, interactor: CharactersListInteractorInput? = nil) {
        self.viewInterface = viewInterface
        self.interactor = interactor ?? makeInteractor()
    }
    
    // MARK: - CharactersListPresenterInput

    func getCharacters() {
        interactor?.getCharacters()
    }
    
    func getCharacter(index: Int) -> Character? {
        if filterContent {
            return filteredCharacters?[index]
        } else {
            return interactor?.characters[index]
        }
    }
    
    func countCharacters() -> Int {
        return (filterContent ? filteredCharacters?.count : interactor?.characters.count) ?? 0
    }
    
    func getDesign(index: Int) -> CharacterCellDesign {
        let characters = filterContent ? filteredCharacters : interactor?.characters
        if let character = characters?[index] {
            if let name = character.name, let thumbnail = character.thumbnail {
                let imageURL = String(format: "%@.%@", (thumbnail.path ?? ""), (thumbnail.thumbnailExtension?.rawValue ?? ""))
                return CharacterCellDesign(name: name, imageURL: imageURL)
            }
        }
        return CharacterCellDesign()
    }
    
    func filterCharacters(search: String) {
        if search != "" {
            filterContent = true
            filteredCharacters = interactor?.charactersWithExtraSearch.filter({
                ($0.name?.lowercased().contains(search.lowercased()) ?? false)
            })
        } else {
            filterContent = false
            filteredCharacters = nil
        }
        viewInterface?.refreshView()
    }
        
    func searchCharacters(search: String) {
        interactor?.searchCharacters(search: search)
    }
    
    func isThereMoreCharacters() -> Bool {
        return interactor?.nextPage != 0
    }
    
    func checkPagination(index: Int) {
        if !filterContent {
            if index == countCharacters() - 6 && isThereMoreCharacters() {
                getCharacters()
            }
        }
    }
    
}

// MARK: - CharactersListInteractorOutput

extension CharactersListPresenter: CharactersListInteractorOutput {
    func charactersReceived() {
        viewInterface?.refreshView()
    }
    
    func searchFinished(search: String) {
        filterCharacters(search: search)
        viewInterface?.searchFinished()
    }
    
    func showError() {
        viewInterface?.showError()
    }
}
