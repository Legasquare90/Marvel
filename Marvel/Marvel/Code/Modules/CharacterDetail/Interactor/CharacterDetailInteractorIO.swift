//
//  CharacterDetailInteractorIO.swift
//  Marvel
//
//  Created by Jose Angel Cuadrado Mingo on 11/07/2020.
//

import Foundation

protocol CharacterDetailInteractorInput {
    var characterID: Int { get set }
    
    var comics: [Comic] { get set }
    var stories: [Story] { get set }
    var events: [Event] { get set }
    var series: [Serie] { get set }

    var nextComicPage: Int { get set }
    var nextStoryPage: Int { get set }
    var nextEventPage: Int { get set }
    var nextSeriePage: Int { get set }

    func getMoreComics()
    func getMoreStories()
    func getMoreEvents()
    func getMoreSeries()
}

protocol CharacterDetailInteractorOutput: class {
    func refreshData()
    func showError()
}
