//
//  GlobalColorFont.swift
//  MUNZUL
//
//  Created by Navdeep Singh on 06/03/24.
//


import Foundation
import UIKit


extension UIImage {
    static func appImage(named: String) -> UIImage? {
        return UIImage(named: named)
    }
}


struct App{
    struct F {
        static let ScreenFont0: UIFont = UIFont(name: "Roboto-Bold", size: 24) ?? UIFont.systemFont(ofSize: 2)
        static let ScreenFont1: UIFont = UIFont(name: "Roboto-Regular", size: 18) ?? UIFont.systemFont(ofSize: 1)
        static let ScreenFont2: UIFont = UIFont(name: "Roboto-Regular", size: 18) ?? UIFont.systemFont(ofSize: 18)
        static let GettingFont: UIFont = UIFont(name: "Roboto-Regular", size: 28) ?? UIFont.systemFont(ofSize: 28)
        static let GettingSortFont: UIFont = UIFont(name: "Roboto-Regular", size: 12) ?? UIFont.systemFont(ofSize: 12)

    }
    
    struct RGB {
        static func color(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> UIColor {
            return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: alpha)
        }
    }
    
    struct C {
        static let ScreenColor: UIColor = RGB.color(red: 2, green: 145, blue: 154 ,alpha: 1)
        static let BtnColor0898: UIColor = RGB.color(red: 2, green: 145, blue: 154 ,alpha: 1)
        static let txtfieldStart: UIColor = RGB.color(red: 2, green: 145, blue: 154 ,alpha: 1)
        static let txtfieldNone: UIColor = RGB.color(red: 0, green: 0, blue: 0 ,alpha: 0.2)
        static let AppBackgroundColor: UIColor = RGB.color(red: 247, green: 247, blue: 247 ,alpha: 1)
        static let AppWhiteBackground: UIColor = RGB.color(red: 255, green: 255, blue: 255 ,alpha: 1)
        static let DescriptionColor: UIColor = RGB.color(red: 0, green: 0, blue: 0 ,alpha: 0.8)
        static let GrenishColor: UIColor = RGB.color(red: 236, green: 247, blue: 248 ,alpha: 0.8)
        static let EscapeColor: UIColor = RGB.color(red: 2, green: 145, blue: 154 ,alpha: 1)
        static let YellowProfileColor: UIColor = RGB.color(red: 249, green: 188, blue: 54 ,alpha: 1)
        static let GrayProfileColor: UIColor = RGB.color(red: 149, green: 169, blue: 167 ,alpha: 1)
        static let GreenProfileColor: UIColor = RGB.color(red: 119, green: 190, blue: 81 ,alpha: 1)

        static let BtnColor0898Faid: UIColor = RGB.color(red: 2, green: 145, blue: 154 ,alpha: 0.06)
        
        static let Seperator0898Faid: UIColor = RGB.color(red: 0, green: 0, blue: 0 ,alpha: 0.50)
        

    }
    
    struct Images {
        static let onBoardingScreen0 = UIImage.appImage(named: "OnBoardingScreen1")
        static let onBoardingScreen1 = UIImage.appImage(named: "OnBoarding2")
        static let onBoardingScreen2 = UIImage.appImage(named: "OnBoardingScreen3")
        static let ProfilePic = UIImage.appImage(named: "Profile_pic")
        static let LogOUTICON = UIImage.appImage(named: "Logout_ICON")
        static let NotificationBell = UIImage.appImage(named: "Notification_ICON")
        static let Location_Image = UIImage.appImage(named: "Location_Setting")
        static let PasswrdImage = UIImage.appImage(named: "password_unlock")
        static let RectangularBar = UIImage.appImage(named: "Rectangle_1221")

        static let CallIcon = UIImage.appImage(named: "CallIcon")
        static let MessageICON = UIImage.appImage(named: "Help_Support")


    }
    
}
