//
//  CharacterDetailInteractorMock.swift
//  MarvelTests
//
//  Created by Jose Angel Cuadrado Mingo on 12/07/2020.
//

import Foundation
@testable import Marvel

class CharacterDetailInteractorMock: CharacterDetailInteractorInput {
    var characterID: Int = 1009351
    
    var comics: [Comic] = []
    var stories: [Story] = []
    var events: [Event] = []
    var series: [Serie] = []
    
    var nextComicPage: Int = 0
    var nextStoryPage: Int = 0
    var nextEventPage: Int = 0
    var nextSeriePage: Int = 0
    
    func getMoreComics() {
        let comicWrapper = DecoderFile().decodeComicFile(name: "Comics", extensionFile: "json")
        comics += comicWrapper?.data?.results ?? []
        nextComicPage += 1
    }
    
    func getMoreStories() {
        let storyWrapper = DecoderFile().decodeStoryFile(name: "Stories", extensionFile: "json")
        stories += storyWrapper?.data?.results ?? []
        nextStoryPage += 1
    }
    
    func getMoreEvents() {
        let eventWrapper = DecoderFile().decodeEventFile(name: "Events", extensionFile: "json")
        events += eventWrapper?.data?.results ?? []
        nextEventPage += 1
    }
    
    func getMoreSeries() {
        let serieWrapper = DecoderFile().decodeSerieFile(name: "Series", extensionFile: "json")
        series += serieWrapper?.data?.results ?? []
        nextSeriePage += 1
    }
    
}
