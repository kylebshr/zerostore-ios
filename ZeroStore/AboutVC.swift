//
//  AboutVC.swift
//  ZeroStore
//
//  Created by Kyle Bashour on 9/7/15.
//  Copyright © 2015 Kyle Bashour. All rights reserved.
//

import UIKit

class AboutVC: UITableViewController {


    // MARK: Properties

    @IBOutlet weak var twitterLinkLabel: UILabel!
    @IBOutlet weak var versionLabel: UILabel!

    let websiteURL = NSURL(string: "http://kylebashour.com")!
    let twitterURL = NSURL(string: "twitter://user?screen_name=kylebshr")!
    let twitterWebsiteURL = NSURL(string: "http://twitter.com/kylebshr")!


    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setVersionNumber()
    }


    // MARK: Actions

    @IBAction func dismissButtonPressed(sender: UIBarButtonItem) {
        presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }


    // MARK: Helper functions

    // Sets the version from the bundle
    func setVersionNumber() {

        if let
            versionObject = NSBundle.mainBundle().infoDictionary?["CFBundleShortVersionString"],
            versionString = versionObject as? String,
            buildObject = NSBundle.mainBundle().infoDictionary?["CFBundleVersion"],
            buildString = buildObject as? String
        {
            versionLabel.text = "\(versionString) build \(buildString)"
        }
    }


    // MARK: Delefate funtions

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        tableView.deselectRowAtIndexPath(indexPath, animated: true)

        if indexPath.section == 1 {
            // open my website
            if indexPath.row == 0 {
                UIApplication.sharedApplication().openURL(websiteURL)
            }
            // try to open Twitter.app, else open in browser
            else if indexPath.row == 1 {
                if !UIApplication.sharedApplication().openURL(twitterURL) {
                    UIApplication.sharedApplication().openURL(twitterWebsiteURL)
                }
            }

        }
    }
}
