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


    // MARK: Properties

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!


    // MARK: Lifecycle

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

        passwordTextField.becomeFirstResponder()
    }


    // MARK: Actions

    @IBAction func cancelButtonPressed(sender: UIBarButtonItem) {
        
        dismissSelf()
    }


    // MARK: Helper functions

    func dismissSelf() {

        view.endEditing(true)
        presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }

    // Checks that the password is valid and saves it if so
    func attemptToSaveNewPassword() {

        if passwordTextField.text != confirmPasswordTextField.text {
            showGenericAlert("Your Passwords Don't Match!", message: nil)
        }
        else if passwordTextField.text == "" {
            showGenericAlert("You Need To Enter a Password!", message: nil)
        }
        else if let newPassword = passwordTextField.text {
            SSKeychain.setPassword(newPassword, forService: Constants.Keychain.service, account: Constants.Keychain.account)
            dismissSelf()
        }
        else {
            showGenericAlert("Unknown Error", message: "Please get in touch through the About page if this continues to happen")
        }
    }


    // MARK: Delegate functions

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
