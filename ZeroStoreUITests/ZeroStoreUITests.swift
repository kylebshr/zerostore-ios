//
//  ZeroStoreUITests.swift
//  ZeroStoreUITests
//
//  Created by Kyle Bashour on 9/5/15.
//  Copyright © 2015 Kyle Bashour. All rights reserved.
//

import XCTest
import SSKeychain

// Some UI tests — still new to these, they can probably be improved a lot
class ZeroStoreUITests: XCTestCase {

    let domainName = NSBundle.mainBundle().bundleIdentifier!
    let defaults = NSUserDefaults(suiteName: Constants.Defaults.suiteName)!

    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false

        XCUIApplication().launch()

        defaults.removePersistentDomainForName(Constants.Defaults.suiteName)
        SSKeychain.deletePasswordForService(Constants.Keychain.service, account: Constants.Keychain.account)
    }
    
    override func tearDown() {

        super.tearDown()
    }
    
    func testTutorial() {

        let app = XCUIApplication()
        app.tables.staticTexts["How to Use ZeroStore"].tap()
        
        let element = app.childrenMatchingType(XCUIElementType.Window).elementBoundByIndex(0)
        element.swipeLeft()
        element.swipeLeft()
        element.swipeLeft()

        app.navigationBars["Tutorial"].buttons["Stop"].tap()
    }

    func testPasswordLength() {
        
        let app = XCUIApplication()
        let tablesQuery = app.tables
        tablesQuery.staticTexts["Password Length"].tap()
        
        let deleteKey = app.keys["Delete"]
        deleteKey.doubleTap()
        
        let textField = tablesQuery.cells.containingType(.StaticText, identifier:"Password Length").childrenMatchingType(.TextField).element
        textField.typeText("3")

        let doneButton = app.toolbars.buttons["Done"]
        doneButton.tap()
        
        let okButton = app.alerts["Invalid Length"].collectionViews.buttons["OK"]
        okButton.tap()
        deleteKey.doubleTap()
        textField.typeText("55")
        doneButton.tap()
        okButton.tap()
        deleteKey.doubleTap()
        textField.typeText("24")
        doneButton.tap()
    }

    func testSettingMasterPassword() {

        
    }
}
