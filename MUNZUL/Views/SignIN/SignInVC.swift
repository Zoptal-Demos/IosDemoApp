//
//  SignInVC.swift
//  MUNZUL
//
//  Created by Navdeep Singh on 06/03/24.
//

import UIKit
import CoreLocation
import IQKeyboardManagerSwift

enum AuthenticationType {
    case signIn
    case signUp
}

class SignInVC: UIViewController,RoundedTextFieldViewDelegate {
    @IBOutlet weak var BotomLayerMaskView: UIView!
    @IBOutlet weak var TopViewMake: UIView!
    @IBOutlet weak var BottomLayer: UIView!
    @IBOutlet weak var Scroll_viewSign: UIScrollView!
    @IBOutlet weak var EmailTxtView: RoundedTextFieldView!
    @IBOutlet weak var PasswordTxtView: RoundedTextFieldView!
    @IBOutlet weak var BtnViewCorner: UIView!
    @IBOutlet weak var HideSignUp: UIView!
    @IBOutlet weak var Hide_Select_Role: RoundedTextFieldView!
    @IBOutlet weak var Hide_userName: RoundedTextFieldView!
    @IBOutlet weak var Hid_userName: UIView!
    
    
    @IBOutlet weak var SignInBtn: RoundedButtonUI!
    
    @IBOutlet weak var lblSignINBtn: UILabel!
    
    @IBOutlet weak var GetStarted_lbl: UILabel!
    @IBOutlet weak var AccountAlredyLbl: UILabel!
    @IBOutlet weak var SignIn_Lbl: UILabel!
    @IBOutlet weak var Sign_Btn: UIButton!
    
    
    @IBOutlet weak var Sign_Btn_Lbl: UILabel!
    
    var authenticationType: AuthenticationType = .signIn
    var currentEmailText: String?
    var currentUserNameText: String?
    var currentSelectRoleText: String?
    var currentPasswordText: String?
    var appCoordinator: AppCoordinator?
    var locationManager = CLLocationManager()
    var userLocation: CLLocationCoordinate2D?
    var selectedLatitude: Double = 0.0
    var selectedLongitude: Double = 0.0
    let pickerView = UIPickerView()
    let roles = ["USER", "AGENT"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("View did load - SignInVC")
        
        if let navigationController = navigationController as? UINavigationController {
            appCoordinator = AppCoordinator(navigationController: navigationController)
        }
        
        
        SetupTextField()
        
        setupLocationManager()
        
        
        SetupBtnAndViewLayout()
        
        if authenticationType == .signIn{
            animateHideViews()
        }else{
            print("AUthenticate type is signup")
        }
        
        GetMenuSetUp()
        
    }
    func GetMenuSetUp(){
        
        Hide_Select_Role.textField.inputView = pickerView
        Hide_Select_Role.textField.textAlignment = .left
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        // Add toolbar with done button to dismiss the picker
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissPicker))
        toolbar.setItems([doneButton], animated: true)
        Hide_Select_Role.textField.inputAccessoryView = toolbar
        
    }
    //MARK: - RoundedTextfieldView Fetch Text label
    func textFieldViewDidUpdateText(_ textFieldView: RoundedTextFieldView, text: String) {
        if textFieldView == EmailTxtView {
            currentEmailText = text
            print("EmailTxtView text: \(text)")
        } else if textFieldView == PasswordTxtView {
            currentPasswordText = text
            print("PasswordTxtView text: \(text)")
        } else if textFieldView == Hide_Select_Role {
            currentSelectRoleText = text
            
            print("Hide_Select_Role text: \(text)")
        } else if textFieldView == Hide_userName {
            currentUserNameText = text
            
            print("Hide_userName text: \(text)")
        }
    }
    //MARK: - SetupTextField - PlaceHolder
    func SetupTextField(){


        EmailTxtView.textField.placeholder = "Email"
        PasswordTxtView.textField.placeholder = "Password"
        Hide_userName.textField.placeholder = "User Name"
        Hide_Select_Role.textField.placeholder = "Select Role"


        PasswordTxtView.isPasswordField = true
        PasswordTxtView.showVisibilityButton()
        let rightButtonImage3 = UIImage(named: "Down_Icon")
        Hide_Select_Role.showVisibilityButton()
        Hide_Select_Role.setLeftButtonBackgroundImage(rightButtonImage3)
        Hide_Select_Role.visibilityButton.addTarget(self, action: #selector(SelectRollBtn), for: .touchUpInside)
        let rightButtonImage = UIImage(named: "Message_icon")
        let rightButtonImage2 = UIImage(named: "password_unlock")
        let UsernameImage = UIImage(named: "User_Name")
        Hide_userName.setRightButtonBackgroundImage(UsernameImage)
        Hide_Select_Role.setRightButtonBackgroundImage(UsernameImage)
        EmailTxtView.setRightButtonBackgroundImage(rightButtonImage)
        PasswordTxtView.setRightButtonBackgroundImage(rightButtonImage2)
    }
    //MARK: - SelectRollBtn
    @objc func SelectRollBtn(){
        print("Tapped on Select Roll Btn")
        Hide_Select_Role.textField.becomeFirstResponder()
        
    }
    //MARK: - SetupBtnAndViewLayout - Btn label titile
    
    func SetupBtnAndViewLayout(){
        
        EmailTxtView.delegate = self
        PasswordTxtView.delegate = self
        Hide_Select_Role.delegate = self
        Hide_userName.delegate = self
        
       
        SignInBtn.button.addTarget(self, action: #selector(submitButtonAction), for: .touchUpInside)
        Sign_Btn_Lbl.text = Localization.SignUp
        Sign_Btn_Lbl.font = App.F.GettingSortFont
        
        
        Sign_Btn_Lbl.textColor = App.C.DescriptionColor
        SignInBtn.setLabelText(Localization.SignIn, textColor: App.C.AppWhiteBackground )
        SignInBtn.viewColor = App.C.BtnColor0898
        SignInBtn.viewColor = App.C.BtnColor0898
        SignInBtn.borderColor = App.C.BtnColor0898
        SignInBtn.borderWidth = 1.0
        
        
        BtnViewCorner.layer.cornerRadius = 20.0
        BtnViewCorner.layer.masksToBounds = true
        AccountAlredyLbl.font = App.F.GettingSortFont
        AccountAlredyLbl.text = Localization.LblNotAlredy
        GetStarted_lbl.font = App.F.GettingFont
        GetStarted_lbl.text = Localization.GettingStarted
        GetStarted_lbl.textColor = App.C.ScreenColor
        SignIn_Lbl.textColor = App.C.DescriptionColor
        SignIn_Lbl.font = App.F.GettingSortFont
        SignIn_Lbl.text = Localization.GettingSortLbl
        
        TopViewMake.layer.cornerRadius = 20.0
        TopViewMake.layer.masksToBounds = true
        BottomLayer.layer.cornerRadius = 20.0
        BotomLayerMaskView.layer.masksToBounds = true
        BotomLayerMaskView.layer.cornerRadius = 20.0
        
    }
    
    //MARK: - ForgetAction =- Btn Action
    @IBAction func ForgetAction(_ sender: Any) {
        print("Tapped on ForgetACtion")
        appCoordinator?.RecoverVC()
    }
    
    //MARK: - submitButtonAction = Fetch Emal & Password on Sign - Up  Btn

    @objc func submitButtonAction() {
        
        print("Tapped on ActionSignIn")
        if authenticationType == .signIn {
            appCoordinator?.NavigateToTabBar()
            
            // Add any additional parameters specific to sign-in
        } else if authenticationType == .signUp {
            appCoordinator?.NavigateToTabBar()
            
        }
    }
    

    
    //MARK: - When User Don't Have account with them
    @IBAction func ActionSignUP(_ sender: Any) {
        
        if Sign_Btn_Lbl.text == Localization.SignUp {
            print("Tapped on SignUP")
            authenticationType = .signUp
            animateUnhideViews()
            changeLbl()
        } else {
            print("Tapped on SignIN")
            authenticationType = .signIn
            animateHideViews()
            changeLblForSignIN()
        }
    }
    //MARK: - changeLbl - when user click on action signup
    
    private func changeLbl(){
        AccountAlredyLbl.text = Localization.LblAlredy
        Sign_Btn_Lbl.text = Localization.SignIn
    }
    
    private func changeLblForSignIN(){
        AccountAlredyLbl.text = Localization.LblNotAlredy
        Sign_Btn_Lbl.text = Localization.SignUp
        SignInBtn.setLabelText(Localization.SignIn, textColor: App.C.AppWhiteBackground )
        SignIn_Lbl.text = Localization.GettingSortSinUPLbl
        
    }
    
    private func animateHideViews() {
        UIView.animate(withDuration: 0.3, animations: {
            self.Hid_userName.alpha = 0
            self.Hide_userName.alpha = 0
            self.Hide_Select_Role.alpha = 0
            self.HideSignUp.alpha = 0
        }) { _ in
            self.Hid_userName.isHidden = true
            self.Hide_userName.isHidden = true
            self.Hide_Select_Role.isHidden = true
            self.HideSignUp.isHidden = true
            
            self.resetAlpha()
            
            UIView.animate(withDuration: 0.3, animations: {
                let contentOffset = CGPoint(x: 0, y: -self.Scroll_viewSign.contentInset.top)
                self.Scroll_viewSign.setContentOffset(contentOffset, animated: true)
            })
        }
    }
    
    //MARK: - animateUnhideViews - to make SignUp ui
    // Function to unhide specified views with a fade-in animation
    private func animateUnhideViews() {
        
        Sign_Btn_Lbl.font = App.F.GettingSortFont
        Sign_Btn_Lbl.textColor = App.C.DescriptionColor
        SignInBtn.setLabelText(Localization.SignUp, textColor: App.C.AppWhiteBackground )
        
        Hide_userName.clearTextField()
        Hide_Select_Role.clearTextField()
        EmailTxtView.clearTextField()
        PasswordTxtView.clearTextField()
        
        Hid_userName.isHidden = false
        Hide_userName.isHidden = false
        Hide_Select_Role.isHidden = false
        HideSignUp.isHidden = false
        
        resetAlpha()
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
            self.Hid_userName.alpha = 1
            self.Hide_userName.alpha = 1
            self.Hide_Select_Role.alpha = 1
            self.HideSignUp.alpha = 1
        }) { _ in
            let contentOffset = CGPoint(x: 0, y: -self.Scroll_viewSign.contentInset.top)
            self.Scroll_viewSign.setContentOffset(contentOffset, animated: true)
        }
    }
    
    
    private func resetAlpha() {
        self.Hid_userName.alpha = 1
        self.Hide_userName.alpha = 1
        self.Hide_Select_Role.alpha = 1
        self.HideSignUp.alpha = 1
    }
    
    
}
extension SignInVC: CLLocationManagerDelegate {
    
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last?.coordinate else { return }
        userLocation = location
        selectedLatitude = location.latitude
        selectedLongitude = location.longitude
        
        saveUserLocation()
        print("User's location: \(selectedLatitude), \(selectedLongitude)")
        
    }
    
}

extension SignInVC {
    
    func registerUserType() {
        guard let emailText = currentEmailText, let passwordText = currentPasswordText else {
            print("Email or Password is nil")
            return
        }
        
        guard let UserNameText = currentUserNameText, let SelectRoleText = currentSelectRoleText else {
            print("Username or SelectROle is nil")
            return
        }
        
        let registrationData = RegistrationAPIData(
            name: UserNameText,
            email: emailText,
            password: passwordText,
            address: "string",
            latitude: selectedLatitude,
            longitude: selectedLongitude,
            about: "string",
            role: SelectRoleText,
            deviceToken: "12345",
            deviceType: DeviceInfo.deviceType,
            appVersion: DeviceInfo.appVersion,
            deviceModel: DeviceInfo.deviceModel
        )
        print("Prepared Parameters SIGN-UP : \(registrationData.params())")
        NetworkManager.shared.startRequest(apiData: registrationData, completion: handleRegistrationResponse)
    }
    
    // Agent Side And User Side
    
    func loginUserType() {
        guard let emailText = currentEmailText, let passwordText = currentPasswordText else {
            print("Email or Password is nil")
            return
        }
        print("Stored Email Text: \(emailText)")
        print("Stored Password Text: \(passwordText)")
        
        let LogInUserData = LoginModelData(
            email: emailText,
            password: passwordText,
            latitude: selectedLatitude,
            longitude: selectedLongitude,
            loginType: "NORMAL",
            deviceToken: "12345",
            deviceType: DeviceInfo.deviceType,
            appVersion: DeviceInfo.appVersion,
            deviceModel: DeviceInfo.deviceModel
        )
        print("Prepared Parameters SIGN-IN : \(LogInUserData.params())")
        NetworkManager.shared.startRequest(apiData: LogInUserData, completion: handleSignINResponse)
        
    }
    
    
}
extension SignInVC{
    
    func handleRegistrationResponse(data: Data?, response: URLResponse?, error: Error?) {
        if let networkError = error as? NetworkError {
            print("Network request error: \(networkError.getFormattedError(message: networkError.localizedDescription))")
            DispatchQueue.main.async {
                
                CustomAlert.showAlert(with: "Network request error: \(networkError.localizedDescription)", in: self)
            }
            return
        }
        
        guard let responseData = data, let httpResponse = response as? HTTPURLResponse else {
            print("Invalid response or no data")
            DispatchQueue.main.async {
                
                CustomAlert.showAlert(with: "Invalid response or no data", in: self)
            }
            return
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            print("Invalid status code: \(httpResponse.statusCode)")
            return
        }
        
        do {
            
            let registrationModel = try JSONDecoder().decode(RegistrationModel.self, from: responseData)
            print("Registration response: \(registrationModel)")
            
            if let code = registrationModel.code, code == 200 {
                
                if let registrationData = registrationModel.data {
                    print("Registration ID: \(registrationData.id ?? "")")
                    print("Email: \(registrationData.email ?? "")")
                    print("USER-ROLE: \(registrationData.role ?? "")")
                    //
                    //                       KeyChainService.shared.saveUserEmail(email: registrationData.email ?? "")
                    //                       KeyChainService.shared.saveUserRole(role: registrationData.role ?? "")
                    //
                }
                DispatchQueue.main.async {
                    CustomAlert.showAlert(with: registrationModel.message ?? "MessageNotAvailable", in: self) {
                        self.authenticationType = .signIn
                        self.animateHideViews() // Assuming you have a hideView method to handle hiding views
                        self.changeLblForSignIN()
                    }
                }
            }else{
                DispatchQueue.main.async {
                    CustomAlert.showAlert(with: registrationModel.message ?? "MessageNotAvailable", in: self) {
                        print("STATUS CODE Is NOt 200 - SignInVC")
                    }
                }
            }
            
            
        } catch {
            print("Error decoding response data: \(error)")
            // Handle decoding error (e.g., show an alert)
        }
    }
    
    
    
    func handleSignINResponse(data: Data?, response: URLResponse?, error: Error?) {
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
            let LogInModel = try JSONDecoder().decode(LogInModel.self, from: responseData)
            print("LogInModel response: \(LogInModel)")
            // Access the registration data if needed
            if let code = LogInModel.code, code == 200 {
                if let token = LogInModel.token {
                    print("USERID: \(LogInModel.info?.id ?? "")")
                    print("Email: \(LogInModel.info?.email ?? "")")
                    print("USER-ROLE: \(LogInModel.info?.role ?? "")")
                    
                    KeyChainService.shared.saveUserEmail(email: LogInModel.info?.email ?? "")
                    KeyChainService.shared.saveUserRole(role: LogInModel.info?.role ?? "")
                    KeyChainService.shared.saveUserID(userID:LogInModel.info?.id ?? "")
                    
                    
                    KeyChainService.shared.saveLoginToken(token: token)
                    
                    
                    DispatchQueue.main.async {
                        CustomAlert.showAlert(with: LogInModel.message ?? "MessageNotAvailable", in: self) {
                            print("UserVerified- LOGING IN>>>")
                            
                            self.appCoordinator?.NavigateToTabBar()
                        }
                    }
                    
                } else {
                    DispatchQueue.main.async {
                        CustomAlert.showAlert(with: LogInModel.message ?? "MessageNotAvailable", in: self) {
                            print("UserVerified- LOGING IN>>>")
                            
                            self.appCoordinator?.NavigateToTabBar()
                        }
                    }
                    print("Token not found in response")
                }
                
            }else{
                
                DispatchQueue.main.async {
                    CustomAlert.showAlert(with: LogInModel.message ?? "MessageNotAvailable", in: self) {
                        print("Code- Is not 200 >>>")
                        
                        self.appCoordinator?.navigateToSignIn()
                    }
                }
                
            }
        } catch {
            print("Error decoding response data: \(error)")
        }
    }
    
}


extension SignInVC: UIPickerViewDelegate,UIPickerViewDataSource  {
    
    @objc func dismissPicker() {
        view.endEditing(true)
    }
    
    // MARK: - UIPickerViewDataSource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return roles.count
    }
    
    // MARK: - UIPickerViewDelegate
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return roles[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        Hide_Select_Role.textField.text = roles[row]
        print("\(roles[row]) selected")
    }
}


extension SignInVC {
    func saveUserLocation() {
        if let userLocation = userLocation {
            UserDefaults.standard.set(userLocation.latitude, forKey: "UserLatitude")
            UserDefaults.standard.set(userLocation.longitude, forKey: "UserLongitude")
        }
    }
}
