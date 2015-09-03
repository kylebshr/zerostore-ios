//
//  ChangePasswordViewController.swift
//  ZeroStore
//
//  Created by Kyle Bashour on 9/3/15.
//  Copyright © 2015 Kyle Bashour. All rights reserved.
//

import UIKit
import SSKeychain

class ChangePasswordViewController: UITableViewController {

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

        passwordTextField.becomeFirstResponder()
    }

    @IBAction func cancelButtonPressed(sender: UIBarButtonItem) {
        dismissSelf()
    }

    func dismissSelf() {
        view.endEditing(true)
        presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }

    func showPasswordsDontMatch() {

        let alert = UIAlertController(title: "Your Passwords Don't Match!", message: "Or maybe you didn't even type one in?", preferredStyle: .Alert)
        let tryAgainButton = UIAlertAction(title: "Try Again", style: .Default, handler: nil)

        alert.addAction(tryAgainButton)
        presentViewController(alert, animated: true, completion: nil)
    }

    func attemptToSaveNewPassword() {
        if let newPassword = passwordTextField.text where passwordTextField.text == confirmPasswordTextField.text && newPassword != "" {
            SSKeychain.setPassword(newPassword, forService: Constants.Keychain.service, account: Constants.Keychain.account)
            dismissSelf()
        }
        else {
            showPasswordsDontMatch()
        }
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        if indexPath.section == 1 && indexPath.row == 0 {
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
            attemptToSaveNewPassword()
        }
    }
}
