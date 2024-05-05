//
//  SessionManager.swift
//  Chingari
//
//  Created by Guru on 04/05/24.
//

import Foundation
import SwiftUI

class SessionManager: ObservableObject {
    
    @Published var isLoggedIn: Bool = false
    
    @AppStorage("isDarkModeEnabled") var isDarkModeEnabled: Bool = false
    
    func checkLoginStatus() {
        let isLoggedIn = UserDefaults.standard.bool(forKey: UserDefaultsKey.isLoggedIn.rawValue)
        self.isLoggedIn = isLoggedIn
    }
    
    func setLoggedIn(status: Bool) {
        UserDefaults.standard.setValue(status, forKey: UserDefaultsKey.isLoggedIn.rawValue)
        self.isLoggedIn = status
    }
    
    func setUserName(name: String) {
        UserDefaults.standard.setValue(name, forKey: UserDefaultsKey.username.rawValue)
    }
    
    func getUserName() -> String? {
        return UserDefaults.standard.string(forKey: UserDefaultsKey.username.rawValue)
    }
    
    func setEmailID(email: String) {
        UserDefaults.standard.setValue(email, forKey: UserDefaultsKey.email.rawValue)
    }
    
    func getEmailID() -> String? {
        return UserDefaults.standard.string(forKey: UserDefaultsKey.email.rawValue)
    }
    
    func setPhoneNumber(number: String) {
        UserDefaults.standard.setValue(number, forKey: UserDefaultsKey.number.rawValue)
    }
    
    func getPhoneNumber() -> String? {
        return UserDefaults.standard.string(forKey: UserDefaultsKey.number.rawValue)
    }
}
