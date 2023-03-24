//
//  LoginViewController.swift
//  EMTest
//
//  Created by Сергей Никитин on 14.03.2023.
//

import UIKit

class LoginViewController: UIViewController {

    var viewModel : LoginViewModelDelegate!
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var emailTextField: CustomTextField!
    @IBOutlet weak var passwordTextField: CustomTextField!
    
    @IBOutlet weak var loginButton: CustomButton!
    @IBOutlet weak var visibleButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func backButtonAction() {
        backButton.viewTouched { [weak self] in
            guard let self = self else { return }
            self.viewModel.backToRegister()
        }
    }
    
    @IBAction func visibleButtonAction() {
        passwordTextField.isSecureTextEntry = !passwordTextField.isSecureTextEntry
        
        let image = passwordTextField.isSecureTextEntry ? UIImage(named: "non-visible") : UIImage(named: "visible")
        visibleButton.setImage(image, for: .normal)
    }
    
    @IBAction func loginButtonAction() {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        loginButton.viewTouched {
            self.viewModel.checkInputData(email: email, password: password, success: { [weak self] userId in
                guard let self = self else { return }
                
                self.hideKeyboard()
                self.viewModel.setLoggedInStatus(userId)
                self.viewModel.goToHome()
                
            }, failure: { [weak self] error in
                guard let self = self else { return }
                
                self.hideKeyboard()
                self.showAttentionMessage(error.rawValue) { [weak self] in
                    guard let self = self else { return }
                    
                    switch error {
                    case .emailEmpty, .emailIncorrect, .emailNotExist:
                        self.emailTextField.becomeFirstResponder()
                    case .passwordEmpty:
                        self.passwordTextField.becomeFirstResponder()
                    default:
                        break
                    }
                }
            })
        }
    }
}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            loginButtonAction()
        }
        
        return true
    }
}

