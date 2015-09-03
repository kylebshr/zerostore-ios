//
//  ViewController.swift
//  ZeroStore
//
//  Created by Kyle Bashour on 9/3/15.
//  Copyright (c) 2015 Kyle Bashour. All rights reserved.
//

import UIKit
import SSKeychain

class SettingsViewController: UITableViewController {

    @IBOutlet weak var serviceTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        tableView.deselectRowAtIndexPath(indexPath, animated: true)

        if indexPath.section == 2 && indexPath.row == 0 {
            if SSKeychain.deletePasswordForService(Constants.Keychain.service, account: Constants.Keychain.account) ||
                SSKeychain.passwordForService(Constants.Keychain.service, account: Constants.Keychain.account) == nil
            {
                let alert = UIAlertController(title: "Removed Password", message: "Your master password has been removed from the keychain. You'll have to type it in manually now.", preferredStyle: .Alert)
                let tryAgainButton = UIAlertAction(title: "OK", style: .Default, handler: nil)

                alert.addAction(tryAgainButton)
                presentViewController(alert, animated: true, completion: nil)
            }
            else {
                let alert = UIAlertController(title: "Failed to Remove Password", message: "For some reason, Keychain isn't letting us delete the password! Please try quitting ZeroStore and trying again.", preferredStyle: .Alert)
                let tryAgainButton = UIAlertAction(title: "OK", style: .Default, handler: nil)

                alert.addAction(tryAgainButton)
                presentViewController(alert, animated: true, completion: nil)
            }
        }
    }
}
