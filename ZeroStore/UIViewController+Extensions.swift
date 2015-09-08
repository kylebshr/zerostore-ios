//
//  UIViewController+Extensions.swift
//  ZeroStore
//
//  Created by Kyle Bashour on 9/8/15.
//  Copyright © 2015 Kyle Bashour. All rights reserved.
//

import UIKit

extension UIViewController {

    func showGenericAlert(title: String?, message: String?) {

        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        let tryAgainButton = UIAlertAction(title: "OK", style: .Default, handler: nil)

        alert.addAction(tryAgainButton)
        presentViewController(alert, animated: true, completion: nil)
    }
}