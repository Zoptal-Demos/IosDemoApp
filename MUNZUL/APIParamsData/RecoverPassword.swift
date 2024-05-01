//
//  RecoverPassword.swift
//  MUNZUL
//
//  Created by Navdeep Singh on 18/03/24.
//

import Foundation

struct RecoverPasswordAPIData: APIData {
    var parameterEncoding: ParameterEncoding = .json
    var requestMethod: RequestMethod = .post
    var relativeURL: String = UniformResourceLocator.VerifyAndChangeURL
    var headers: [String: String]? = [
        "accept": "application/json",
        "Content-Type": "application/json"
    ]
    
    let password: String
    let token: String
  
    func params() -> [String: Any] {
           return [
            "password": password,
            "token": token
        ]
    }
}

