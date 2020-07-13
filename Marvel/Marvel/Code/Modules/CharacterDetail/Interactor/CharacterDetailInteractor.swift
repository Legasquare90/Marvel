//
//  CharacterDetailInteractor.swift
//  Marvel
//
//  Created by Jose Angel Cuadrado Mingo on 11/07/2020.
//

import Foundation

class CharacterDetailInteractor: CharacterDetailInteractorInput {
    
    var characterID: Int = 0
    
    var comics: [Comic] = []
    var stories: [Story] = []
    var events: [Event] = []
    var series: [Serie] = []
    
    var nextComicPage = 0
    var nextStoryPage = 0
    var nextEventPage = 0
    var nextSeriePage = 0

    // MARK: - Architecture

    private var characterServiceManager: CharacterServiceManager?
    private var presenter: CharacterDetailInteractorOutput?

    init(presenter: CharacterDetailInteractorOutput?, characterServiceManager: CharacterServiceManager? = nil) {
        self.presenter = presenter
        self.characterServiceManager = characterServiceManager ?? CharacterServiceManager()
    }

    // MARK: - CharacterDetailInteractorInput

    func getMoreComics() {
        characterServiceManager?.getMoreComics(characterID: characterID, nextPage: nextComicPage, completion: { (comicContainer, error) in
            if let _ = error {
                self.presenter?.showError()
            } else {
                if let container = comicContainer {
                    let contentsReceived = (self.nextComicPage * Constants.contentsInCollectionsPerRequest) + (container.count ?? 0)
                    if contentsReceived < (container.total ?? 0) {
                        self.nextComicPage += 1
                    } else {
                        self.nextComicPage = 0
                    }
                    self.comics += container.results ?? []
                    self.presenter?.refreshData()
                }
            }
        })
    }
    
    func getMoreStories() {
        characterServiceManager?.getMoreStories(characterID: characterID, nextPage: nextStoryPage, completion: { (storyContainer, error) in
            if let _ = error {
                self.presenter?.showError()
            } else {
                if let container = storyContainer {
                    let contentsReceived = (self.nextStoryPage * Constants.contentsInCollectionsPerRequest) + (container.count ?? 0)
                    if contentsReceived < (container.total ?? 0) {
                        self.nextStoryPage += 1
                    } else {
                        self.nextStoryPage = 0
                    }
                    self.stories += container.results ?? []
                    self.presenter?.refreshData()
                }
            }
        })
    }
    
    func getMoreEvents() {
        characterServiceManager?.getMoreEvents(characterID: characterID, nextPage: nextEventPage, completion: { (eventContainer, error) in
            if let _ = error {
                self.presenter?.showError()
            } else {
                if let container = eventContainer {
                    let contentsReceived = (self.nextEventPage * Constants.contentsInCollectionsPerRequest) + (container.count ?? 0)
                    if contentsReceived < (container.total ?? 0) {
                        self.nextEventPage += 1
                    } else {
                        self.nextEventPage = 0
                    }
                    self.events += container.results ?? []
                    self.presenter?.refreshData()
                }
            }
        })
    }
    
    func getMoreSeries() {
        characterServiceManager?.getMoreSeries(characterID: characterID, nextPage: nextSeriePage, completion: { (serieContainer, error) in
            if let _ = error {
                self.presenter?.showError()
            } else {
                if let container = serieContainer {
                    let contentsReceived = (self.nextSeriePage * Constants.contentsInCollectionsPerRequest) + (container.count ?? 0)
                    if contentsReceived < (container.total ?? 0) {
                        self.nextSeriePage += 1
                    } else {
                        self.nextSeriePage = 0
                    }
                    self.series += container.results ?? []
                    self.presenter?.refreshData()
                }
            }
        })
    }
}
