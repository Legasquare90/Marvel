//
//  CharactersListInteractor.swift
//  Marvel
//
//  Created by Jose Angel Cuadrado Mingo on 09/07/2020.
//

import Foundation

class CharactersListInteractor: CharactersListInteractorInput {

    private var presenter: CharactersListInteractorOutput?

    init(presenter: CharactersListInteractorOutput) {
        self.presenter = presenter
    }
}
