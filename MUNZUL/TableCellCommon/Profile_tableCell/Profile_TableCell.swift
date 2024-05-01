//
//  Profile_TableCell.swift
//  MUNZUL
//
//  Created by Navdeep Singh on 13/03/24.
//

import UIKit

class Profile_TableCell: UITableViewCell {

    @IBOutlet weak var BoarderView: UIView!
    @IBOutlet weak var viewBackground: ColoredCircularView!
    @IBOutlet weak var ViewBackgroundImg: UIView!
    @IBOutlet weak var Circular_TableImage: ColoredCircularView!
    @IBOutlet weak var Lbl_Txt_setting: UILabel!
    @IBOutlet weak var Btn_Forward: UIButton!
    @IBOutlet weak var Image_btn: UIImageView!
    
    @IBOutlet weak var CircularViewWidth: NSLayoutConstraint!
    func configureCell(profileImage: UIImage?, profileColor: UIColor, labelText: String) {
        Circular_TableImage.setImage(profileImage)
        Circular_TableImage.setColor(profileColor)
        Lbl_Txt_setting.text = labelText
    }
    
        override func awakeFromNib() {
            super.awakeFromNib()
            // Initialization code
            Circular_TableImage.backgroundColor = App.C.AppBackgroundColor
            viewBackground.backgroundColor = App.C.AppBackgroundColor
            viewBackground.setColor(.clear)
            BoarderView.backgroundColor = App.C.txtfieldNone
        }
    

        override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)

            // Configure the view for the selected state
        }
    
    
    }
