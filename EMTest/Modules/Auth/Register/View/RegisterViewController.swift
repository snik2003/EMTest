//
//  RegisterViewController.swift
//  EMTest
//
//  Created by Сергей Никитин on 14.03.2023.
//

import UIKit

class RegisterViewController: UIViewController {

    var viewModel: RegisterViewModelDelegate!
    
    @IBOutlet weak var firstNameTextField: CustomTextField!
    @IBOutlet weak var lastNameTextField: CustomTextField!
    @IBOutlet weak var emailTextField: CustomTextField!
    
    @IBOutlet weak var signButton: CustomButton!
    @IBOutlet weak var appleButton: UIButton!
    @IBOutlet weak var googleButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func signButtonAction() {
        
        guard let firstName = firstNameTextField.text else { return }
        guard let lastName = lastNameTextField.text else { return }
        guard let email = emailTextField.text else { return }
        
        signButton.viewTouched {
            self.viewModel.checkInputData(firstName: firstName, lastName: lastName, email: email, success: { [weak self] in
                guard let self = self else { return }
                
                self.hideKeyboard()
                self.showLoading()
                AuthUserData.addUser(firstName: firstName, lastName: lastName, email: email) { [weak self] userId in
                    guard let self = self else { return }
                    guard let userId = userId else { return }
                    
                    self.hideLoading()
                    self.viewModel.setLoggedInStatus(userId)
                    self.viewModel.goToHome()
                }
                
            }, failure: { [weak self] error in
                guard let self = self else { return }
                
                self.hideKeyboard()
                self.showAttentionMessage(error.rawValue) { [weak self] in
                    guard let self = self else { return }
                    
                    switch error {
                    case .firstNameEmpty:
                        self.firstNameTextField.becomeFirstResponder()
                    case .lastNameEmpty:
                        self.lastNameTextField.becomeFirstResponder()
                    case .emailEmpty, .emailIncorrect, .emailExists:
                        self.emailTextField.becomeFirstResponder()
                    default:
                        break
                    }
                }
            })
        }
    }
    
    @IBAction func loginButtonAction() {
        viewModel.goToLogin()
    }
    
    @IBAction func appleButtonAction() {
        appleButton.viewTouched {
            
        }
    }
    
    @IBAction func googleButtonAction() {
        googleButton.viewTouched {
            
        }
    }
}

extension RegisterViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == firstNameTextField {
            lastNameTextField.becomeFirstResponder()
        } else if textField == lastNameTextField {
            emailTextField.becomeFirstResponder()
        } else if textField == emailTextField {
            signButtonAction()
        }
        
        return true
    }
}
