//
//  TutorialVC.swift
//  ZeroStore
//
//  Created by Kyle Bashour on 9/4/15.
//  Copyright © 2015 Kyle Bashour. All rights reserved.
//

import UIKit

class TutorialVC: UIPageViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource = self

        setViewControllers([storyboard!.instantiateViewControllerWithIdentifier(Constants.Storyboard.tutorialPageID)], direction: .Forward, animated: false, completion: nil)
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)

        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}

extension TutorialVC: UIPageViewControllerDataSource {

    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        return storyboard?.instantiateViewControllerWithIdentifier(Constants.Storyboard.tutorialPageID)
    }

    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        return storyboard?.instantiateViewControllerWithIdentifier(Constants.Storyboard.tutorialPageID)
    }
}
