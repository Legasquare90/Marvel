//
//  CharactersListPresenterIO.swift
//  Marvel
//
//  Created by Jose Angel Cuadrado Mingo on 09/07/2020.
//

import Foundation

protocol CharactersListPresenterInput {
    func getCharacters()
    func countCharacters() -> Int
    func getDesign(index: Int) -> CharacterCellDesign
    func filterCharacters(search: String)
    func searchCharacters(search: String)
    func isThereMoreCharacters() -> Bool
    func checkPagination(index: Int)
}

protocol CharactersListPresenterOutput {
    func refreshView()
    func searchFinished()
    func showError()
}
