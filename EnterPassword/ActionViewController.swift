//
//  ActionViewController.swift
//  EnterPassword
//
//  Created by Kyle Bashour on 9/3/15.
//  Copyright © 2015 Kyle Bashour. All rights reserved.
//

import UIKit
import MobileCoreServices
import LocalAuthentication
import SSKeychain

class ActionViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var masterPasswordTextField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    var domain: String?
    let defaults = NSUserDefaults(suiteName: Constants.Defaults.suiteName)!

    override func viewDidLoad() {
        super.viewDidLoad()

        if let
            item: AnyObject = extensionContext?.inputItems.first,
            itemProvider = item.attachments??.first as? NSItemProvider
            where itemProvider.hasItemConformingToTypeIdentifier(kUTTypeURL as String)
        {
            itemProvider.loadItemForTypeIdentifier(kUTTypeURL as String, options: nil) { url, error in
                if let url = url as? NSURL, domain = url.host {
                    let components = domain.componentsSeparatedByString(".")
                    if components.count >= 2 {
                        self.domain = ".".join(components[components.count - 2..<components.count])
                    }
                }
            }
        }
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

        authenticateWithTouchID()
    }

    @IBAction func copyButtonPressed(sender: UIButton) {
        generatePassword(nil)
    }

    @IBAction func cancelButtonPressed(sender: AnyObject) {
        extensionContext!.completeRequestReturningItems(extensionContext!.inputItems, completionHandler: nil)
    }

    func authenticateWithTouchID() {

        let context = LAContext()

        let reason = "Authenticate with TouchID to copy the ZeroStore password to your clipboard"

        if context.canEvaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, error: nil),
            let password = getPasswordFromKeychain()
        {
            context.evaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, error in
                if success {
                    NSOperationQueue.mainQueue().addOperationWithBlock { _ in
                        self.generatePassword(password)
                    }
                }
                else if let code = error?.code where code == LAError.UserCancel.rawValue {
                    NSOperationQueue.mainQueue().addOperationWithBlock { _ in
                        self.masterPasswordTextField.becomeFirstResponder()
                    }
                }
            }
        }
        else {
            masterPasswordTextField.becomeFirstResponder()
        }
    }

    func getPasswordFromKeychain() -> String? {
        let password = SSKeychain.passwordForService(Constants.Keychain.service, account: Constants.Keychain.account)
        return password
    }

    func generatePassword(genPassword: String?) {

        activityIndicator.startAnimating()

        var masterPassword: String!
        var masterDomain: String!

        if let genPassword = genPassword ?? masterPasswordTextField.text where masterPassword != "" {
            masterPassword = genPassword
        }
        else {
            showAlert("Failed to Generate Password", message: "Please enter your master password")
            activityIndicator.stopAnimating()
            return
        }

        if let domain = domain {
            masterDomain = domain
        }
        else {

            showAlert("Failed to Generate Password", message: "We were unable to fetch the service name. Please make sure you're using a compatible brower.")
            activityIndicator.stopAnimating()
            return
        }

        let password = PasswordManager.sharedInstance.generatePassword(masterPassword, userID: masterDomain, length: defaults.integerForKey(Constants.Defaults.length))
        UIPasteboard.generalPasteboard().string = password

        extensionContext!.completeRequestReturningItems(extensionContext!.inputItems, completionHandler: nil)
    }

    func showAlert(title: String, message: String) {

        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)

        let closeButton = UIAlertAction(title: "Cancel", style: .Cancel) { _ in
            self.extensionContext!.completeRequestReturningItems(self.extensionContext!.inputItems, completionHandler: nil)
        }
        let tryAgainButton = UIAlertAction(title: "Try Again", style: .Default) { _ in
            self.masterPasswordTextField.becomeFirstResponder()
        }

        alert.addAction(closeButton)
        alert.addAction(tryAgainButton)

        presentViewController(alert, animated: true, completion: nil)
    }

    override func supportedInterfaceOrientations() -> Int {
        return Int(UIInterfaceOrientationMask.Portrait.rawValue)
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {

        generatePassword(nil)
        return true
    }
}
