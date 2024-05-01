//
//  LocationSetting.swift
//  MUNZUL
//
//  Created by Sonoma on 01/04/24.
//

import UIKit

class LocationSetting: UIViewController {

    @IBOutlet var BackGroundView: UIView!
    @IBOutlet weak var WhileProfile: ColoredCircularView!
    
    @IBOutlet weak var WhileCircularProfile: ColoredCircularView!
    
    @IBOutlet weak var WhileUsingTogle: CustomToogleView!
    
    
    @IBOutlet weak var AlwaysProfile: ColoredCircularView!
    
    @IBOutlet weak var AlwaysCircularView: ColoredCircularView!
    
    
    @IBOutlet weak var DontProfile: ColoredCircularView!
    
    
    @IBOutlet weak var DontCircularProfile: ColoredCircularView!
    
    
    @IBOutlet weak var DontTogleBtn: CustomToogleView!
    
    @IBOutlet weak var RoundView1: UIView!
    
    @IBOutlet weak var RoundView2: UIView!
    
    
    @IBOutlet weak var RoundView3: UIView!
    
    var appCoordinator: AppCoordinator?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let navigationController = navigationController as? UINavigationController {
            appCoordinator = AppCoordinator(navigationController: navigationController)
        }
        // Do any additional setup after loading the view.
        setuplayout()
    }

    func setuplayout(){
        BackGroundView.backgroundColor = App.C.AppBackgroundColor
        
        RoundView1.layer.cornerRadius = 20
        RoundView1.layer.masksToBounds = true
        
        RoundView2.layer.cornerRadius = 20
        RoundView2.layer.masksToBounds = true
        
        RoundView3.layer.cornerRadius = 20
        RoundView3.layer.masksToBounds = true
        
        WhileProfile.backgroundColor = App.C.BtnColor0898Faid
        AlwaysProfile.backgroundColor = App.C.BtnColor0898Faid
        DontProfile.backgroundColor = App.C.BtnColor0898Faid
        WhileProfile.setImage(App.Images.Location_Image)
        AlwaysProfile.setImage(App.Images.Location_Image)
        DontProfile.setImage(App.Images.Location_Image)
    }
 
    @IBAction func ActionBckBtn(_ sender: Any) {
        appCoordinator?.pop(animated: true)
        
    }
    
}
