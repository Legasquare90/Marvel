//
//  CharactersListInteractor.swift
//  Marvel
//
//  Created by Jose Angel Cuadrado Mingo on 09/07/2020.
//

import Foundation

class CharactersListInteractor: CharactersListInteractorInput {

    var characters: [Character] = []
    var nextPage: Int = 0
    
    private var characterServiceManager = CharacterServiceManager()
    private var presenter: CharactersListInteractorOutput?

    init(presenter: CharactersListInteractorOutput) {
        self.presenter = presenter
    }
    
    func getCharacters() {
        characterServiceManager.getCharacters(nextPage: nextPage) { (characterContainer, errorMessage) in
            if let message = errorMessage {
                self.presenter?.showError(message: message)
            } else {
                if let container = characterContainer {
                    let contentsReceived = (self.nextPage * Constants.contentsPerRequest) + (container.count ?? 0)
                    if contentsReceived < (container.total ?? 0) {
                        self.nextPage += 1
                    } else {
                        self.nextPage = 0
                    }
                    self.characters += container.results ?? []
                    self.presenter?.charactersReceived()
                }
            }
        }
    }
}
