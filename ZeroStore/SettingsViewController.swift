//
//  ViewController.swift
//  ZeroStore
//
//  Created by Kyle Bashour on 9/3/15.
//  Copyright (c) 2015 Kyle Bashour. All rights reserved.
//

import UIKit
import SSKeychain

class SettingsViewController: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var defaultLengthTextField: UITextField!

    let defaults = NSUserDefaults(suiteName: Constants.Defaults.suiteName)!
    let lengthPicker = UIPickerView()
    var doneBar: UIToolbar!

    override func viewDidLoad() {
        super.viewDidLoad()

        lengthPicker.delegate = self
        lengthPicker.dataSource = self

        // create a done button that dismisses the time picker
        let doneBarButton = UIBarButtonItem(title: "Done", style: .Done, target: self, action: "dismissPicker")
        let spacing = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: self, action: nil)
        // add the button to a toolbar
        doneBar = UIToolbar(frame: CGRectMake(0, 0, view.frame.width, 44))
        doneBar.backgroundColor = UIColor.whiteColor()
        doneBar.items = [spacing, doneBarButton]

        defaultLengthTextField.inputView = lengthPicker
        defaultLengthTextField.inputAccessoryView = doneBar
        defaultLengthTextField.text = "\(defaults.integerForKey(Constants.Defaults.length))"
    }

    func dismissPicker() {
        saveCurrentLength()
        defaultLengthTextField.resignFirstResponder()
    }

    func showAlert(title: String?, message: String?) {

        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        let tryAgainButton = UIAlertAction(title: "OK", style: .Default, handler: nil)

        alert.addAction(tryAgainButton)
        presentViewController(alert, animated: true, completion: nil)
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        tableView.deselectRowAtIndexPath(indexPath, animated: true)

        if indexPath.section == 2 && indexPath.row == 0 {
            removeSavedPassword()
        }
        if indexPath.section == 1 && indexPath.row == 0 {
            defaultLengthTextField.becomeFirstResponder()
        }
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
        let selectedLength = lengthPicker.selectedRowInComponent(0) + 8
        defaults.setInteger(selectedLength, forKey: Constants.Defaults.length)
        defaults.synchronize()
        defaultLengthTextField.text = "\(selectedLength)"
        view.layoutIfNeeded()
    }

    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 64 - 7
    }

    func pickerView(pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return pickerView.frame.width
    }

    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(row + 8)"
    }

    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        saveCurrentLength()
    }
}
