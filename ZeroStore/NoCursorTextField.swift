//
//  NoCursorTextField.swift
//  ZeroStore
//
//  Created by Kyle Bashour on 9/3/15.
//  Copyright (c) 2015 Kyle Bashour. All rights reserved.
//

import UIKit

class NoCursorTextField: UITextField {

    override func caretRectForPosition(position: UITextPosition!) -> CGRect {
        return CGRect.zeroRect
    }

    override func selectionRectsForRange(range: UITextRange) -> [AnyObject] {
        return []
    }
}

