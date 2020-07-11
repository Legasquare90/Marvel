//
//  CharactersListInteractorIO.swift
//  Marvel
//
//  Created by Jose Angel Cuadrado Mingo on 09/07/2020.
//

import Foundation

protocol CharactersListInteractorInput {
    var characters: [Character] { get }
    var nextPage: Int { get }

    func getCharacters()
}

protocol CharactersListInteractorOutput {
    func charactersReceived()
    func showError()
}
