//
//  RecoverPasswordModel.swift
//  MUNZUL
//
//  Created by Sonoma on 26/03/24.
//

import Foundation
struct RecoverPasswordModel: Codable {
    let status: Bool?
    let code: Int?
    let message: String?
}
