//
//  ZeroStoreTests.swift
//  ZeroStoreTests
//
//  Created by Kyle Bashour on 9/3/15.
//  Copyright (c) 2015 Kyle Bashour. All rights reserved.
//

import UIKit
import XCTest

class TestPasswordGeneration: XCTestCase {

    override func setUp() {
        super.setUp()

    }
    
    override func tearDown() {

        super.tearDown()
    }
    
    func testShortPassword() {

        let expectation = expectationWithDescription("Short Password")

        PasswordManager.sharedInstance.generatePassword(TestConstants.shortMasterPassword, userID: TestConstants.shortGoogleURL, length: 24) { password in
            XCTAssert(password == TestConstants.shortMasterSolution)
            expectation.fulfill()
        }


        waitForExpectationsWithTimeout(2, handler: nil)
    }

    func testLongPassword() {

        let expectation = expectationWithDescription("Long Password")

        PasswordManager.sharedInstance.generatePassword(TestConstants.longMasterPassword, userID: TestConstants.shortGoogleURL, length: 24) { password in
            XCTAssert(password == TestConstants.longMasterSolution)
            expectation.fulfill()
        }

        waitForExpectationsWithTimeout(2, handler: nil)
    }
}
