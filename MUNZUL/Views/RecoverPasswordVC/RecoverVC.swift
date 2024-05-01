//
//  RecoverVC.swift
//  MUNZUL
//
//  Created by Navdeep Singh on 12/03/24.
//

import UIKit

class RecoverVC: UIViewController, RoundedTextFieldViewDelegate {
    
    @IBOutlet weak var BackGroundStateView: UIView!
    @IBOutlet weak var ImagRecoverOtp: UIImageView!
    @IBOutlet weak var BckBtnImg: UIImageView!
    @IBOutlet weak var titileVCLbl: UILabel!
    @IBOutlet weak var lblRecoverBC: UILabel!
    @IBOutlet weak var SubmitBtn: RoundedButtonUI!
    @IBOutlet weak var EmailTxtField: RoundedTextFieldView!
    var appCoordinator: AppCoordinator?
    var currentEmailText: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        setuplayout()
        if let navigationController = navigationController as? UINavigationController {
            appCoordinator = AppCoordinator(navigationController: navigationController)
        }
        
        SubmitBtn.button.addTarget(self, action: #selector(submitButtonAction), for: .touchUpInside)

        
    }
    
    func setuplayout(){
        let rightButtonImage = UIImage(named: "Message_icon")
        
        EmailTxtField.textField.placeholder = "Email"
        EmailTxtField.setRightButtonBackgroundImage(rightButtonImage)
        EmailTxtField.delegate = self
        
        
        BackGroundStateView.backgroundColor = App.C.AppBackgroundColor
        SubmitBtn.setLabelText(Localization.Sendotp, textColor: App.C.BtnColor0898 )
        SubmitBtn.viewColor = .clear
        SubmitBtn.borderColor = App.C.BtnColor0898
        SubmitBtn.borderWidth = 1.0
    }
    
    @objc func submitButtonAction() {
        print("SendOtp Pressed - RecoverVC")
        
//        RecoverPasswordOTP()
        self.appCoordinator?.VerifyOtp(email: self.currentEmailText ?? "Example@Mail.com")
    }
    
    @IBAction func BckBtnAction(_ sender: Any) {
        print("BackBtn - RecoverVC ")
        appCoordinator?.pop(animated: true)
    }
    
    func textFieldViewDidUpdateText(_ textFieldView: RoundedTextFieldView, text: String) {
        if textFieldView == EmailTxtField {
            currentEmailText = text
            print("EmailTxtView text: \(text)")
        } else {
            print("NoTextfield")
        }
        
    }
}
extension RecoverVC{
    
    func RecoverPasswordOTP() {
        guard let emailText = currentEmailText else{
            print("Recovery Email - nil")
            return
        }
        print("Stored Email Text: \(emailText)")
        
        let RecoverPassword = RecoverAccountAPIData(email: emailText)
        
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
            let RecoverModel = try JSONDecoder().decode(RecoverModel.self, from: responseData)
            print("LogInModel response: \(RecoverModel)")
            
            // Access the registration data if needed
            if let code = RecoverModel.code, code == 200 {
                DispatchQueue.main.async {
                    CustomAlert.showAlert(with: RecoverModel.message ?? "MessageNotAvailable", in: self) {
                        print("RecoverPasswordOTP - Sending Mail>>>")
                        
                        self.appCoordinator?.VerifyOtp(email: self.currentEmailText ?? "NO Email send from RecoverScreen")
                    }
                }
            }else{
                DispatchQueue.main.async {
                    CustomAlert.showAlert(with: RecoverModel.message ?? "MessageNotAvailable", in: self) {
                        print("RecoverPasswordOTP - AccountEmail wrong Entered>>>")
                        
//                        self.appCoordinator?.VerifyOtp(email: self.currentEmailText ?? "NO Email send from RecoverScreen")
                    }
                }
            }
            // Handle the decoded response (e.g., update UI)
        } catch {
            print("Error decoding response data: \(error)")
        }
    }
}
