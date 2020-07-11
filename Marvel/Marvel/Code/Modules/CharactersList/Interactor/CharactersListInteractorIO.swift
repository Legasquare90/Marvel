//
//  CharactersListInteractorIO.swift
//  Marvel
//
//  Created by Jose Angel Cuadrado Mingo on 09/07/2020.
//

import Foundation

protocol CharactersListInteractorInput {
    var characters: [Character] { get }
    var charactersWithExtraSearch: [Character] { get }
    var nextPage: Int { get }

    func getCharacters()
    func searchCharacters(search: String)
}

protocol CharactersListInteractorOutput {
    func charactersReceived()
    func searchFinished(search: String)
    func showError()
}
