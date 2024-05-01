//
//  SetPasswordVC.swift
//  MUNZUL
//
//  Created by Navdeep Singh on 12/03/24.
//

import UIKit

class SetPasswordVC: UIViewController, RoundedTextFieldViewDelegate {

    @IBOutlet var BackgroundView: UIView!
    
    @IBOutlet weak var TxtLblTItle: UILabel!
    @IBOutlet weak var SetPassTxtField: RoundedTextFieldView!
    
    @IBOutlet weak var BtnSetPassword: RoundedButtonUI!
    @IBOutlet weak var ConfirmPassTxtfiels: RoundedTextFieldView!
    var appCoordinator: AppCoordinator?

    
    var currentSetPassText: String?
    var currentSetPass2Text: String?

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setuplayout()
        SetupTextField()
        if let navigationController = navigationController as? UINavigationController {
                 appCoordinator = AppCoordinator(navigationController: navigationController)
             }
  
        BtnSetPassword.button.addTarget(self, action: #selector(submitButtonAction), for: .touchUpInside)

    }

    @objc func submitButtonAction() {
         print("Set-Password Pressed - SetPasswordVC")
        self.appCoordinator?.navigateToSignIn()

        

  }
    func setuplayout(){
        BtnSetPassword.viewColor = App.C.BtnColor0898
        BackgroundView.backgroundColor = App.C.AppBackgroundColor
        BtnSetPassword.setLabelText(Localization.Set_Password, textColor: App.C.AppWhiteBackground )
        BtnSetPassword.borderColor = App.C.BtnColor0898
        BtnSetPassword.borderWidth = 1.0
    }

    //MARK: - RoundedTextfieldView Fetch Text label
        func textFieldViewDidUpdateText(_ textFieldView: RoundedTextFieldView, text: String) {
               if textFieldView == SetPassTxtField {
                   currentSetPassText = text
                   print("SetpassField1 text: \(text)")
               } else if textFieldView == ConfirmPassTxtfiels {
                   currentSetPass2Text = text
                   print("SetpassField2 text: \(text)")
               }
           }
    
    
        //MARK: - SetupTextField - PlaceHolder
        func SetupTextField(){
            //settextfield placeholder
            SetPassTxtField.textField.placeholder = "New Password"
            ConfirmPassTxtfiels.textField.placeholder = "Confirm New Password"
            SetPassTxtField.delegate = self
            ConfirmPassTxtfiels.delegate = self

            
            //set textfield password
            SetPassTxtField.isPasswordField = true
            ConfirmPassTxtfiels.showVisibilityButton()
            SetPassTxtField.showVisibilityButton()

            let rightButtonImage2 = UIImage(named: "password_unlock")
            SetPassTxtField.setRightButtonBackgroundImage(rightButtonImage2)
            ConfirmPassTxtfiels.setRightButtonBackgroundImage(rightButtonImage2)
        }

}
extension SetPasswordVC{
    
    func SetPasswordAPI() {
        guard let CurrentText = currentSetPassText else{
            print("NewPASSWORD - nil ")
            return
        }
        guard let ConfirmText = currentSetPass2Text else{
            print("Confirm password - nil")
            return
        }
        print(" NewPassword Text: \(CurrentText)")
        print(" ConfirmPassowrd Text: \(ConfirmText)")
        
        guard let savedToken = KeyChainService.shared.getSavedLoginToken() else {
            print("Token not found in Keychain")
            return
        }
        
        let RecoverPassword = RecoverPasswordAPIData(password: ConfirmText, token: savedToken)
        print("Prepared Parameters RecoverPassword : \(RecoverPassword.params())")
        NetworkManager.shared.startRequest(apiData: RecoverPassword, completion: handleRecoverPasswordResponse)
        
        
        
    }
    
    func handleRecoverPasswordResponse(data: Data?, response: URLResponse?, error: Error?) {
        if let networkError = error as? NetworkError {
            // Handle specific network errors
            print("Network request error: \(networkError.getFormattedError(message: networkError.localizedDescription))")
            CustomAlert.showAlert(with: "Network request error: \(networkError.localizedDescription)", in: self)
            return
        }
        
        guard let responseData = data, let httpResponse = response as? HTTPURLResponse else {
            print("Invalid response or no data")
            // Handle invalid response or no data (e.g., show an alert)
            return
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            print("Invalid status code: \(httpResponse.statusCode)")
            // Handle invalid status code (e.g., show an alert)
            return
        }
        
        do {
            
            // Parse the response data if needed
            let RecoverModel = try JSONDecoder().decode(RecoverPasswordModel.self, from: responseData)
            print("LogInModel response: \(RecoverModel)")
            
            if let code = RecoverModel.code, code == 200 {
                DispatchQueue.main.async {
                    CustomAlert.showAlert(with: RecoverModel.message ?? "MessageNotAvailable", in: self) {
                        print("SetPASSWORDVC - Sending SigIN Page  >>>")
                        self.appCoordinator?.navigateToSignIn()
                    }
                }
            }else{
                CustomAlert.showAlert(with: RecoverModel.message ?? "MessageNotAvailable", in: self) {
                    print("Password Not Set  - Sending SigIN Page  >>>")
                    
                }
            }
            // Handle the decoded response (e.g., update UI)
        } catch {
            print("Error decoding response data: \(error)")
        }
    }
}
