//
//  ChangePasswordVC.swift
//  MUNZUL
//
//  Created by Sonoma on 01/04/24.
//

import UIKit

class ChangePasswordVC: UIViewController {

    @IBOutlet var BackGroundView: UIView!
    @IBOutlet weak var ConfirmPassword: RoundedTextFieldView!
    
    @IBOutlet weak var NewPassword: RoundedTextFieldView!
    
    @IBOutlet weak var ConfirmNewPassword: RoundedTextFieldView!
    
    var ConfirmPasswordText: String?
    var NewPasswordText: String?
    var ConfirmNewPasswordText: String?
    var appCoordinator: AppCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
        if let navigationController = navigationController as? UINavigationController {
            appCoordinator = AppCoordinator(navigationController: navigationController)
        }
        setLayoutUI()
        // Do any additional setup after loading the view.
    }

    func setLayoutUI(){
        
        BackGroundView.backgroundColor = App.C.AppBackgroundColor
        ConfirmPassword.delegate = self
        NewPassword.delegate = self
        ConfirmNewPassword.delegate = self

        
        
        ConfirmPassword.textField.placeholder = "Current Password"
        NewPassword.textField.placeholder = "New Password"
        ConfirmNewPassword.textField.placeholder = "New Password"

        ConfirmPassword.isPasswordField = true
        ConfirmPassword.showVisibilityButton()
        
        NewPassword.isPasswordField = true
        NewPassword.showVisibilityButton()
        
        ConfirmNewPassword.isPasswordField = true
        ConfirmNewPassword.showVisibilityButton()
        
        ConfirmPassword.setRightButtonBackgroundImage(App.Images.PasswrdImage)
        NewPassword.setRightButtonBackgroundImage(App.Images.PasswrdImage)
        ConfirmNewPassword.setRightButtonBackgroundImage(App.Images.PasswrdImage)

    }
    @IBAction func ActionBckBtn(_ sender: Any) {
        appCoordinator?.pop(animated: true)
    }
   
}
//MARK: - RoundedTextfieldView Fetch Text label

extension ChangePasswordVC: RoundedTextFieldViewDelegate{
        func textFieldViewDidUpdateText(_ textFieldView: RoundedTextFieldView, text: String) {
               if textFieldView == ConfirmPassword {
                   ConfirmPasswordText = text
                   print("ConfirmPasswordText text: \(text)")
               } else if textFieldView == NewPassword {
                   NewPasswordText = text
                   print("NewPasswordText text: \(text)")
               } else if textFieldView == ConfirmNewPassword {
                   ConfirmNewPasswordText = text
                   print("ConfirmNewPasswordText text: \(text)")
               }
           }

    
}
