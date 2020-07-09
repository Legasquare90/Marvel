//
//  CharactersListInteractor.swift
//  Marvel
//
//  Created by Jose Angel Cuadrado Mingo on 09/07/2020.
//

import Foundation

class CharactersListInteractor: CharactersListInteractorInput {

    var characters: [Character]?
    
    private var characterServiceManager = CharacterServiceManager()
    private var presenter: CharactersListInteractorOutput?

    init(presenter: CharactersListInteractorOutput) {
        self.presenter = presenter
    }
    
    func getCharacters() {
        characterServiceManager.getCharacters { (characters, errorMessage) in
            if let message = errorMessage {
                self.presenter?.showError(message: message)
            } else {
                self.characters = characters
                self.presenter?.charactersReceived()
            }
        }
    }
}
