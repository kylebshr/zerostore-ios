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
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

       // navigationController?.navigationBar.shadowImage = UIImage()
       // navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
    }

    @IBAction func doneButtonPressed(sender: UIBarButtonItem) {
        presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let destination = segue.destinationViewController as? TutorialVC {
            destination.pageControl = pageControl
        }
    }
}
