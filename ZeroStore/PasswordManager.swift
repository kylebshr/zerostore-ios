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

    func generatePassword(masterPassword: String, userID: String, length: Int = 24) -> String {

        let salt = ("zerostore-salt" + userID as NSString).dataUsingEncoding(NSUTF8StringEncoding)!
        let password = (masterPassword as NSString).dataUsingEncoding(NSUTF8StringEncoding)!
        let data = try! NAScrypt.scrypt(password, salt: salt, n: 16384, r: 8, p: 1, length: 64)
        let digest = userID.hmac(CryptoAlgorithm.SHA256, key: data)
        let range = Range<String.Index>(start: digest.startIndex, end: digest.startIndex.advancedBy(length))

        return digest.substringWithRange(range)
    }
}