//
//  SnapshotTests.swift
//  MarvelTests
//
//  Created by Jose Angel Cuadrado Mingo on 13/07/2020.
//

import XCTest
import FBSnapshotTestCase
@testable import Marvel

class SnapshotTests: FBSnapshotTestCase {

    override func setUpWithError() throws { }

    override func tearDownWithError() throws { }
    
    /**
     - Important: First, set "recordMode" to true to save a snapshot of the controller. This result in test fail, but it is normal. Then, set it to false to execute really the test.
     */
    func testCharactersListController() {
        self.recordMode = false
        
        let controller: CharactersListViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CharactersListViewController") as! CharactersListViewController
        FBSnapshotVerifyView(controller.view, identifier: nil)
    }

}
