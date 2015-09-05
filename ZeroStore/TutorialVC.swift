//
//  TutorialVC.swift
//  ZeroStore
//
//  Created by Kyle Bashour on 9/4/15.
//  Copyright © 2015 Kyle Bashour. All rights reserved.
//

import UIKit

class TutorialVC: UIPageViewController {

    weak var pageControl: UIPageControl?

    let phrases = [
        "Open Safari, then tap the arrow to open the action sheet",
        "Slide all the way to the right, and tap on \"More\"",
        "Turn on the ZeroStore action",
        "Tap on the ZeroStore Password icon to use ZeroStore in your browser"
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource = self
        delegate = self

        setViewControllers([tutorialViewControllers[0]!], direction: .Forward, animated: false, completion: nil)
    }

    lazy var tutorialViewControllers: [Int: TutorialPageVC] = {

        var viewControllers = [Int: TutorialPageVC]()

        for (index, phrase) in self.phrases.enumerate() {

            let image = UIImage(named: "Tutorial\(index)")
            let tutorialPage = self.storyboard!.instantiateViewControllerWithIdentifier(Constants.Storyboard.tutorialPageID) as! TutorialPageVC

            let _ = tutorialPage.view

            tutorialPage.nextPage = index + 1
            tutorialPage.previousPage = index - 1
            tutorialPage.imageView.image = image
            tutorialPage.label.text = phrase

            viewControllers[index] = tutorialPage
        }

        return viewControllers
        }()
}

extension TutorialVC: UIPageViewControllerDataSource {

    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        return tutorialViewControllers[(viewController as! TutorialPageVC).previousPage]
    }

    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        return tutorialViewControllers[(viewController as! TutorialPageVC).nextPage]
    }
}

extension TutorialVC: UIPageViewControllerDelegate {

    func pageViewController(pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        pageControl?.currentPage = (viewControllers!.last as! TutorialPageVC).nextPage - 1
    }
}
