//
//  DataInputError.swift
//  EMTest
//
//  Created by Сергей Никитин on 14.03.2023.
//

import Foundation

enum DataInputError: String {
    case firstNameEmpty = "Please enter First name"
    case lastNameEmpty = "Please enter Last name"
    case emailEmpty = "Please enter Email"
    case emailIncorrect = "Incorrect Email value"
    case emailExists = "User with this Email already exists"
    case emailNotExist = "User with this Email doesn't exist"
    case passwordEmpty = "Please enter Password"
    case passwordIncorrect = "Incorrect First name or Password value"
    case unknownError = "An unknown error has occurred"
    case serverError = "A server error occurred.\nRepeat the request later."
}

