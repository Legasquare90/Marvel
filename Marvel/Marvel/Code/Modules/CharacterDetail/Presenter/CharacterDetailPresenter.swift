//
//  CharacterDetailPresenter.swift
//  Marvel
//
//  Created by Jose Angel Cuadrado Mingo on 11/07/2020.
//

import Foundation

class CharacterDetailPresenter: CharacterDetailPresenterInput {

    // MARK: - Architecture

    private var interactor: CharacterDetailInteractorInput?
    private var viewInterface: CharacterDetailPresenterOutput?
    
    private func makeInteractor() -> CharacterDetailInteractorInput {
        return CharacterDetailInteractor(presenter: self)
    }
    
    init(viewInterface: CharacterDetailPresenterOutput?, interactor: CharacterDetailInteractorInput? = nil) {
        self.viewInterface = viewInterface
        self.interactor = interactor ?? makeInteractor()
    }

}

// MARK: -

extension CharacterDetailPresenter: CharacterDetailInteractorOutput {

}
