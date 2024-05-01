//
//  NotificationSettingVC.swift
//  MUNZUL
//
//  Created by Sonoma on 01/04/24.
//

import UIKit

class NotificationSettingVC: UIViewController {

    @IBOutlet var BckGroundview: UIView!
    @IBOutlet weak var PushProfile: ColoredCircularView!
    
    @IBOutlet weak var PushCircularProfile: ColoredCircularView!
    
    @IBOutlet weak var PushNotificationTogle: CustomToogleView!
    
    @IBOutlet weak var PushView: UIView!
    
    
    @IBOutlet weak var EmailProfile: ColoredCircularView!
    
    @IBOutlet weak var EmailCircularProfile: ColoredCircularView!
    
    @IBOutlet weak var EmailView: UIView!
    
    @IBOutlet weak var EmailTogle: CustomToogleView!
    var appCoordinator: AppCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
        if let navigationController = navigationController as? UINavigationController {
            appCoordinator = AppCoordinator(navigationController: navigationController)
        }
        
        setuplayout()
  
        let isPushEnabled = UserDefaults.standard.bool(forKey: "pushNotificationEnabled")
        PushNotificationTogle.toggleSwitch.isOn = isPushEnabled
        print(isPushEnabled)
        let isEmailEnabled = UserDefaults.standard.bool(forKey: "emailNotificationEnabled")
        EmailTogle.toggleSwitch.isOn = isEmailEnabled

        print(isEmailEnabled)
    }

    
    
    
    func setuplayout(){
        BckGroundview.backgroundColor = App.C.AppBackgroundColor 
        PushView.layer.cornerRadius = 20
        PushView.layer.masksToBounds = true
        EmailView.layer.cornerRadius = 20
        EmailView.layer.masksToBounds = true
        PushProfile.backgroundColor = App.C.BtnColor0898Faid
        EmailProfile.backgroundColor = App.C.BtnColor0898Faid
        PushProfile.setImage(App.Images.NotificationBell)
        EmailProfile.setImage(App.Images.NotificationBell)
    }
    
    @IBAction func ActionBckBtn(_ sender: Any) {
        appCoordinator?.pop(animated: true)
    }
    
}
