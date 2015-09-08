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

    func attemptToSaveNewPassword() {

        if passwordTextField.text != confirmPasswordTextField.text {
            showGenericAlert("Your Passwords Don't Match!", message: nil)
        }
        else if let newPassword = passwordTextField.text where newPassword != "" {
            SSKeychain.setPassword(newPassword, forService: Constants.Keychain.service, account: Constants.Keychain.account)
            dismissSelf()
        }
        else {
            showGenericAlert("You Didn't Enter a Password!", message: nil)
        }
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        tableView.deselectRowAtIndexPath(indexPath, animated: true)

        if indexPath.section == 1 && indexPath.row == 0 {
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
