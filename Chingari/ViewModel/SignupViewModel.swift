//
//  SignupViewModel.swift
//  Chingari
//
//  Created by Guru on 04/05/24.
//

import Foundation
import Combine

class SignUpViewModel: ObservableObject {
    
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var phoneNumber: String = ""
    @Published var isSignedUp: Bool = false
    @Published var userAlreadyExists: Bool = false
    
    // Validation Publishers
    var isNameValid: AnyPublisher<Bool, Never> {
        $name
            .map { !$0.isEmpty }
            .eraseToAnyPublisher()
    }
    
    var isEmailValid: AnyPublisher<Bool, Never> {
        $email
            .map { $0.isValidEmail() }
            .eraseToAnyPublisher()
    }
    
    var isPasswordValid: AnyPublisher<Bool, Never> {
        $password
            .map { $0.count >= 8 }
            .eraseToAnyPublisher()
    }
    
    var isPhoneNumberValid: AnyPublisher<Bool, Never> {
        $phoneNumber
            .map { $0.count >= 10 }
            .eraseToAnyPublisher()
    }
    
    // Combine all validation publishers
    var isAllFieldsValid: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest4(isNameValid, isEmailValid, isPasswordValid, isPhoneNumberValid)
            .map { $0 && $1 && $2 && $3 }
            .eraseToAnyPublisher()
    }
    
    /// Sign up with user provided details and store in keychain
    func signUp() {
        do {
            let signupData = [
                "name" : name,
                "password" : password,
                "phoneNumber" : phoneNumber,
                "email" : email
            ]
            let data = try JSONSerialization.data(withJSONObject: signupData)
            if let escapedJSON = String(data: data, encoding: .utf8) {
                try KeychainService.save(key: "\(email)", data: escapedJSON)
                try KeychainService.save(key: "\(phoneNumber)", data: escapedJSON)
                isSignedUp = true
            }
        } catch {
            print("Error storing sign-up data in Keychain: \(error.localizedDescription)")
            if let error = error as? KeychainError {
                switch error {
                case .keychainError(let status):
                    if (status == -25299) {
                        userAlreadyExists = true
                    } else {
                        isSignedUp = false
                    }
                default:
                    isSignedUp = false
                }
            }
        }
    }
}
