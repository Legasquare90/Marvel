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
    private weak var viewInterface: CharacterDetailPresenterOutput?
    
    private func makeInteractor() -> CharacterDetailInteractorInput {
        return CharacterDetailInteractor(presenter: self)
    }
    
    init(viewInterface: CharacterDetailPresenterOutput?, interactor: CharacterDetailInteractorInput? = nil) {
        self.viewInterface = viewInterface
        self.interactor = interactor ?? makeInteractor()
    }
    
    // MARK: - CharacterDetailPresenterInput
    
    func saveData(character: Character) {
        interactor?.characterID = character.characterID ?? 0
        
        interactor?.comics = character.comics?.items ?? []
        interactor?.stories = character.stories?.items ?? []
        interactor?.events = character.events?.items ?? []
        interactor?.series = character.series?.items ?? []

        interactor?.nextComicPage = (character.comics?.available ?? 0) > (character.comics?.items?.count ?? 0) ? 1 : 0
        interactor?.nextStoryPage = (character.stories?.available ?? 0) > (character.stories?.items?.count ?? 0) ? 1 : 0
        interactor?.nextEventPage = (character.events?.available ?? 0) > (character.events?.items?.count ?? 0) ? 1 : 0
        interactor?.nextSeriePage = (character.series?.available ?? 0) > (character.series?.items?.count ?? 0) ? 1 : 0
    }
    
    func numberOfRows(section: TableSection) -> Int {
        switch section {
            case .Comics:
                return interactor?.comics.count ?? 0
            case .Stories:
                return interactor?.stories.count ?? 0
            case .Events:
                return interactor?.events.count ?? 0
            case .Series:
                return interactor?.series.count ?? 0
        }
    }
    
    func getContentTitle(index: Int, section: TableSection) -> String {
        switch section {
            case .Comics:
                return interactor?.comics[index].titleDetail ?? interactor?.comics[index].name ?? ""
            case .Stories:
                return interactor?.stories[index].titleDetail ?? interactor?.stories[index].name ?? ""
            case .Events:
                return interactor?.events[index].titleDetail ?? interactor?.events[index].name ?? ""
            case .Series:
                return interactor?.series[index].titleDetail ?? interactor?.series[index].name ?? ""
        }
    }
    
    func checkPagination(index: Int, section: TableSection) {
        switch section {
            case .Comics:
                if index == (interactor?.comics.count ?? 0) - 3 && interactor?.nextComicPage != 0 {
                    interactor?.getMoreComics()
                }
            case .Stories:
                if index == (interactor?.stories.count ?? 0) - 3 && interactor?.nextStoryPage != 0 {
                    interactor?.getMoreStories()
                }
            case .Events:
                if index == (interactor?.events.count ?? 0) - 3 && interactor?.nextEventPage != 0 {
                    interactor?.getMoreEvents()
                }
            case .Series:
                if index == (interactor?.series.count ?? 0) - 3 && interactor?.nextSeriePage != 0 {
                    interactor?.getMoreSeries()
                }
        }
    }
    
    func getEmptyTitle(section: TableSection) -> String {
        switch section {
            case .Comics:
                return "character_detail_empty_comics".localized
            case .Stories:
                return "character_detail_empty_stories".localized
            case .Events:
                return "character_detail_empty_events".localized
            case .Series:
                return "character_detail_empty_series".localized
        }
    }

}

// MARK: - CharacterDetailInteractorOutput

extension CharacterDetailPresenter: CharacterDetailInteractorOutput {
    func refreshData() {
        viewInterface?.refreshView()
    }
    
    func showError() {
        viewInterface?.showError()
    }
}
