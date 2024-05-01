//
//  KeyChainWrapper.swift
//  classic App
//
//  Created by Apple on 06/04/21.
//  Copyright © 2021 Zoptal Mac Mini. All rights reserved.
//

import UIKit
import Foundation
import SwiftKeychainWrapper

final class KeyChainService {
   
    static let shared = KeyChainService()
    
    var loginToken: String? {
           return KeychainWrapper
               .standard
               .string(forKey: .loginToken)
       }
    func deleteSavedDeviceToken() {
          KeychainWrapper.standard.remove(forKey: .loginToken)
      }
    
    var appleFirstName: String? {
        return KeychainWrapper
            .standard
            .string(forKey: .appApplefName)
    }
    
    var appleEmail: String? {
        return KeychainWrapper
            .standard
            .string(forKey: .appAppleEmail)
    }
    
    var appleId: String? {
        return KeychainWrapper
            .standard
            .string(forKey: .appAppleId)
    }
    var appleLastName: String? {
        return KeychainWrapper
            .standard
            .string(forKey: .appApplelName)
    }
    
    var deviceToken: String? {
        return KeychainWrapper
            .standard
            .string(forKey: .deviceToken)
    }
    
    @discardableResult
      func saveLoginToken(token: String?) -> Bool {
          guard let token = token else { return false }
          return KeychainWrapper.standard.set(
              token,
              forKey: KeychainWrapper.Key.loginToken.rawValue
          )
      }
    
    @discardableResult
    func saveAppleId(id: String?) -> Bool {
        guard let id = id else {return false}
        return KeychainWrapper.standard.set(
            id,
            forKey: KeychainWrapper.Key.appAppleId.rawValue
        )
    }
    
    @discardableResult
    func saveAppleFirstName(fName: String?) -> Bool {
        guard let fName = fName else {return false}
        return KeychainWrapper.standard.set(
            fName,
            forKey: KeychainWrapper.Key.appApplefName.rawValue
        )
    }
    
    @discardableResult
    func saveAppleLastName(lName: String?) -> Bool {
        guard let lName = lName else {return false}
        return KeychainWrapper.standard.set(
            lName,
            forKey: KeychainWrapper.Key.appApplelName.rawValue
        )
    }
    
    @discardableResult
    func saveAppleEmail(email: String?) -> Bool {
        guard let email = email else {return false}
        return KeychainWrapper.standard.set(
            email,
            forKey: KeychainWrapper.Key.appAppleEmail.rawValue
        )
    }
    
    @discardableResult
    func saveDeviceToken(token: String?) -> Bool {
        guard let token = token else {return false}
        return KeychainWrapper.standard.set(
            token,
            forKey: KeychainWrapper.Key.deviceToken.rawValue
        )
    }
    
  
      
    func deleteSavedAppleUserInfo(){
        KeychainWrapper.standard.remove(forKey: .appAppleEmail)
        KeychainWrapper.standard.remove(forKey: .appAppleId)
        KeychainWrapper.standard.remove(forKey: .appApplefName)
        KeychainWrapper.standard.remove(forKey: .appApplelName)
        KeychainWrapper.standard.remove(forKey: .deviceToken)
    }

}

// MARK: - KeychainWrapper + Extensions
extension KeychainWrapper.Key {
    static let appAppleEmail: KeychainWrapper.Key = "User_Email"
    static let appAppleId:KeychainWrapper.Key = "User_AppleID"
    static let appApplefName:KeychainWrapper.Key = "User_FirstName"
    static let appApplelName:KeychainWrapper.Key = "User_LastName"
    static let deviceToken:KeychainWrapper.Key = "device_token"
    static let loginToken: KeychainWrapper.Key = "User_LoginToken"
    static let UserEmailLoggIN: KeychainWrapper.Key = "User_Email"
    static let SelectedRoleDATA: KeychainWrapper.Key = "User_Role"
    static let LogInUserID: KeychainWrapper.Key = "User_ID"


}
