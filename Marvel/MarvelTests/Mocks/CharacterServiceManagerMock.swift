//
//  CharacterServiceManagerMock.swift
//  MarvelTests
//
//  Created by Jose Angel Cuadrado Mingo on 11/07/2020.
//

import Foundation
@testable import Marvel

class CharacterServiceManagerMock: CharacterServiceManager {
    
    override func getCharacters(nextPage: Int, completion:@escaping (_ characters: CharacterDataContainer?, _ error: Error?) -> Void) {
        let multipleWrapper = DecoderFile().decodeFile(name: "MultipleResults", extensionFile: "json")
        completion(multipleWrapper?.data, nil)
    }
    
    override func searchCharacters(search: String, completion:@escaping (_ characters: [Character]?, _ error: Error?) -> Void) {
        let ironWrapper = DecoderFile().decodeFile(name: "IronSearch", extensionFile: "json")
        completion(ironWrapper?.data?.results, nil)
    }
    
    override func getMoreComics(characterID: Int, nextPage: Int, completion: @escaping (ComicDataContainer?, Error?) -> Void) {
        let comicsWrapper = DecoderFile().decodeComicFile(name: "Comics", extensionFile: "json")
        completion(comicsWrapper?.data, nil)
    }
    
    override func getMoreEvents(characterID: Int, nextPage: Int, completion: @escaping (EventDataContainer?, Error?) -> Void) {
        let eventsWrapper = DecoderFile().decodeEventFile(name: "Events", extensionFile: "json")
        completion(eventsWrapper?.data, nil)
    }
    
    override func getMoreSeries(characterID: Int, nextPage: Int, completion: @escaping (SerieDataContainer?, Error?) -> Void) {
        let seriesWrapper = DecoderFile().decodeSerieFile(name: "Series", extensionFile: "json")
        completion(seriesWrapper?.data, nil)
    }
    
    override func getMoreStories(characterID: Int, nextPage: Int, completion: @escaping (StoryDataContainer?, Error?) -> Void) {
        let storiesWrapper = DecoderFile().decodeStoryFile(name: "Stories", extensionFile: "json")
        completion(storiesWrapper?.data, nil)
    }
}
