//
//  ProfileViewModel.swift
//  EMTest
//
//  Created by Сергей Никитин on 14.03.2023.
//

import UIKit

protocol ProfileViewModelDelegate {
    
    var coordinator: ProfileCoordinator! { get }
    
    func goToAuth()
    
    func getCurrentUser(completion: @escaping (AuthUserData?) -> Void)
    
    func getUserFullName() -> String
    
    func getUserBalance() -> Double
    
    func getUserBalanceString() -> String
    
    func updateUserPhoto(_ image: UIImage, completion: @escaping (Bool) -> Void)
}

class ProfileViewModel: ProfileViewModelDelegate {
    
    var coordinator: ProfileCoordinator!
    
    private var numberFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        return formatter
    }
    
    func goToAuth() {
        UserDataService().loggedInUserId = nil
        coordinator.goToAuth()
    }
    
    func getCurrentUser(completion: @escaping (AuthUserData?) -> Void) {
        guard let userId = UserDataService().loggedInUserId else {
            completion(nil)
            return
        }
        
        AuthUserData.getUser(withUserId: userId) { user in
            completion(user)
        }
    }
    
    func getUserFullName() -> String {
        return UserDataService().userFullName
    }
    
    func getUserBalance() -> Double {
        return UserDataService().userBalance
    }
    
    func getUserBalanceString() -> String {
        guard let value = numberFormatter.string(from: NSNumber(value: UserDataService().userBalance)) else { return "$ 0" }
        return "$ " + value
    }
    
    func updateUserPhoto(_ image: UIImage, completion: @escaping (Bool) -> Void) {
        guard let userId = UserDataService().loggedInUserId else {
            completion(false)
            return
        }
        
        AuthUserData.setUserPhoto(image, forUser: userId) { result in
            completion(result)
        }
    }
}
