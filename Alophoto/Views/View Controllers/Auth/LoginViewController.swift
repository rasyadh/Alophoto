//
//  LoginViewController.swift
//  Alophoto
//
//  Created by Rasyadh Abdul Aziz on 06/03/20.
//  Copyright © 2020 rasyadh. All rights reserved.
//

import UIKit
import SVProgressHUD

class LoginViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.accessibilityIdentifier = "loginView"
        subviewSettings()
        emailField.delegate = self
        passwordField.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        emailField.setRoundedCorner(cornerRadius: 4.0)
        passwordField.setRoundedCorner(cornerRadius: 4.0)
        loginButton.setRoundedCorner(cornerRadius: 4.0)
    }
    
    // MARK: - Functions
    private func subviewSettings() {
        titleLabel.text = Localify.get("app.name")
        emailField.placeholder = Localify.get("login.field.email")
        passwordField.placeholder = Localify.get("login.field.password")
        loginButton.setTitle(Localify.get("login.button.login").uppercased(), for: .normal)
        
        emailField.setPadding(8.0)
        passwordField.setPadding(8.0)
    }
    
    // MARK: - IBAction
    @IBAction func LoginTouchUpInside(_ sender: Any) {
        SVProgressHUD.show(withStatus: Localify.get("messages.loading.login"))
        if validateField() {
            Storify.shared.handleSuccessfullLogin(email: emailField.text!)
            
            SVProgressHUD.showSuccess(withStatus: Localify.get("messages.success.login"))
            SVProgressHUD.dismiss(withDelay: 0.75) {
                // self.managerViewController?.showHomeScreen()
            }
            self.view.endEditing(true)
        }
        SVProgressHUD.dismiss()
    }
    
    private func validateField() -> Bool {
        var errors = [String]()
        
        if emailField.text!.isEmpty {
            errors.append(Localify.get("field_validation.invalid.message.email_empty"))
        } else if !emailField.text!.isValidEmail() {
            errors.append(Localify.get("field_validation.invalid.message.email_invalid"))
        }
        
        if passwordField.text!.isEmpty {
            errors.append(Localify.get("field_validation.invalid.message.password_empty"))
        } else if passwordField.text!.count < 6 {
            errors.append(Localify.get("field_validation.invalid.message.password_length"))
        }
        
        if errors.isEmpty {
            return true
        } else {
            let message = errors.joined(separator: "\n")
            Alertify.displayAlert(
                title: Localify.get("field_validation.invalid.title"),
                message: message,
                sender: self)
            
            return false
        }
    }
}

// MARK: - TextField Delegate
extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextResponder = textField.superview?.viewWithTag(textField.tag + 1) {
            nextResponder.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
            loginButton.sendActions(for: .touchUpInside)
        }
        
        return true
    }
}
