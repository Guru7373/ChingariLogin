//
//  LoginViewModel.swift
//  Chingari
//
//  Created by Guru on 04/05/24.
//

import Foundation
import Combine

class LoginViewModel: ObservableObject {
    
    @Published var email: String = ""
    @Published var phoneNumber: String = ""
    @Published var password: String = ""
    @Published var isLoggedIn: Bool = false
    @Published var userExists: Bool?
    @Published var passwordMatched: Bool?
            
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
    
    var isAllFieldsValid: AnyPublisher<Bool, Never> {
        if !(phoneNumber.isEmpty) {
            isPhoneNumberValid
        } else {
            Publishers.CombineLatest(isEmailValid, isPasswordValid)
                .map { $0 && $1 }
                .eraseToAnyPublisher()
        }
    }
    
    func login(sessionManager: SessionManager) {
        var storedData: String?
        if !(email.isEmpty) {
            storedData = try? KeychainService.load(key: "\(email)")
        } else if !(phoneNumber.isEmpty) {
            storedData = try? KeychainService.load(key: "\(phoneNumber)")
        }
        
        guard let storedData = storedData else {
            userExists = false
            print("user with email or phone number not found")
            return
        }

        if let data = storedData.data(using: .utf8),
           let json = try? JSONSerialization.jsonObject(with: data) as? [String:String] {
            userExists = true
            if !(phoneNumber.isEmpty) {
                print("Login successful")
                setUserDetails(data: json, sessionManager: sessionManager)
                isLoggedIn = true
            } else {
                let storedPassword = json["password"]
                if password == storedPassword {
                    print("Login successful")
                    setUserDetails(data: json, sessionManager: sessionManager)
                    isLoggedIn = true
                    passwordMatched = true
                } else {
                    passwordMatched = false
                    print("Invalid email or password")
                }
            }
        }
    }
    
    func setUserDetails(data: [String:String], sessionManager: SessionManager) {
        sessionManager.setEmailID(email: data["email"] ?? "")
        sessionManager.setUserName(name: data["name"] ?? "")
        sessionManager.setPhoneNumber(number: data["phoneNumber"] ?? "")
    }
}
