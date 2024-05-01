//
//  BaseURLHelper.swift
//  MachineTest
//
//

import Foundation


struct NetworkUtility {
    static func baseUrl(_ urlType: BaseURLType) -> String {
        switch urlType {
        case .home:
            return ""
        case .analytics:
            return ""
        }
    }
}


enum BaseURLType {
    case home
    case analytics
}
