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
    
}

extension CharactersListPresenter: CharactersListInteractorOutput {
    
}
