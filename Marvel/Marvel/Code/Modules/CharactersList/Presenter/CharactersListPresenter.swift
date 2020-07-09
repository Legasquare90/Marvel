//
//  CharactersListPresenter.swift
//  Marvel
//
//  Created by Jose Angel Cuadrado Mingo on 09/07/2020.
//

import Foundation

class CharactersListPresenter: NSObject, CharactersListPresenterInput {

    private lazy var interactor: CharactersListInteractorInput = self.makeInteractor()
    private var viewInterface: CharactersListPresenterOutput?
    
    private func makeInteractor() -> CharactersListInteractorInput {
        return CharactersListInteractor(presenter: self)
    }
    
    init(viewInterface: CharactersListPresenterOutput) {
        self.viewInterface = viewInterface
    }
    
    func getCharacters() {
        interactor.getCharacters()
    }
    
    func countCharacters() -> Int {
        return interactor.characters?.count ?? 0
    }
    
    func getDesign(index: Int) -> CharacterCellDesign {
        if let character = interactor.characters?[index] {
            if let name = character.name, let thumbnail = character.thumbnail {
                let imageURL = String(format: "%@.%@", (thumbnail.path ?? ""), (thumbnail.thumbnailExtension?.rawValue ?? ""))
                return CharacterCellDesign(name: name, imageURL: imageURL)
            }
        }
        return CharacterCellDesign()
    }
    
}

extension CharactersListPresenter: CharactersListInteractorOutput {
    func charactersReceived() {
        viewInterface?.refreshView()
    }
    
    func showError(message: String) {
        viewInterface?.showError(message: message)
    }
}
