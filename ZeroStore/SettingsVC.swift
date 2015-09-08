//
//  ViewController.swift
//  ZeroStore
//
//  Created by Kyle Bashour on 9/3/15.
//  Copyright (c) 2015 Kyle Bashour. All rights reserved.
//

import UIKit
import SSKeychain

class SettingsVC: UITableViewController {

    @IBOutlet weak var defaultLengthTextField: UITextField!

    let defaults = NSUserDefaults(suiteName: Constants.Defaults.suiteName)!

    override func viewDidLoad() {
        super.viewDidLoad()

        let defaultLength = defaults.integerForKey(Constants.Defaults.length)
        let doneBarButton = UIBarButtonItem(title: "Done", style: .Done, target: self, action: "dismissKeyboard")
        let spacing = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: self, action: nil)
        let doneBar = UIToolbar(frame: CGRectMake(0, 0, view.frame.width, 44))

        doneBar.backgroundColor = UIColor.whiteColor()
        doneBar.items = [spacing, doneBarButton]

        defaultLengthTextField.inputAccessoryView = doneBar
        defaultLengthTextField.text = "\(defaultLength)"

        clearsSelectionOnViewWillAppear = false
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        if let selectedIndex = tableView.indexPathForSelectedRow {
            tableView.deselectRowAtIndexPath(selectedIndex, animated: animated)
        }
    }

    func dismissKeyboard() {
        saveCurrentLength()
        defaultLengthTextField.resignFirstResponder()
    }

    func showAlert(title: String?, message: String?) {

        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        let tryAgainButton = UIAlertAction(title: "OK", style: .Default, handler: nil)

        alert.addAction(tryAgainButton)
        presentViewController(alert, animated: true, completion: nil)
    }

    func removeSavedPassword() {

        if SSKeychain.passwordForService(Constants.Keychain.service, account: Constants.Keychain.account) == nil {
            showAlert("You Didn't Have a Password Saved", message: nil)
        }
        else {
            let confirmation = UIAlertController(title: "Are you sure?", message: "If you remove your password from the keychain, you'll have to type your Master Password every time you generate a service password.", preferredStyle: .Alert)
            let cancelButton = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
            let confirmButton = UIAlertAction(title: "Remove", style: .Destructive) { _ in

                if SSKeychain.deletePasswordForService(Constants.Keychain.service, account: Constants.Keychain.account) {
                    self.showAlert("Successfully Removed Password", message: "Your Master Password has been removed from the keychain. You'll have to type it in manually now.")
                }
                else {
                    self.showAlert("Failed to Remove Password", message: "For some reason, Keychain isn't letting us delete the password! Please try quitting ZeroStore and trying again.")
                }
            }

            confirmation.addAction(cancelButton)
            confirmation.addAction(confirmButton)
            presentViewController(confirmation, animated: true, completion: nil)
        }
    }

    func saveCurrentLength() {

        guard let selectedLength = Int(defaultLengthTextField.text ?? "") where selectedLength <= 44 && selectedLength >= 4 else {
            showAlert("Invalid Length", message: "Please make sure the length is a number between 4 and 44")
            return
        }

        defaults.setInteger(selectedLength, forKey: Constants.Defaults.length)
        defaults.synchronize()
        defaultLengthTextField.text = "\(selectedLength)"
    }


    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        tableView.deselectRowAtIndexPath(indexPath, animated: true)

        if indexPath.section == 0 && indexPath.row == 0 {
            defaultLengthTextField.becomeFirstResponder()
        }
        if indexPath.section == 0 && indexPath.row == 2 {
            removeSavedPassword()
        }
    }

}
