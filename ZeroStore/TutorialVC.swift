//
//  TutorialVC.swift
//  ZeroStore
//
//  Created by Kyle Bashour on 9/4/15.
//  Copyright © 2015 Kyle Bashour. All rights reserved.
//

import UIKit

class TutorialVC: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {


    // MARK: Properties

    weak var pageControl: UIPageControl?

    let phrases = [
        "Open Safari, then tap the arrow to open the action sheet",
        "Slide all the way to the right, and tap on \"More\"",
        "Turn on the ZeroStore action",
        "Tap on the ZeroStore Password icon to use ZeroStore in your browser"
    ]
    let notes = [
        "",
        "",
        "Note: if you don't see the ZeroStore action in the list, you may be using an incompatible browser.",
        ""
    ]


    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource = self
        delegate = self

        // Sets the initial page for the tutorial
        setViewControllers([tutorialViewControllers[0]!], direction: .Forward, animated: false, completion: nil)
    }


    // MARK: Computed/Lazy properties

    // Create and save all the view controllers in memory for less glitchy paging
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
            tutorialPage.noteLabel.text = self.notes[index]

            viewControllers[index] = tutorialPage
        }

        return viewControllers
        }()


    // MARK: Delegate functions

    func pageViewController(pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        pageControl?.currentPage = (viewControllers!.last as! TutorialPageVC).nextPage - 1
    }


    // MARK: Datasource functions

    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        return tutorialViewControllers[(viewController as! TutorialPageVC).previousPage]
    }

    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        return tutorialViewControllers[(viewController as! TutorialPageVC).nextPage]
    }
}
