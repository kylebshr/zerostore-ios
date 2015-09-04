//
//  ChangePasswordViewController.swift
//  ZeroStore
//
//  Created by Kyle Bashour on 9/3/15.
//  Copyright © 2015 Kyle Bashour. All rights reserved.
//

import UIKit
import SSKeychain

class ChangePasswordVC: UITableViewController, UITextFieldDelegate {

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

    func showAlert(title: String?, message: String?) {

        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        let tryAgainButton = UIAlertAction(title: "Try Again", style: .Default, handler: nil)

        alert.addAction(tryAgainButton)
        presentViewController(alert, animated: true, completion: nil)
    }

    func attemptToSaveNewPassword() {

        if passwordTextField.text != confirmPasswordTextField.text {
            showAlert("Your Passwords Don't Match!", message: nil)
        }
        else if let newPassword = passwordTextField.text where newPassword != "" {
            SSKeychain.setPassword(newPassword, forService: Constants.Keychain.service, account: Constants.Keychain.account)
            dismissSelf()
        }
        else {
            showAlert("You Didn't Enter a Password!", message: nil)
        }
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        if indexPath.section == 1 && indexPath.row == 0 {
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
            attemptToSaveNewPassword()
        }
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField === passwordTextField {
            confirmPasswordTextField.becomeFirstResponder()
        }
        else if textField === confirmPasswordTextField {
            attemptToSaveNewPassword()
        }
        return true
    }
}
