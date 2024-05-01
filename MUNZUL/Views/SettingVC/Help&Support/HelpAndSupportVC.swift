//
//  HelpAndSupportVC.swift
//  MUNZUL
//
//  Created by Sonoma on 01/04/24.
//

import UIKit

class HelpAndSupportVC: UIViewController {

    @IBOutlet var BckGroundView: UIView!
    @IBOutlet weak var ProfilePhone: ColoredCircularView!
    
    @IBOutlet weak var ProfileEmail: ColoredCircularView!
    
    @IBOutlet weak var RoundView1: UIView!
    
    @IBOutlet weak var RoundView2: UIView!
    
    var appCoordinator: AppCoordinator?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            if let navigationController = navigationController as? UINavigationController {
                appCoordinator = AppCoordinator(navigationController: navigationController)
            }
        // Do any additional setup after loading the view.
        ProfilePhone.backgroundColor = App.C.BtnColor0898Faid
        ProfileEmail.backgroundColor = App.C.BtnColor0898Faid
        BckGroundView.backgroundColor = App.C.AppBackgroundColor

        ProfilePhone.setImage(App.Images.CallIcon)
        ProfileEmail.setImage(App.Images.MessageICON)
        
        
        RoundView1.layer.cornerRadius = 20
        RoundView1.layer.masksToBounds = true
        
        
        RoundView2.layer.cornerRadius = 20
        RoundView2.layer.masksToBounds = true
        
    }

    @IBAction func ActionBckBtn(_ sender: Any) {
        appCoordinator?.pop(animated: true)
    }
    
}
