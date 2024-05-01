//
//  RegistrationModel.swift
//  MUNZUL
//
//  Created by Navdeep Singh on 15/03/24.
//

import Foundation

// MARK: - RegistrationModel
struct RegistrationModel: Codable {
    let status: Bool?
    let code: Int?
    let message: String?
    let data: DataClass?
}

// MARK: - DataClass
struct DataClass: Codable {
    let id, email: String?
    let v: Int?
    let about, address, appVersion, contact: String?
    let countryCode: String?
    let createdAt: Int?
    let customerID, deviceModel, deviceToken, deviceType: String?
    let emailVerified: Bool?
    let frame: Int?
    let isBlocked, isOnline: Bool?
    let location: Location?
    let loginType, name, newEmail, newsletterEmail: String?
    let profilePic, referralCode, role, socialID: String?
    let socketID, stripeAccountID: String?
    let updatedAt, updatesAndNewsletter: Int?
    let xToken: [String]?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case email
        case v = "__v"
        case about, address
        case appVersion = "app_version"
        case contact
        case countryCode = "country_code"
        case createdAt = "created_at"
        case customerID = "customerId"
        case deviceModel = "device_model"
        case deviceToken = "device_token"
        case deviceType = "device_type"
        case emailVerified = "email_verified"
        case frame, isBlocked, isOnline, location
        case loginType = "login_type"
        case name
        case newEmail = "new_email"
        case newsletterEmail = "newsletter_email"
        case profilePic = "profile_pic"
        case referralCode = "referral_code"
        case role
        case socialID = "social_id"
        case socketID = "socketId"
        case stripeAccountID = "stripe_account_id"
        case updatedAt = "updated_at"
        case updatesAndNewsletter = "updates_and_newsletter"
        case xToken = "x_token"
    }
}

// MARK: - Location
struct Location: Codable {
    let type: String?
    let coordinates: [Double]?
}
