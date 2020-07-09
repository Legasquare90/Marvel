//
//  CharactersListPresenter.swift
//  Marvel
//
//  Created by Jose Angel Cuadrado Mingo on 09/07/2020.
//

import Foundation

class CharactersListPresenter: NSObject, CharactersListPresenterInput {

    private var filteredCharacters: [Character]?
    private var filterContent = false
    
    // MARK: - Architecture

    private lazy var interactor: CharactersListInteractorInput = self.makeInteractor()
    private var viewInterface: CharactersListPresenterOutput?
    
    private func makeInteractor() -> CharactersListInteractorInput {
        return CharactersListInteractor(presenter: self)
    }
    
    init(viewInterface: CharactersListPresenterOutput) {
        self.viewInterface = viewInterface
    }
    
    // MARK: - CharactersListPresenterInput

    func getCharacters() {
        interactor.getCharacters()
    }
    
    func countCharacters() -> Int {
        return (filterContent ? filteredCharacters?.count : interactor.characters?.count) ?? 0
    }
    
    func getDesign(index: Int) -> CharacterCellDesign {
        let characters = filterContent ? filteredCharacters : interactor.characters
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
            filteredCharacters = interactor.characters?.filter({
                ($0.name?.lowercased().contains(search.lowercased()) ?? false)
            })
        } else {
            filterContent = false
            filteredCharacters = nil
        }
        viewInterface?.refreshView()
    }
    
}

// MARK: -

extension CharactersListPresenter: CharactersListInteractorOutput {
    func charactersReceived() {
        viewInterface?.refreshView()
    }
    
    func showError(message: String) {
        viewInterface?.showError(message: message)
    }
}
