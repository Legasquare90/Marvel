//
//  CharacterDetailPresenterIO.swift
//  Marvel
//
//  Created by Jose Angel Cuadrado Mingo on 11/07/2020.
//

import Foundation

protocol CharacterDetailPresenterInput {
    func saveData(character: Character)
    func numberOfRows(section: TableSection) -> Int
    func getContentTitle(index: Int, section: TableSection) -> String
    func checkPagination(index: Int, section: TableSection)
    func getEmptyTitle(section: TableSection) -> String
}

protocol CharacterDetailPresenterOutput {
    func refreshView()
    func showError()
}
