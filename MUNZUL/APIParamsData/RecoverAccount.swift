//
//  RecoverPassword.swift
//  MUNZUL
//
//  Created by Navdeep Singh on 15/03/24.
//

import Foundation

struct RecoverAccountAPIData: APIData {
    var parameterEncoding: ParameterEncoding = .json
    var requestMethod: RequestMethod = .post
    var relativeURL: String = UniformResourceLocator.RecoverAccountURL
    var headers: [String: String]? = [
        "accept": "application/json",
        "Content-Type": "application/json"
    ]
    
    let email: String
    
    func params() -> [String: Any] {
        return ["email": email]
    }
}

struct RecoverModel: Codable {
    let status: Bool?
    let code: Int?
    let message: String?
}
