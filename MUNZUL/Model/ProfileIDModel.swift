//
//  ProfileIDModel.swift
//  MUNZUL
//
//  Created by Sonoma on 21/03/24.
//

import Foundation
struct Profile_JSON : Codable {
    let status : Bool?
    let code : Int?
    let message : String?
    let data : DataProfile?
    

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case code = "code"
        case message = "message"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        code = try values.decodeIfPresent(Int.self, forKey: .code)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        data = try values.decodeIfPresent(DataProfile.self, forKey: .data)
    }

}
struct DataProfile : Codable {
    let _id : String?
    let email : String?
    let about : String?
    let address : String?
    let contact : String?
    let country_code : String?
    let created_at : Int?
    let frame : Int?
    let name : String?
    let profile_pic : String?
    let role : String?
    let social_id : String?
    let listed_properties : [String]?
    let license_number : String?
    let referral_code : String?
    let newsletter_email : String?
    let updates_and_newsletter : Int?
    let aboutus : String?
    let new_email : String?
    let customerId : String?
    let stripe_account_id : String?
    let additionalinfo : String?
    let transactions : [String]?
    let company_details: CompanyDetails? // Add company_details field here
    let notifications: NotificationsModel? // Add company_details field here

    
    enum CodingKeys: String, CodingKey {

        case _id = "_id"
        case email = "email"
        case about = "about"
        case address = "address"
        case contact = "contact"
        case country_code = "country_code"
        case created_at = "created_at"
        case frame = "frame"
        case name = "name"
        case profile_pic = "profile_pic"
        case role = "role"
        case social_id = "social_id"
        case listed_properties = "listed_properties"
        case license_number = "license_number"
        case referral_code = "referral_code"
        case newsletter_email = "newsletter_email"
        case updates_and_newsletter = "updates_and_newsletter"
        case aboutus = "aboutus"
        case new_email = "new_email"
        case customerId = "customerId"
        case stripe_account_id = "stripe_account_id"
        case additionalinfo = "additionalinfo"
        case transactions = "transactions"
        case company_details = "company_details"
        case notifications = "notifications"


    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        _id = try values.decodeIfPresent(String.self, forKey: ._id)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        about = try values.decodeIfPresent(String.self, forKey: .about)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        contact = try values.decodeIfPresent(String.self, forKey: .contact)
        country_code = try values.decodeIfPresent(String.self, forKey: .country_code)
        created_at = try values.decodeIfPresent(Int.self, forKey: .created_at)
        frame = try values.decodeIfPresent(Int.self, forKey: .frame)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        profile_pic = try values.decodeIfPresent(String.self, forKey: .profile_pic)
        role = try values.decodeIfPresent(String.self, forKey: .role)
        social_id = try values.decodeIfPresent(String.self, forKey: .social_id)
        listed_properties = try values.decodeIfPresent([String].self, forKey: .listed_properties)
        license_number = try values.decodeIfPresent(String.self, forKey: .license_number)
        referral_code = try values.decodeIfPresent(String.self, forKey: .referral_code)
        newsletter_email = try values.decodeIfPresent(String.self, forKey: .newsletter_email)
        updates_and_newsletter = try values.decodeIfPresent(Int.self, forKey: .updates_and_newsletter)
        aboutus = try values.decodeIfPresent(String.self, forKey: .aboutus)
        new_email = try values.decodeIfPresent(String.self, forKey: .new_email)
        customerId = try values.decodeIfPresent(String.self, forKey: .customerId)
        stripe_account_id = try values.decodeIfPresent(String.self, forKey: .stripe_account_id)
        additionalinfo = try values.decodeIfPresent(String.self, forKey: .additionalinfo)
        transactions = try values.decodeIfPresent([String].self, forKey: .transactions)
        company_details = try values.decodeIfPresent(CompanyDetails.self, forKey: .company_details)
        notifications = try values.decodeIfPresent(NotificationsModel.self, forKey: .notifications)

    }

}

// MARK: - Notifications
struct NotificationsModel: Codable {
    let pushNotification, emailNotification: Bool

    enum CodingKeys: String, CodingKey {
        case pushNotification = "push_notification"
        case emailNotification = "email_notification"
    }
}


struct CompanyDetails: Codable {
    let _id: String?
    let userId: String?
    let address: String?
    let city: String?
    let contact: String?
    let name: String?
    let website: String?
    let zipcode: String?

    enum CodingKeys: String, CodingKey {
        case _id = "_id"
        case userId
        case address
        case city
        case contact
        case name
        case website
        case zipcode
    }
}
