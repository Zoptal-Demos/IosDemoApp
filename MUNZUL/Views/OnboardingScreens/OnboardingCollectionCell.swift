//
//  OnboardingCollectionCell.swift
//  MUNZUL
//
//  Created by Navdeep Singh on 06/03/24.
//

import UIKit
//import SnapKit

class OnboardingCollectionCell: UICollectionViewCell {
    @IBOutlet weak var LblText2: UILabel!
    @IBOutlet weak var LblText1: UILabel!
    @IBOutlet weak var OnBoardingImages: UIImageView!
    
    @IBOutlet weak var heightdynamic: NSLayoutConstraint!
    
    func configureCell() {
        let deviceModel = UIDevice.current.model
        let isiPhoneXOrLater = isiPhoneXOrLaterModel()

        if deviceModel == "iPhone" && !isiPhoneXOrLater {
            heightdynamic.constant = 200
        } else {
            heightdynamic.constant = 380
        }

    }

    private func isiPhoneXOrLaterModel() -> Bool {
        let deviceSize = UIScreen.main.bounds.size
        return deviceSize.height >= 812.0
    }

}
