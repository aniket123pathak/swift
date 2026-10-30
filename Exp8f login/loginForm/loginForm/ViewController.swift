//
//  ViewController.swift
//  loginForm
//
//  Created by Mac Lab 25 on 16/10/26.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func forgotUsernameTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "ForgottenUsernameOrPassword", sender: sender)
    }
    
    @IBAction func forgotPasseordTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "ForgottenUsernameOrPassword", sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "LoginSegue" {
                segue.destination.navigationItem.title = usernameTextField.text
            } else if segue.identifier == "ForgottenUsernameOrPassword" {
                if let tappedButton = sender as? UIButton {
                    if tappedButton.titleLabel?.text == "Forgot Username" {
                        segue.destination.navigationItem.title = "Forgot Username"
                    } else if tappedButton.titleLabel?.text == "Forgot Password" {
                        segue.destination.navigationItem.title = "Forgot Password"
                    }
                }
            }
        }
}

