//
//  CryptoTests.swift
//  MarvelTests
//
//  Created by Jose Angel Cuadrado Mingo on 07/07/2020.
//

import XCTest
@testable import Marvel

class CryptoTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testValidMD5() throws {
        let str = "1abcd1234"
        let hash = "ffd275c5130566a2916217b101f26150"
        let result = md5Hash(str: str)
        XCTAssertEqual(result, hash)
    }

}
