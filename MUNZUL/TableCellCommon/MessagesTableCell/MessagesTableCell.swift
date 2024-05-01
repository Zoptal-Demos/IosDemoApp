//
//  MessagesTableCell.swift
//  MUNZUL
//
//  Created by Sonoma on 10/04/24.
//

import UIKit

class MessagesTableCell: UITableViewCell {
// user pic circular / user name for Messages / Flat for rent Status /  time ago / Messages
    
    @IBOutlet weak var ProfilePhotoTapped: UIButton!
    
    @IBOutlet weak var UserPictureProfile: ColoredCircularView!
    
    
    @IBOutlet weak var UserNameLbl: UILabel!
    
    @IBOutlet weak var TimeAgoLbl: UILabel!
    
    @IBOutlet weak var FlatStatusLbl: UILabel!
    
    @IBOutlet weak var MessageAboutLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
}
