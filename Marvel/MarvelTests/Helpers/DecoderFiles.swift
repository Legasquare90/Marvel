//
//  DecoderFiles.swift
//  MarvelTests
//
//  Created by Jose Angel Cuadrado Mingo on 09/07/2020.
//

import Foundation
@testable import Marvel

class DecoderFile {
    
    let decoder: JSONDecoder?
    
    init() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(formatter)
        self.decoder = decoder
    }
    
    func decodeFile(name: String, extensionFile: String) -> CharacterDataWrapper? {
        if let filepath = Bundle(for: type(of: self)).path(forResource: name, ofType: extensionFile) {
            do {
                let contents = try String(contentsOfFile: filepath)
                let data = contents.data(using: .utf8)!
                return try self.decoder?.decode(CharacterDataWrapper.self, from: data)
            } catch let error {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    func decodeComicFile(name: String, extensionFile: String) -> ComicDataWrapper? {
        if let filepath = Bundle(for: type(of: self)).path(forResource: name, ofType: extensionFile) {
            do {
                let contents = try String(contentsOfFile: filepath)
                let data = contents.data(using: .utf8)!
                return try self.decoder?.decode(ComicDataWrapper.self, from: data)
            } catch let error {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    func decodeStoryFile(name: String, extensionFile: String) -> StoryDataWrapper? {
        if let filepath = Bundle(for: type(of: self)).path(forResource: name, ofType: extensionFile) {
            do {
                let contents = try String(contentsOfFile: filepath)
                let data = contents.data(using: .utf8)!
                return try self.decoder?.decode(StoryDataWrapper.self, from: data)
            } catch let error {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    func decodeEventFile(name: String, extensionFile: String) -> EventDataWrapper? {
        if let filepath = Bundle(for: type(of: self)).path(forResource: name, ofType: extensionFile) {
            do {
                let contents = try String(contentsOfFile: filepath)
                let data = contents.data(using: .utf8)!
                return try self.decoder?.decode(EventDataWrapper.self, from: data)
            } catch let error {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    func decodeSerieFile(name: String, extensionFile: String) -> SerieDataWrapper? {
        if let filepath = Bundle(for: type(of: self)).path(forResource: name, ofType: extensionFile) {
            do {
                let contents = try String(contentsOfFile: filepath)
                let data = contents.data(using: .utf8)!
                return try self.decoder?.decode(SerieDataWrapper.self, from: data)
            } catch let error {
                print(error.localizedDescription)
            }
        }
        return nil
    }

}
