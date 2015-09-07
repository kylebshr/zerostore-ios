//
//  NoCursorTextField.swift
//  ZeroStore
//
//  Created by Kyle Bashour on 9/3/15.
//  Copyright (c) 2015 Kyle Bashour. All rights reserved.
//

import UIKit

class NoPasteTextField: UITextField {

    override func canPerformAction(action: Selector, withSender sender: AnyObject?) -> Bool {
        return false
    }
}
