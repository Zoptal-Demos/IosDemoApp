//
//  UIFrameSetUp.swift
//  MUNZUL
//
//  Created by Navdeep Singh on 14/03/24.
//

import UIKit

enum SelectedColor: Int {
    case yellow = 0
    case green = 1
    case gray = 2
}
protocol UIFrameSetUpDelegate: AnyObject {
    func didSelectColor(_ color: Int)
}
class UIFrameSetUp: UIViewController {
    
    @IBOutlet weak var SelectFrameTxt: UILabel!
    @IBOutlet weak var ViewFrame: UIView!
    @IBOutlet weak var IntroTxt: UILabel!
    @IBOutlet weak var CrossBtn: CircularButtons!
    @IBOutlet weak var SelectedViewYellow: UIView!
    @IBOutlet weak var YellowTxt: UILabel!
    @IBOutlet weak var DottedBoarder: DashedCircleView!
    @IBOutlet weak var ProfilePicYellow: ColoredCircularView!
    @IBOutlet weak var SelectedViewGray: UIView!
    @IBOutlet weak var ProfilePicGray: ColoredCircularView!
    @IBOutlet weak var GrayTxt: UILabel!
    @IBOutlet weak var DottedGray: DashedCircleView!
    @IBOutlet weak var SelectedViewGreen: UIView!
    @IBOutlet weak var DottedGreen: DashedCircleView!
    @IBOutlet weak var GreenTxt: UILabel!
    @IBOutlet weak var ProfilepicGreen: ColoredCircularView!
    @IBOutlet weak var SubmitBtn: RoundedButtonUI!
    @IBOutlet weak var YellowSelection: UIButton!
    @IBOutlet weak var GraySelection: UIButton!
    @IBOutlet weak var GreenSelection: UIButton!
    var selectedColor: UIColor?
    var colorInteger: Int?
    weak var delegate: UIFrameSetUpDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        CrossBtn.setBackgroundColor(.white)
        let CrossIcon = UIImage(named: "CrossIcon")
//        let ProfilePic = UIImage(named: "Profile_pic")

        CrossBtn.setImage(CrossIcon)
        
        ViewFrame.backgroundColor = App.C.AppBackgroundColor
        
        ViewFrame.layer.cornerRadius = 20
        ViewFrame.layer.masksToBounds = true
        
        
        [SelectedViewGreen, SelectedViewYellow, SelectedViewGray].forEach { view in
                   view.layer.cornerRadius = 24
                   view.layer.masksToBounds = true
                   // Set initial border color to clear for all views
                   view.layer.borderColor = UIColor.clear.cgColor
                   // Set initial border width to 1 for all views
                   view.layer.borderWidth = 2
               }
      
    
        DottedBoarder.borderColor = App.C.YellowProfileColor
        ProfilePicYellow.setColor(App.C.YellowProfileColor)
        ProfilePicYellow.setImage(App.Images.ProfilePic)
    DottedGreen.borderColor = App.C.GrayProfileColor
        ProfilepicGreen.setColor(App.C.GrayProfileColor)
        ProfilepicGreen.setImage(App.Images.ProfilePic)
    DottedGray.borderColor = App.C.GreenProfileColor
        ProfilePicGray.setImage(App.Images.ProfilePic)
        ProfilePicGray.setColor(App.C.GreenProfileColor)
        

        SubmitBtn.setLabelText(Localization.Submit, textColor: App.C.AppWhiteBackground )
        SubmitBtn.viewColor = App.C.BtnColor0898

        
    }

    @IBAction func YellowBtnAction(_ sender: Any) {
        
        selectedColor = App.C.YellowProfileColor
        colorInteger = 0
               SelectedViewYellow.layer.borderColor = App.C.BtnColor0898.cgColor
               SelectedViewGreen.layer.borderColor = UIColor.clear.cgColor
               SelectedViewGray.layer.borderColor = UIColor.clear.cgColor
        print("Selected color: Yellow")

        
    }
    
    @IBAction func GrayBtnAction(_ sender: Any) {
        colorInteger = 1
        selectedColor = App.C.GreenProfileColor
        SelectedViewYellow.layer.borderColor = UIColor.clear.cgColor
        SelectedViewGreen.layer.borderColor = App.C.BtnColor0898.cgColor
        SelectedViewGray.layer.borderColor = UIColor.clear.cgColor
        print("Selected color: Green")
        

    }
    
    @IBAction func GreenBtnAction(_ sender: Any) {
        colorInteger = 2
        selectedColor = App.C.GrayProfileColor
        SelectedViewYellow.layer.borderColor = UIColor.clear.cgColor
        SelectedViewGreen.layer.borderColor = UIColor.clear.cgColor
        SelectedViewGray.layer.borderColor = App.C.BtnColor0898.cgColor
        print("Selected color: Gray")
        

    }
    @IBAction func BottomBackBtn(_ sender: Any) {
        print("BottomBackBtn - tappeed UIFrameSetUp")
       
        delegate?.didSelectColor(colorInteger ?? 100)

        self.dismiss(animated: true, completion: nil)

    }
    
   
}
