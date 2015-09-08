//
//  String+Extensions.swift
//  ZeroStore
//
//  Created by Kyle Bashour on 9/3/15.
//  Copyright (c) 2015 Kyle Bashour. All rights reserved.
//

// From http://stackoverflow.com/questions/24099520/commonhmac-in-swift
// Modified to give back a base64 string

import Foundation

extension String {

    func hmac(algorithm: CryptoAlgorithm, key: NSData) -> String {

        let str = self.cStringUsingEncoding(NSUTF8StringEncoding)
        let strLen = Int(self.lengthOfBytesUsingEncoding(NSUTF8StringEncoding))
        let digestLen = algorithm.digestLength
        let result = UnsafeMutablePointer<CUnsignedChar>.alloc(digestLen)
        let keyStr = UnsafePointer<CChar>(key.bytes)
        let keyLen = key.length

        CCHmac(algorithm.HMACAlgorithm, keyStr, keyLen, str!, strLen, result)
        let base64 = NSData(bytes: result, length: digestLen).base64EncodedStringWithOptions([])
        result.dealloc(digestLen)

        return base64
    }
}
