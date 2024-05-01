//
//  VerifyOtpModel.swift
//  MUNZUL
//
//  Created by Navdeep on 21/03/24.
//

import Foundation

struct VerifyOtpModel: Codable {
    let status: Bool?
    let code: Int?
    let message: String?
    let token: String?
    
}
