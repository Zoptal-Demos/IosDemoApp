//
//  EditProfileDetail.swift
//  MUNZUL
//
//  Created by Navdeep Singh on 14/03/24.
//

import UIKit
import CoreLocation



class EditProfileDetail: UIViewController, UITextViewDelegate {
    @IBOutlet var BackGroundView: UIView!
    //NameInStack
    @IBOutlet weak var NameUiView: UIView!
    @IBOutlet weak var NameTextfield: RoundedTextFieldView!
    // Email in stack
    @IBOutlet weak var EmailUIView: UIView!
    @IBOutlet weak var EmailTextField: RoundedTextFieldView!
    //About- User
    @IBOutlet weak var AboutUIView: UIView!
    @IBOutlet weak var AboutTextView: UITextView!
    
    //PhoneNumber
    @IBOutlet weak var PhoneNumberUiview: UIView!
    @IBOutlet weak var PhoneNumberTextField: RoundedTextFieldView!
    
    //SelectRoleTextField
    @IBOutlet weak var SelectedRoleUIView: UIView!
    @IBOutlet weak var SelectRollTextField: RoundedTextFieldView!
   
    //FullAddressUIView
    @IBOutlet weak var FullAddressUIView: UIView!
    @IBOutlet weak var FullAdressTextfield: RoundedTextFieldView!
    
    //CityZipStack
    @IBOutlet weak var CityZipStack: UIStackView!
    //CityTextfield
    @IBOutlet weak var CityTextfield: RoundedTextFieldView!
    //ZipCdeTextField
    @IBOutlet weak var ZipCdeTextField: RoundedTextFieldView!
    
    //NextBtnProfile
    @IBOutlet weak var NextBtnUIView: UIView!
    
    @IBOutlet weak var NextBtnEditProfile: RoundedButtonUI!
    
    let pickerView = UIPickerView()
    let roles = ["USER", "AGENT"]
    var appCoordinator: AppCoordinator?
    var profileData =  [Profile_JSON]()

    var NameTextfieldText: String?
    var EmailTextFieldText: String?
    var PhoneNumberTextFieldText: String?
    var SelectRollTextFieldText: String?
    var FullAdressTextfieldText: String?
    var CityTextfieldText: String?
    var ZipCdeTextFieldText: String?
    var aboutText: String?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let navigationController = navigationController as? UINavigationController {
                 appCoordinator = AppCoordinator(navigationController: navigationController)
             }
        SetupTextField()
        GetMenuSetUp()
        BackGroundView.backgroundColor = App.C.AppBackgroundColor

        AboutTextView.layer.cornerRadius = 20
        AboutTextView.layer.borderWidth = 1
        AboutTextView.layer.borderColor = UIColor.lightGray.cgColor
              
              // Set up placeholder text
              AboutTextView.text = "About"
              AboutTextView.textColor = UIColor.lightGray
              AboutTextView.delegate = self
        
        NextBtnEditProfile.setLabelText(Localization.Submit, textColor: App.C.AppWhiteBackground )
        NextBtnEditProfile.viewColor = App.C.BtnColor0898
        
        
        NextBtnEditProfile.button.addTarget(self, action: #selector(submitButtonAction), for: .touchUpInside)
        NextBtnEditProfile.viewColor = App.C.BtnColor0898
        NextBtnEditProfile.borderColor = App.C.BtnColor0898
        NextBtnEditProfile.borderWidth = 1.0
        PrintallValueNeeded()
    }
    func PrintallValueNeeded(){
        
        if let profileData = self.profileData.first?.data {
               // Print _id
               if let id = profileData._id {
                   print("_id: \(id)")
               }
            if let Name = profileData.name {
                print("Name: \(Name)")
                NameTextfield.textField.text = Name
                NameTextfieldText = Name
            }
               // Print email
               if let email = profileData.email {
                   print("Email: \(email)")
                   EmailTextField.textField.text = email
                   EmailTextFieldText = email

               }
            if let PhoneNumber = profileData.contact {
                print("PhoneNumber: \(PhoneNumber)")
                PhoneNumberTextField.textField.text = PhoneNumber
                PhoneNumberTextFieldText = PhoneNumber

            }
            
               // Print about
               if let about = profileData.about {
                   print("About: \(about)")
                   AboutTextView.text = about
                   aboutText = about
               }
            if let Role = profileData.role {
                print("Role: \(Role)")
                SelectRollTextField.textField.text = Role
                SelectRollTextFieldText = Role

            }
               
               // Print address
               if let address = profileData.address {
                   print("Address: \(address)")
                   FullAdressTextfield.textField.text = address
                   FullAdressTextfieldText = address

               }
            if let CityCode = profileData.country_code {
                print("Address: \(CityCode)")
//                PhoneNumberTextField.textField.text = CityCode
            }

           } else {
               print("Profile data is nil.")
           }
          
    }
 
    func GetMenuSetUp(){
        
        SelectRollTextField.textField.inputView = pickerView
        SelectRollTextField.textField.textAlignment = .left

            pickerView.delegate = self
            pickerView.dataSource = self

            // Add toolbar with done button to dismiss the picker
            let toolbar = UIToolbar()
            toolbar.sizeToFit()
            let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissPicker))
            toolbar.setItems([doneButton], animated: true)
        SelectRollTextField.textField.inputAccessoryView = toolbar
        
    }
    func textViewDidChange(_ textView: UITextView) {
        // Check if the current text is equal to the placeholder
        if textView.text == "About" {
            // If it is, set text color to light gray
            textView.textColor = UIColor.lightGray
            // Set border color to light gray
            AboutTextView.layer.borderColor = UIColor.lightGray.cgColor
        } else {
            // Otherwise, set text color to black
            textView.textColor = UIColor.black
            // Set border color to red
            AboutTextView.layer.borderColor = App.C.txtfieldStart.cgColor
            aboutText = textView.text
            print(textView.text)
        }
    }

    // UITextViewDelegate method to handle when the user begins editing
    func textViewDidBeginEditing(_ textView: UITextView) {
        // If the current text is equal to the placeholder
        if textView.text == "About" {
            // Clear the placeholder text and set text color to black
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }

    // UITextViewDelegate method to handle when the user ends editing
    func textViewDidEndEditing(_ textView: UITextView) {
        // If the text view is empty, restore the placeholder
        if textView.text.isEmpty {
            textView.text = "About"
            textView.textColor = UIColor.lightGray
            // Set border color to light gray
            AboutTextView.layer.borderColor = UIColor.lightGray.cgColor
        }
    }
   
    func SetupTextField(){
        //settextfield placeholder
   
        NameTextfield.textField.placeholder = "Name"
        EmailTextField.textField.placeholder = "Email"
        //About
      PhoneNumberTextField.textField.placeholder = "Phone Number"
        SelectRollTextField.textField.placeholder = "Select Role"
        FullAdressTextfield.textField.placeholder = "Full Address"
        CityTextfield.textField.placeholder = "City"
        ZipCdeTextField.textField.placeholder = "Zip Code"
        
        NameTextfield.delegate = self
        EmailTextField.delegate = self
        PhoneNumberTextField.delegate = self
        SelectRollTextField.delegate = self
        FullAdressTextfield.delegate = self
        CityTextfield.delegate = self
        ZipCdeTextField.delegate = self

           
        
        //Hide Right Btn For TextField in Custom View
        NameTextfield.rightButton.isHidden = true
        EmailTextField.rightButton.isHidden = true
        PhoneNumberTextField.rightButton.isHidden = true
        SelectRollTextField.rightButton.isHidden = true
        FullAdressTextfield.rightButton.isHidden = true
        CityTextfield.rightButton.isHidden = true
        ZipCdeTextField.rightButton.isHidden = true


        //Hide spacing From Custom View
        NameTextfield.spacerView.isHidden = true
        EmailTextField.spacerView.isHidden = true
        PhoneNumberTextField.spacerView.isHidden = true
        SelectRollTextField.spacerView.isHidden = true
        FullAdressTextfield.spacerView.isHidden = true
        ZipCdeTextField.spacerView.isHidden = true
        ZipCdeTextField.spacerView.isHidden = true

    //FontColor Set here
        
        let rightButtonImage3 = UIImage(named: "Down_Icon")
        SelectRollTextField.showVisibilityButton()
        SelectRollTextField.setLeftButtonBackgroundImage(rightButtonImage3)
//        Hide_Select_Role.visibilityButton.addTarget(self, action: #selector(SelectRollBtn), for: .touchUpInside)



    }
    @IBAction func ActionBckBtn(_ sender: Any) {
        appCoordinator?.pop(animated: true)

    }
    
   
}

extension EditProfileDetail: UIPickerViewDelegate,UIPickerViewDataSource  {

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
            SelectRollTextField.textField.text = roles[row]
            print("\(roles[row]) selected")
        }
    }
    
extension EditProfileDetail:RoundedTextFieldViewDelegate{
    
    //MARK: - RoundedTextfieldView Fetch Text label
    func textFieldViewDidUpdateText(_ textFieldView: RoundedTextFieldView, text: String) {
      
        if textFieldView == NameTextfield {
            NameTextfieldText = text
            print("NameTextField text: \(text)")
        } else if textFieldView == EmailTextField {
            EmailTextFieldText = text
            print("Email text: \(text)")
        } else if textFieldView == PhoneNumberTextField {
            PhoneNumberTextFieldText = text
            
            print("PhoneNumber text: \(text)")
        } else if textFieldView == SelectRollTextField {
            SelectRollTextFieldText = text
            
            print("select_Role text: \(text)")
        }else if textFieldView == FullAdressTextfield {
            FullAdressTextfieldText = text
            
            print("Full-Address text: \(text)")
        }else if textFieldView == CityTextfield {
            CityTextfieldText = text
            
            print("CityText text: \(text)")
        }else if textFieldView == ZipCdeTextField {
            ZipCdeTextFieldText = text
            
            print("ZipCode text: \(text)")
        }
    }
}
extension EditProfileDetail{
    
    @objc func submitButtonAction() {
        print("NextBtnProfile - EditProfileDetail")
        // Print text from text fields
        print("NameTextField text: \(NameTextfieldText ?? "")")
        print("Email text: \(EmailTextFieldText ?? "")")
        print("About text: \(aboutText ?? "")")
        print("PhoneNumber text: \(PhoneNumberTextFieldText ?? "")")
        print("select_Role text: \(SelectRollTextFieldText ?? "")")
        print("Full-Address text: \(FullAdressTextfieldText ?? "")")
//        print("CityText text: \(CityTextfieldText ?? "")")
//        print("ZipCode text: \(ZipCdeTextFieldText ?? "")")
        
        if let userLatitude = UserDefaults.standard.value(forKey: "UserLatitude") as? Double,
               let userLongitude = UserDefaults.standard.value(forKey: "UserLongitude") as? Double {
                print("User's latitude: \(userLatitude), longitude: \(userLongitude)")
                // You can use userLatitude and userLongitude as needed
            } else {
                print("User's location not found in UserDefaults")
            }
        
        let ProfileDetailUpdate = ProfileUpdateDetail(name: NameTextfieldText ?? "",
                                                      about: aboutText ?? "",
                                                      latitude: UserDefaults.standard.value(forKey: "UserLatitude") as? Double ?? 0,
                                                      longitude: UserDefaults.standard.value(forKey: "UserLongitude") as? Double ?? 0,
                                                      email: EmailTextFieldText ?? "",
                                                      contact: PhoneNumberTextFieldText ?? "",
                                                      country_code:self.profileData.first?.data?.contact ?? "",
                                                      role: SelectRollTextFieldText ?? "",
//                                                      license_number: "",
                                                      address: FullAdressTextfieldText ?? ""
                                                
        )
        print("Prepared Parameters Profileupdate : \(ProfileDetailUpdate.params())")
        
        NetworkManager.shared.startRequest(apiData: ProfileDetailUpdate, completion: HandleProfileUpdatedData)

        
    }
    
    func HandleProfileUpdatedData(data: Data?, response: URLResponse?, error: Error?) {
        if let networkError = error as? NetworkError {
            // Handle specific network errors
            print("Network request error: \(networkError.getFormattedError(message: networkError.localizedDescription))")
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
        
        if let responseString = String(data: responseData, encoding: .utf8) {
            print("Response Data: \(responseString)")
        }
    
        do {
            
            
            let profileUpdateModel = try JSONDecoder().decode(RecoverPasswordModel.self, from: responseData)
            print("profileUpdateModel response: \(profileUpdateModel)")
            
            if let code = profileUpdateModel.code, code == 200 {
                DispatchQueue.main.async {
                    CustomAlert.showAlert(with: profileUpdateModel.message ?? "MessageNotAvailable", in: self) {
                        print("Profile Updated - Sending Back To Profile Tab  >>>")
                        self.appCoordinator?.pop(animated: true)
                    }
                }
                }else{
                    DispatchQueue.main.async {
                        
                        CustomAlert.showAlert(with: profileUpdateModel.message ?? "MessageNotAvailable", in: self) {
                            print("Profile Not Updated --- Field Validation Check >>>")
                            //eror with code and field
                        }
                    }
                }
            

            
        } catch {
            print("Error parsing JSON: \(error)")
        }
    }
}

