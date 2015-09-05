//
//  PasswordManager.swift
//  ZeroStore
//
//  Created by Kyle Bashour on 9/3/15.
//  Copyright (c) 2015 Kyle Bashour. All rights reserved.
//

import Foundation
import NAChloride

class PasswordManager {

    static let sharedInstance = PasswordManager()

    init() {
        PasswordManager.setInitialDefaultLength()
    }

    func generatePassword(masterPassword: String, userID: String, length: Int, completion: (String -> ())?) {

        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {

            let salt = ("zerostore-salt" + userID as NSString).dataUsingEncoding(NSUTF8StringEncoding)!
            let password = (masterPassword as NSString).dataUsingEncoding(NSUTF8StringEncoding)!
            let data = try! NAScrypt.scrypt(password, salt: salt, n: 16384, r: 8, p: 1, length: 64)
            let digest = userID.hmac(CryptoAlgorithm.SHA256, key: data)
            let range = Range<String.Index>(start: digest.startIndex, end: digest.startIndex.advancedBy(length ))

            // DEBUG

//          print("password used: \(masterPassword)")
//          print("userID user: \(userID)")
//          print("password generated: \(digest.substringWithRange(range))")

            completion?(digest.substringWithRange(range))
        }
    }

    class func setInitialDefaultLength() {

        let defaults = NSUserDefaults(suiteName: Constants.Defaults.suiteName)!

        if !defaults.boolForKey(Constants.Defaults.opened) {
            defaults.setBool(true, forKey: Constants.Defaults.opened)
            defaults.setInteger(24, forKey: Constants.Defaults.length)
            defaults.synchronize()
        }
    }
}
