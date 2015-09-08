//
//  Constants.swift
//  ZeroStore
//
//  Created by Kyle Bashour on 9/3/15.
//  Copyright © 2015 Kyle Bashour. All rights reserved.
//

import Foundation

struct Constants {

    // For use in Keychain
    struct Keychain {
        static let service = "ZeroStore"
        static let account = "CurrentUser"
    }

    // For use when accessing NSUserDefaults
    struct Defaults {
        static let length = "DefaultPasswordLength"
        static let opened = "Opened"
        static let suiteName = "group.com.kylebashour.ZeroStore"
    }

    // For use when working with Storyboards in code
    struct Storyboard {
        static let tutorialPageID = "TutorialPage"
    }
}