//
//  VerifyOtpVC.swift
//  MUNZUL
//
//  Created by Navdeep Singh on 12/03/24.
//

import UIKit
import OTPFieldView

class VerifyOtpVC: UIViewController, OTPFieldViewDelegate {

    @IBOutlet var MainView: UIView!
    @IBOutlet weak var VCtitleLbl: UILabel!
    @IBOutlet weak var titleVerify: UILabel!
    @IBOutlet weak var BtnSubmit: RoundedButtonUI!
    @IBOutlet weak var OtpField: OTPFieldView!
    
    var appCoordinator: AppCoordinator?
    var currentOTPText: String?
    var email: String?

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let navigationController = navigationController as? UINavigationController {
                 appCoordinator = AppCoordinator(navigationController: navigationController)
             }
        setupOtpView()
        setuplayout()
        navigationController?.isNavigationBarHidden = true
        
        
        BtnSubmit.button.addTarget(self, action: #selector(submitButtonAction), for: .touchUpInside)


    }
    func setuplayout(){
        MainView.backgroundColor = App.C.AppBackgroundColor
        BtnSubmit.setLabelText(Localization.Submit, textColor: App.C.AppWhiteBackground )
        BtnSubmit.viewColor = App.C.BtnColor0898
    }
    func setupOtpView(){
        OtpField.fieldsCount = 4
        OtpField.fieldBorderWidth = 1
        OtpField.cursorColor = App.C.DescriptionColor
        OtpField.displayType = .circular
        OtpField.fieldSize = 40
        OtpField.separatorSpace = 8
        OtpField.defaultBackgroundColor = App.C.AppWhiteBackground
        OtpField.filledBackgroundColor = App.C.AppWhiteBackground
        OtpField.filledBorderColor = App.C.txtfieldStart
        OtpField.defaultBorderColor = App.C.txtfieldNone
        OtpField.shouldAllowIntermediateEditing = false
        OtpField.delegate = self
        OtpField.initializeUI()
    }

    @IBAction func BckBtnAction(_ sender: Any) {
        print("BckBtnAction Pressed - VerifyOtpVC")
        appCoordinator?.pop(animated: true)

    }
   @objc func submitButtonAction() {
        print("SendOtp Pressed - VerifyOtpVC")
        
//        VerifyOtpAPI()
        
       self.appCoordinator?.NavigateToSetPassword()
//        appCoordinator?.VerifyOtp()

 }
    func shouldBecomeFirstResponderForOTP(otpTextFieldIndex index: Int) -> Bool {
          // Return true if the OTP field at the specified index should become the first responder
          return true
      }

      func enteredOTP(otp: String) {
          print("Entered OTP: \(otp)")
          currentOTPText = otp
      }

      func hasEnteredAllOTP(hasEnteredAll: Bool) -> Bool {
          // Return true if all OTP fields have been entered
          return hasEnteredAll
      }


}

extension VerifyOtpVC{
    
    func VerifyOtpAPI() {
        guard let OTPtext = currentOTPText else{
            print("currentOTPText  - nil")
            return
        }
        print("Stored OTPtext: \(OTPtext)")
        
        let verifyOtpAPIDATA = VerifyOTPAPI(email: email ?? "", otp: currentOTPText ?? "")
        
        print("Prepared Parameters VerifyOTP : \(verifyOtpAPIDATA.params())")
        NetworkManager.shared.startRequest(apiData: verifyOtpAPIDATA, completion: handleOtpVerifyResponse)
        
    }
    
    func handleOtpVerifyResponse(data: Data?, response: URLResponse?, error: Error?) {
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
            return
        }

        do {
            
            // Parse the response data if needed
            let VerifyOtpResponse = try JSONDecoder().decode(VerifyOtpModel.self, from: responseData)
            print("LogInModel response: \(VerifyOtpModel.self)")
            
            if let code = VerifyOtpResponse.code, code == 200 {
                if let token = VerifyOtpResponse.token {
                    print("Token  found in VerifyOtpResponse")

                        
                        KeyChainService.shared.saveLoginToken(token: token)
                    
                } else {
                    print("Token not found in response")
                }
                
                DispatchQueue.main.async {
                    CustomAlert.showAlert(with: VerifyOtpResponse.message ?? "MessageNotAvailable", in: self) {
                        print("OTPVERIFICATION SUCESS... - Redirect to SetPasswordVC>>>")
                        self.appCoordinator?.NavigateToSetPassword()

                    }
                    
                }
                
            }else{
                
                DispatchQueue.main.async {
                    CustomAlert.showAlert(with: VerifyOtpResponse.message ?? "MessageNotAvailable", in: self) {
                        print("OTPVERIFICATION FAILES...>>>")
                        
                    }
                    
                }
                
            }            // Access the registration data if needed
            
          
            // Handle the decoded response (e.g., update UI)
        } catch {
            print("Error decoding response data: \(error)")
        }
    }
}
