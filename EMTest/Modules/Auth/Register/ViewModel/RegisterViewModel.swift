//
//  RegisterViewModel.swift
//  EMTest
//
//  Created by Сергей Никитин on 14.03.2023.
//

import Foundation

protocol RegisterViewModelDelegate {
    
    var coordinator: AuthCoordinator! { get }
    
    func goToHome()
    func goToLogin()
    func goToRegister()
    
    func setLoggedInStatus(_ userId: String)
    
    func checkInputData(firstName: String?, lastName: String?, email: String?,
                        success: @escaping () -> (Void), failure: @escaping (DataInputError) -> (Void))
}

class RegisterViewModel: RegisterViewModelDelegate {
    
    var coordinator: AuthCoordinator!
    
    func goToLogin() {
        coordinator.goToLoginPage()
    }
    
    func goToRegister() {
        coordinator.goToRegisterPage()
    }
    
    func goToHome() {
        coordinator.goToHome()
    }
    
    func setLoggedInStatus(_ userId: String) {
        UserDataService().loggedInUserId = userId
    }
    
    func checkInputData(firstName: String?, lastName: String?, email: String?,
                        success: @escaping () -> (Void), failure: @escaping (DataInputError) -> (Void)) {
        
        guard let firstName = firstName, !firstName.isEmpty else {
            failure(.firstNameEmpty)
            return
        }
        
        guard let lastName = lastName, !lastName.isEmpty else {
            failure(.lastNameEmpty)
            return
        }
        
        guard let email = email, !email.isEmpty else {
            failure(.emailEmpty)
            return
        }
        
        guard email.validateEmail() else {
            failure(.emailIncorrect)
            return
        }
        
        AuthUserData.checkUser(withLogin: email) { status, _ in
            status ? failure(.emailExists) : success()
        }
    }
}
