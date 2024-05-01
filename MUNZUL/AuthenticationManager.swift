//
//  AuthenticationManager.swift
//  MUNZUL
//
//  Created by Navdeep Singh on 18/03/24.
//

import Foundation
import SwiftKeychainWrapper

struct AuthenticationManager {
    
    static let shared = AuthenticationManager()
    private let keychainService = KeyChainService.shared
    
    var isLoggedIn: Bool {
        return keychainService.getSavedLoginToken() != nil
    }
    
    func login(withToken token: String) {
        keychainService.saveLoginToken(token: token)
        // Update UI or perform any other necessary actions
    }
    
    func logout() {
        keychainService.deleteSavedLoginToken()
        // Update UI or perform any other necessary actions
    }
}
extension KeyChainService {
    
    func saveUserEmail(email: String) {
          _ = KeychainWrapper.standard.set(email, forKey: KeychainWrapper.Key.UserEmailLoggIN.rawValue)
      }
    
    @discardableResult
    func saveUserEmail(role: String?) -> Bool {
        guard let role = role else { return false }
        return KeychainWrapper.standard.set(
            role,
            forKey: KeychainWrapper.Key.UserEmailLoggIN.rawValue
        )
    }
    @discardableResult
    func saveUserRole(role: String?) -> Bool {
        guard let role = role else { return false }
        return KeychainWrapper.standard.set(
            role,
            forKey: KeychainWrapper.Key.SelectedRoleDATA.rawValue
        )
    }
    
    @discardableResult
    func saveUserID(userID: String?) -> Bool {
        guard let userID = userID else { return false }
        return KeychainWrapper.standard.set(
            userID,
            forKey: KeychainWrapper.Key.LogInUserID.rawValue
        )
    }
    
    func getSavedUserID() -> String? {
         return KeychainWrapper.standard.string(forKey: KeychainWrapper.Key.LogInUserID.rawValue)
     }
    
      func getSavedUserEmail() -> String? {
          return KeychainWrapper.standard.string(forKey: KeychainWrapper.Key.UserEmailLoggIN.rawValue)
      }
      
      func getSavedUserRole() -> String? {
          return KeychainWrapper.standard.string(forKey: KeychainWrapper.Key.SelectedRoleDATA.rawValue)
      }
    
    
  
    func saveLoginToken(token: String) {
        _ = KeychainWrapper.standard.set(token, forKey: KeychainWrapper.Key.loginToken.rawValue)
    }
    
    func getSavedLoginToken() -> String? {
        let token = KeychainWrapper.standard.string(forKey: KeychainWrapper.Key.loginToken.rawValue)
        print("Saved Login Token:", token ?? "No token found")
        return token
    }

    func deleteSavedLoginToken() {
        KeychainWrapper.standard.remove(forKey: KeychainWrapper.Key(rawValue: KeychainWrapper.Key.loginToken.rawValue) )
    }
}
