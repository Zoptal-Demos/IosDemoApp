//
//  Localization.swift
//  MUNZUL
//
//  Created by Navdeep Singh on 06/03/24.
//

import Foundation
import UIKit


struct Localization {
    static let ScreenTxt0 = "Welcome to MUNZUL"
    static let ScreenTxt1 = "Explore, Buy, Rent"
    static let ScreenTxt2 = "Your Journey Begins"
    static let empty = ""
    
    static let GettingStarted = "Let’s Get Started!"
    static let GettingSortLbl = "Sign In your account to quickly get started"
    static let GettingSortSinUPLbl = "Sign Up your account to quickly get started"

    static let LblAlredy = "Already have an account?"
    static let LblNotAlredy = "Don’t have an account?"
    static let SignIn = "SignIn"
    static let SignUp = "SignUp"
    static let Sendotp = "Send OTP"
    static let Submit = "Submit"
    static let Next = "Next"
    static let Update = "Update"

    static let Set_Password = "Set Password"

//    static let SignUp = "SignUp"


    static let LblTxt0 = "Your Home, Your Way"
    static let LblTxt1 = "Everything real estate, simplified."
    static let LblTxt2 = "Sign up to find your perfect property.\nLet's begin!"

    
    //Filetr Screen
    
    
    
    
    static let FilterHeadTitle = "Filters"
    static let Property_LabelTitle = "Property Sqft"
    static let Property_2LabelTitle = "Lot Size (Sqft)"
    static let Property_3LabelTitle = "Year Built"
    static let Property_4LabelTitle = "HOA Fee"

    static let MinimunTitle = "Min"
    static let maximunTitle = "Max"
    static let HOA_FeeTitle = "HOA Fee"
    static let Additional_Title = "Additional Features"
    static let Property_Title = "Property Type"
    static let Select_ForSaleTitle = "For Sale"
    static let Home_typeTitle = "Home Type"
    static let Price_range_title = "Price Range"
    static let DiscoverSearchTitle = "Enter city or Zip code"
    static let MessagesSearchTitle = "Search here..."

    
    
    


    static func localizedString(_ key: String) -> String {
        return NSLocalizedString(key, comment: "")
    }
}
extension UIView {
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let maskPath = UIBezierPath(
            roundedRect: bounds,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        let maskLayer = CAShapeLayer()
        maskLayer.path = maskPath.cgPath
        layer.mask = maskLayer
    }
}
