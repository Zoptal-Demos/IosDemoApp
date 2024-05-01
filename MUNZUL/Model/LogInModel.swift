//
//  LogInModel.swift
//  MUNZUL
//
//  Created by Navdeep Singh on 15/03/24.
//

import Foundation

// MARK: - LogInModel
struct LogInModel: Codable {
    let status: Bool?
    let code: Int?
    let message, token: String?
    let info: Info?
}

// MARK: - Info
struct Info: Codable {
    let id, email: String?
    let emailVerified, isBlocked: Bool?
    let name, profilePic, role: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case email
        case emailVerified = "email_verified"
        case isBlocked, name
        case profilePic = "profile_pic"
        case role
    }
}
