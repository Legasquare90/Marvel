//
//  CryptoTests.swift
//  MarvelTests
//
//  Created by Jose Angel Cuadrado Mingo on 07/07/2020.
//

import XCTest
import Nimble
@testable import Marvel

class CryptoTests: XCTestCase {

    override func setUpWithError() throws { }

    override func tearDownWithError() throws { }

    func testValidMD5() throws {
        // Given
        let str = "1abcd1234"
        let hash = "ffd275c5130566a2916217b101f26150"
        
        // When
        let result = md5Hash(str: str)
        
        // Then
        expect(result) == hash
    }

}
