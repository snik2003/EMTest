//
//  LoginViewModel.swift
//  EMTest
//
//  Created by Сергей Никитин on 14.03.2023.
//

import Foundation

protocol LoginViewModelDelegate {
    
    var coordinator: AuthCoordinator! { get }
    
    func goToHome()
    func goToLogin()
    func goToRegister()
    func backToRegister()
    
    func setLoggedInStatus(_ userId: String)
    
    func checkInputData(email: String?, password: String?,
                        success: @escaping (String) -> (Void), failure: @escaping (DataInputError) -> (Void))
}


class LoginViewModel: LoginViewModelDelegate {
    
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
    
    func backToRegister() {
        coordinator.backToRegisterPage()
    }
    
    func setLoggedInStatus(_ userId: String) {
        UserDataService().loggedInUserId = userId
    }
    
    func checkInputData(email: String?, password: String?,
                        success: @escaping (String) -> (Void), failure: @escaping (DataInputError) -> (Void)) {
        
        guard let email = email, !email.isEmpty else {
            failure(.emailEmpty)
            return
        }
        
        guard email.validateEmail() else {
            failure(.emailIncorrect)
            return
        }
        
        guard let password = password, !password.isEmpty else {
            failure(.passwordEmpty)
            return
        }
        
        AuthUserData.checkUser(withLogin: email) { status, userId in
            guard status, let userId = userId else {
                failure(.emailNotExist)
                return
            }
            
            success(userId)
        }
    }
}
