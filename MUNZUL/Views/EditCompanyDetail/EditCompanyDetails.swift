//
//  EditCompanyDetails.swift
//  MUNZUL
//
//  Created by Sonoma on 26/03/24.
//

import UIKit

class EditCompanyDetails: UIViewController {

    @IBOutlet var BackGroundView: UIView!
   
    @IBOutlet weak var CompanyName: RoundedTextFieldView!
    @IBOutlet weak var CompanyWebsite: RoundedTextFieldView!
    
    @IBOutlet weak var CompanyContact: RoundedTextFieldView!
    @IBOutlet weak var FullAddress: RoundedTextFieldView!
    
    @IBOutlet weak var CityTextfield: RoundedTextFieldView!
    
    @IBOutlet weak var ZipCodeTextfield: RoundedTextFieldView!
    
    @IBOutlet weak var UpdateBtn: RoundedButtonUI!
    
    var appCoordinator: AppCoordinator?
    var profileData =  [Profile_JSON]()
    
    var CompanyNamefieldText: String?
    var CompanyWebsiteFieldText: String?
    var CompanyContactTextFieldText: String?
    var FullAddressTextFieldText: String?
    var CityTextfieldText: String?
    var ZipCdeTextFieldText: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let navigationController = navigationController as? UINavigationController {
                 appCoordinator = AppCoordinator(navigationController: navigationController)
             }
        BackGroundView.backgroundColor = App.C.AppBackgroundColor
        
        SetupTextField()
        PrintallValueNeeded()

        // Do any additional setup after loading the view.
    }
    func SetupTextField(){
        //settextfield placeholder
        
        CompanyName.textField.placeholder = "Company Name"
        CompanyWebsite.textField.placeholder = "Company Website"
        //About
        CompanyContact.textField.placeholder = "Company Contact"
        FullAddress.textField.placeholder = "Full Address"
        CityTextfield.textField.placeholder = "City"
        ZipCodeTextfield.textField.placeholder = "Zip Code"
        
                   
        CompanyName.delegate = self
        CompanyWebsite.delegate = self
        CompanyContact.delegate = self
        FullAddress.delegate = self
        CityTextfield.delegate = self
        ZipCodeTextfield.delegate = self

        //Hide Right Btn For TextField in Custom View
        CompanyName.rightButton.isHidden = true
        CompanyWebsite.rightButton.isHidden = true
        CompanyContact.rightButton.isHidden = true
        FullAddress.rightButton.isHidden = true
        CityTextfield.rightButton.isHidden = true
        ZipCodeTextfield.rightButton.isHidden = true
        
        
        //Hide spacing From Custom View
        CompanyName.spacerView.isHidden = true
        CompanyWebsite.spacerView.isHidden = true
        CompanyContact.spacerView.isHidden = true
        FullAddress.spacerView.isHidden = true
        CityTextfield.spacerView.isHidden = true
        ZipCodeTextfield.spacerView.isHidden = true
        //BTN
        
        UpdateBtn.setLabelText(Localization.Update, textColor: App.C.AppWhiteBackground )
        UpdateBtn.viewColor = App.C.BtnColor0898
        
        
        UpdateBtn.button.addTarget(self, action: #selector(UpdatBtnAction), for: .touchUpInside)
        UpdateBtn.borderColor = App.C.BtnColor0898
        UpdateBtn.borderWidth = 1.0
        //FontColor Set here
        
    }
        func PrintallValueNeeded(){
           
            
            if let profileData = self.profileData.first {
                // Print _id
                if let id = profileData.data?._id {
                    print("_id: \(id)")
                }
                if let CompanyNameTest = profileData.data?.company_details?.name {
                    print("Name: \(CompanyNameTest)")
                    CompanyName.textField.text = CompanyNameTest
                    CompanyNamefieldText = CompanyNameTest
                }
                
                // Print email
                if let CompanyWebsiteTxt = profileData.data?.company_details?.website {
                    print("CompanyWebsite: \(CompanyWebsiteTxt)")
                    CompanyWebsite.textField.text = CompanyWebsiteTxt
                    CompanyWebsiteFieldText = CompanyWebsiteTxt
                }
                
                // Print about
                if let companyConatctTxt = profileData.data?.company_details?.contact {
                    print("About: \(companyConatctTxt)")
                    CompanyContact.textField.text = companyConatctTxt
                    CompanyContactTextFieldText = companyConatctTxt
                }
                
                if let CompanyAdress = profileData.data?.company_details?.address {
                    print("CompanyAdress: \(CompanyAdress)")
                    FullAddress.textField.text = CompanyAdress
                    FullAddressTextFieldText = CompanyAdress
                }  
                if let CityCodeTxt = profileData.data?.company_details?.address {
                    print("CityCodeTxt: \(CityCodeTxt)")
                    CityTextfield.textField.text = CityCodeTxt
                    CityTextfieldText = CityCodeTxt
                }
                if let ZipCodeTXt = profileData.data?.company_details?.address {
                    print("ZipCodeTXt: \(ZipCodeTXt)")
                    ZipCodeTextfield.textField.text = ZipCodeTXt
                    ZipCdeTextFieldText = ZipCodeTXt
                }
            } else {
                print("Profile Company data is nil.")
            }
            
            
            
        }
    
    @objc func UpdatBtnAction() {
        print("UpdatBtnAction Pressed - EditCompanyDetails")
        submitButtonAction()
    }
    
    @IBAction func ActionBckBtn(_ sender: Any) {
        print("BckBtn Pressed - EditCompanyDetails")

        appCoordinator?.pop(animated: true)
    }
    


}
extension EditCompanyDetails:RoundedTextFieldViewDelegate{
    //MARK: - RoundedTextfieldView Fetch Text label
    func textFieldViewDidUpdateText(_ textFieldView: RoundedTextFieldView, text: String) {
              
        if textFieldView == CompanyName {
            CompanyNamefieldText = text
            print("CompanyNamefieldText text: \(text)")
        } else if textFieldView == CompanyWebsite {
            CompanyWebsiteFieldText = text
            print("CompanyWebsiteFieldText text: \(text)")
        } else if textFieldView == CompanyContact {
            CompanyContactTextFieldText = text
            
            print("CompanyContactTextFieldText text: \(text)")
        } else if textFieldView == FullAddress {
            FullAddressTextFieldText = text
            
            print("FullAddressTextFieldText text: \(text)")
        }else if textFieldView == CityTextfield {
            CityTextfieldText = text
            print("CityTextfieldText text: \(text)")
        }else if textFieldView == ZipCodeTextfield {
            ZipCdeTextFieldText = text
            print("ZipCdeTextFieldText text: \(text)")
        }
    }
}
extension EditCompanyDetails{
    
    @objc func submitButtonAction() {
        print("NextBtnProfile - EditProfileDetail")
        // Print text from text fields
        print("CompanyName text: \(CompanyNamefieldText ?? "")")
        print("CompanyWebsite text: \(CompanyWebsiteFieldText ?? "")")
        print("CompanyContact text: \(CompanyContactTextFieldText ?? "")")
        print("FullAddress text: \(FullAddressTextFieldText ?? "")")
        print("CityText text: \(CityTextfieldText ?? "")")
        print("Full-Address text: \(ZipCdeTextFieldText ?? "")")
        
        if let userLatitude = UserDefaults.standard.value(forKey: "UserLatitude") as? Double,
               let userLongitude = UserDefaults.standard.value(forKey: "UserLongitude") as? Double {
                print("User's latitude: \(userLatitude), longitude: \(userLongitude)")
                // You can use userLatitude and userLongitude as needed
            } else {
                print("User's location not found in UserDefaults")
            }
  
        
        let CompanyDetailUpdate = CompanyDetailUpdateAPI(name: CompanyNamefieldText ?? "",
                                                         website: CompanyWebsiteFieldText ?? "",
                                                         latitude:  UserDefaults.standard.value(forKey: "UserLatitude") as? Double ?? 0,
                                                         longitude:  UserDefaults.standard.value(forKey: "UserLongitude") as? Double ?? 0,
                                                         contact: CompanyContactTextFieldText ?? "",
                                                         address: FullAddressTextFieldText ?? "",
                                                         city: CityTextfieldText ?? "",
                                                         zipcode: ZipCdeTextFieldText ?? ""
                                                )
        
        print("Prepared Parameters Profileupdate : \(CompanyDetailUpdate.params())")
        
        NetworkManager.shared.startRequest(apiData: CompanyDetailUpdate, completion: HandleCompanyUpdatedData)

        
    }
    
    func HandleCompanyUpdatedData(data: Data?, response: URLResponse?, error: Error?) {
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

