//
//  CharacterDetailInteractor.swift
//  Marvel
//
//  Created by Jose Angel Cuadrado Mingo on 11/07/2020.
//

import Foundation

class CharacterDetailInteractor: CharacterDetailInteractorInput {

    private var presenter: CharacterDetailInteractorOutput?

    init(presenter: CharacterDetailInteractorOutput?) {
        self.presenter = presenter
    }

}
