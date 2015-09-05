//
//  TutorialContainerVC.swift
//  ZeroStore
//
//  Created by Kyle Bashour on 9/4/15.
//  Copyright © 2015 Kyle Bashour. All rights reserved.
//

import UIKit

class TutorialContainerVC: UIViewController {

    @IBAction func doneButtonPressed(sender: UIButton) {
        presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }

}
