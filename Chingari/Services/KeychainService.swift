//
//  KeychainService.swift
//  Chingari
//
//  Created by Guru on 04/05/24.
//

import Foundation
import Security

enum KeychainError: Error {
    case dataConversionError
    case keychainError(status: Int)
}

struct KeychainService {
    
    static func save(key: String, data: String) throws {
        guard let data = data.data(using: .utf8) else {
            throw KeychainError.dataConversionError
        }
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecValueData as String: data
        ]
        
        let status = SecItemAdd(query as CFDictionary, nil)
        guard status == errSecSuccess else {
            throw KeychainError.keychainError(status: Int(status))
        }
    }

    static func load(key: String) throws -> String {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecReturnData as String: true,
        ]
        
        var dataTypeRef: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
        
        guard status == errSecSuccess, let data = dataTypeRef as? Data else {
            throw KeychainError.keychainError(status: Int(status))
        }

        guard let storedData = String(data: data, encoding: .utf8) else {
            throw KeychainError.dataConversionError
        }
        
        return storedData
    }

}
