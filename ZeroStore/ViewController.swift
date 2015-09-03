//
//  ViewController.swift
//  ZeroStore
//
//  Created by Kyle Bashour on 9/3/15.
//  Copyright (c) 2015 Kyle Bashour. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var serviceTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func generateButtonPressed(sender: UIButton) {
        getPassword()
    }

    func getPassword() {
        passwordLabel.text = PasswordManager.sharedInstance.generatePassword(passwordTextField.text ?? "", userID: serviceTextField.text ?? "")
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField === passwordTextField {
            passwordTextField.resignFirstResponder()
        }

        return true
    }
}

