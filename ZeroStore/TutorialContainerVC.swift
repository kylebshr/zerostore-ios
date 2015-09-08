//
//  TutorialContainerVC.swift
//  ZeroStore
//
//  Created by Kyle Bashour on 9/4/15.
//  Copyright © 2015 Kyle Bashour. All rights reserved.
//

import UIKit

class TutorialContainerVC: UIViewController {

    @IBOutlet weak var pageControl: UIPageControl!

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let destination = segue.destinationViewController as? TutorialVC {
            destination.pageControl = pageControl
        }
    }
}
