//
//  MyProfileVC.swift
//  MUNZUL
//
//  Created by Navdeep Singh on 13/03/24.
//

import UIKit

class MyProfileVC: UIViewController,UIFrameSetUpDelegate {
    @IBOutlet var BackGroundColor: UIView!
    @IBOutlet weak var ViewFirstTableCirve: UIView!
    @IBOutlet weak var SecondviewCurveTable: UIView!
    @IBOutlet var BackgroundView: UIView!
    @IBOutlet weak var titileLbl: UILabel!
    @IBOutlet weak var MyProfileImage: ColoredCircularView!
    @IBOutlet weak var CircularBtnEdit: CircularButtons!
    @IBOutlet weak var Profile_email: UILabel!
    @IBOutlet weak var Profile_name: UILabel!
    @IBOutlet weak var ProfileDEtailTXt: UILabel!
    //Views for Hide in Stack - Profile
    @IBOutlet weak var AboutStack: UIStackView!
    @IBOutlet weak var AboutLabel: UILabel!
    @IBOutlet weak var AboutInfoLbl: UITextView!
    
    @IBOutlet weak var PhoneNumber: UIStackView!
    @IBOutlet weak var PhoneLbl: UILabel!
    @IBOutlet weak var PhonedetailLbl: UILabel!
    
    @IBOutlet weak var RoleUser: UIStackView!
    @IBOutlet weak var RoleLbl: UILabel!
    @IBOutlet weak var RoleInfo: UILabel!
    
    @IBOutlet weak var RealEstateLicense: UIStackView!
    @IBOutlet weak var RealEstateLbl: UILabel!
    @IBOutlet weak var RealEstateInfo: UILabel!
    
    @IBOutlet weak var AddressViewProfile: UIStackView!
    @IBOutlet weak var AdressProfileLbl: UILabel!
    @IBOutlet weak var AdressInfoLbl: UILabel!
    
    
    
    @IBOutlet weak var RefferalCode: UIStackView!
    @IBOutlet weak var RefferalLbl: UILabel!
    @IBOutlet weak var RefferealCodeInfo: UILabel!
    
    
    
    @IBOutlet weak var ProfileDetailView: UIView!
    @IBOutlet weak var ProfileDetailLbl: UILabel!
    // View for Hide in stack - Contact details
    
    @IBOutlet weak var CompanyNames: UIStackView!
    @IBOutlet weak var CompanyNameLbl: UILabel!
    @IBOutlet weak var CompanyNameInfo: UILabel!
    
    
    
    @IBOutlet weak var CompanyWebsite: UIStackView!
    
    @IBOutlet weak var CompanyLbl: UILabel!
    
    @IBOutlet weak var CompanyInfoLbl: UILabel!
    
    
    
    @IBOutlet weak var CompanyCOntact: UIStackView!
    @IBOutlet weak var companyContactlbl: UILabel!
    @IBOutlet weak var CompanyContactInfo: UILabel!
    
    @IBOutlet weak var CompanyAddress: UIStackView!
    @IBOutlet weak var CompanyadressInfo: UILabel!
    @IBOutlet weak var AdressCompany: UILabel!
    
    @IBOutlet weak var CompanyDetailView: UIView!
    @IBOutlet weak var DetailCompanyTxt: UILabel!
    @IBOutlet weak var AddProfilePic: CircularButtons!
    @IBOutlet weak var DottedLinesProfile: DashedCircleView!
    @IBOutlet weak var EditCompanyDetails: CircularButtons!
    @IBOutlet weak var NodataProfileDetail: UIView!
    @IBOutlet weak var ProfileViewDesign: UIView!
    @IBOutlet weak var EditProfileBtn: CircularButtons!
    @IBOutlet weak var NodataViewCompanyDetais: UIView!
    
   
    
    var appCoordinator: AppCoordinator?
    var  ProfileIDJSON = [Profile_JSON]()
    
    private var optionsView: UIView!
    private var optionsViewButton: UIView!
    private var optionsStackView: UIStackView!
    private var editButtonContainer: UIView!
    private var deleteButtonContainer: UIView!
    
    
  
 
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        GetProfileDetails()
        navigationController?.setNavigationBarHidden(true, animated: false)
        if let navigationController = navigationController as? UINavigationController {
            appCoordinator = AppCoordinator(navigationController: navigationController)
        }

        setEditBtnLayout()
        
    
        
        ViewFirstTableCirve.layer.cornerRadius = 15
        ViewFirstTableCirve.layer.masksToBounds = true
        
        // Set corner radius for SecondviewCurveTable
        SecondviewCurveTable.layer.cornerRadius = 15
        SecondviewCurveTable.layer.masksToBounds = true
        //App.C.AppBackgroundColor
        BackgroundView.backgroundColor = App.C.AppBackgroundColor
//        let profileImage = UIImage(named: "Profile_pic")


        let profileColor = UIColor.red  // Set your desired border color
        let EditIcon = UIImage(named: "EditIcon")
        let ProfileAddMore = UIImage(named: "AddProfile")

        
        MyProfileImage.setImage(App.Images.ProfilePic)
        MyProfileImage.setColor(profileColor)
        
        AddProfilePic.setBackgroundColor(.clear)
        AddProfilePic.button.addTarget(self, action: #selector(ProfileBtnAction), for: .touchUpInside)
        AddProfilePic.setImage(ProfileAddMore)
        
        
        navigationController?.isNavigationBarHidden = true

    }

    func setEditBtnLayout(){
        let EditIcon = UIImage(named: "EditIcon")
        CircularBtnEdit.isHidden = true
         
        EditProfileBtn.setBackgroundColor(App.C.EscapeColor)
        EditProfileBtn.button.addTarget(self, action: #selector(editProfileDetails), for: .touchUpInside)
        EditProfileBtn.setImage(EditIcon)
        
        EditCompanyDetails.setBackgroundColor(App.C.EscapeColor)
        EditCompanyDetails.button.addTarget(self, action: #selector(editCompanyDetails), for: .touchUpInside)
        EditCompanyDetails.setImage(EditIcon)
    }
    
    @objc func editProfileDetails() {
        print("Tapped on editProfileDetails")
        //Print All Data From Profile Details
    
        if let profileData = self.ProfileIDJSON.first {
               // Print _id
            if let id = profileData.data?._id {
                   print("_id: \(id)")
               }
            if let Name = profileData.data?.name {
                print("Name: \(Name)")
            }
            
               // Print email
            if let email = profileData.data?.email {
                   print("Email: \(email)")
               }
               
               // Print about
            if let about = profileData.data?.about {
                   print("About: \(about)")
               }
            if let Role = profileData.data?.role {
                print("Role: \(Role)")
            }
               
               // Print address
            if let address = profileData.data?.address {
                   print("Address: \(address)")
               }
          
           } else {
               print("Profile data is nil.")
           }
          
        appCoordinator?.NavigateToEditProfile(profileData: ProfileIDJSON)
    }
    
    
    @objc func editCompanyDetails() {
        print("Tapped on editCompanyDetails")
        if let profileData = self.ProfileIDJSON.first {
               // Print _id
            if let id = profileData.data?._id {
                   print("_id: \(id)")
               }
            if let CompanyName = profileData.data?.company_details?.name {
                print("Name: \(CompanyName)")
            }
            
               // Print email
            if let CompanyWebsite = profileData.data?.company_details?.website {
                   print("CompanyWebsite: \(CompanyWebsite)")
               }
               
               // Print about
            if let companyConatct = profileData.data?.company_details?.contact {
                   print("About: \(companyConatct)")
               }
            
            if let CompanyAdress = profileData.data?.company_details?.address {
                print("CompanyAdress: \(CompanyAdress)")
            }
           } else {
               print("Profile Company data is nil.")
           }
          
        appCoordinator?.NavigateToEditCompany(profileData: ProfileIDJSON)

    }
    @IBAction func ActionBckBtn(_ sender: Any) {
        appCoordinator?.pop(animated: true)
    }
    @objc func ProfileBtnAction() {
        print("Tapped on Profile button")
        if optionsView == nil {
            optionsView = UIView()
            optionsView.backgroundColor = .white
            optionsView.layer.cornerRadius = 8
            optionsView.layer.borderWidth = 1.0
            optionsView.layer.borderColor = UIColor.clear.cgColor
            optionsView.translatesAutoresizingMaskIntoConstraints = false
            optionsView.backgroundColor = .white
            optionsView.layer.shadowColor = UIColor.black.cgColor
            optionsView.layer.shadowOpacity = 0.2
            optionsView.layer.shadowOffset = CGSize(width: 0, height: 2)
            optionsView.layer.shadowRadius = 4
            let editButton = UIButton(type: .system)
            editButton.setTitle("Upload Profile Picture", for: .normal)
            editButton.titleLabel?.font = UIFont(name: "Poppins-Regular", size: 12) ?? UIFont.systemFont(ofSize: 12)
            let customColor = UIColor(red: 86/255, green: 83/255, blue: 91/255, alpha: 0.90)
            editButton.setTitleColor(customColor, for: .normal)
            editButton.contentEdgeInsets = UIEdgeInsets(top: 10, left: 0, bottom: 5, right: 0)
            editButton.addTarget(self, action: #selector(UploadProfileTappedBox), for: .touchUpInside)
            let deleteButton = UIButton(type: .system)
            deleteButton.setTitle("Change Frame", for: .normal)
            deleteButton.titleLabel?.font = UIFont(name: "Poppins-Regular", size: 12) ?? UIFont.systemFont(ofSize: 12)
            deleteButton.setTitleColor(customColor, for: .normal)
            deleteButton.addTarget(self, action: #selector(ChangeFrameTappedBox), for: .touchUpInside)
            let separatorView = UIView()
            let separatorBackgroundColor = UIColor(red: 86/255, green: 83/255, blue: 91/255, alpha: 0.10)
            separatorView.backgroundColor = separatorBackgroundColor
            separatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
            let separatorWidthConstraint = separatorView.widthAnchor.constraint(equalToConstant: 10)
            separatorWidthConstraint.isActive = true
            let stackView = UIStackView(arrangedSubviews: [editButton, separatorView, deleteButton])
            stackView.axis = .vertical
            stackView.spacing = 0
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.insertArrangedSubview(separatorView, at: 1)
            optionsView.addSubview(stackView)
            view.addSubview(optionsView)
            NSLayoutConstraint.activate([
                optionsView.topAnchor.constraint(equalTo: AddProfilePic.bottomAnchor, constant: 5),
                optionsView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
                optionsView.widthAnchor.constraint(equalToConstant: 135),
                optionsView.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 1.0, constant:2),
                stackView.topAnchor.constraint(equalTo: optionsView.topAnchor, constant: 1),
                stackView.leadingAnchor.constraint(equalTo: optionsView.leadingAnchor),
                stackView.trailingAnchor.constraint(equalTo: optionsView.trailingAnchor),
                stackView.bottomAnchor.constraint(equalTo: optionsView.bottomAnchor, constant: -13),
                separatorView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 18),
                separatorView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -18),
                editButton.trailingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 12),
                deleteButton.trailingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 10),
            ])
            optionsView.alpha = 0
            UIView.animate(withDuration: 0.3) {
                self.optionsView.alpha = 1
            }
        } else {
            optionsView?.removeFromSuperview()
            optionsView = nil
        }
    }
    
    @objc private func UploadProfileTappedBox() {
        print("Upload Profile Picture tapped")
        closeOptionsView()
      }
    
      @objc private func ChangeFrameTappedBox() {
        print("Change Frame Button tapped")
          self.appCoordinator?.NavigateSelectedFrame(delegate: self)

          closeOptionsView()
          
      }
      private func closeOptionsView() {
        UIView.animate(withDuration: 0.3, animations: {
          self.optionsView?.alpha = 0
        }) { _ in
          self.optionsView?.removeFromSuperview()
          self.optionsView = nil
        }
      }
   
  
}



extension MyProfileVC{
    
    
   func UpdateUIMyProfileVC(){
//       DispatchQueue.main.async {

           guard let profileModel = self.ProfileIDJSON.first else {
                  print("No profile data found")
                  return
              }
           guard let name = profileModel.data?.name,
                 let email = profileModel.data?.email,
                 let profilePic = profileModel.data?.profile_pic else {
               print("Name, Email, or Profile Pic is nil")
               return
           }
           //setup Profile Pic + Frame
           self.Profile_name.text = name
           self.Profile_email.text = email
           


//       }
   }
    
    func setUpProfileFrame(){
        
       
        guard let profileFrameColor = self.ProfileIDJSON.first?.data?.frame else {
               print("No profile color data found")
               return
           }
        switch profileFrameColor {
        case 0: // Yellowsd
            print("Selected color: Yellow")
            self.MyProfileImage.setColor(App.C.YellowProfileColor)
            self.DottedLinesProfile.borderColor = App.C.YellowProfileColor
        case 1: // Green
            print("Selected color: Green")
            self.MyProfileImage.setColor(App.C.GreenProfileColor)
            self.DottedLinesProfile.borderColor = App.C.GreenProfileColor
        case 2: // Gray
            print("Selected color: Gray")
            self.MyProfileImage.setColor(App.C.GrayProfileColor)
            self.DottedLinesProfile.borderColor = App.C.GrayProfileColor
        default:
            print("Unknown color")
        }
        
    }
    
    func setAutoresizingLayoutProfileDetails(){
        
        //ABOUT PROFILE DETAILS - PROFILE DETAILS
        if let aboutDetail = self.ProfileIDJSON.first?.data?.about {
            if aboutDetail == "string" {
                // Handle the case where the about detail is "String" (consider it as empty)
                self.AboutStack.isHidden = true
            } else if !aboutDetail.isEmpty {
                // Handle the case where aboutDetail is not empty
                self.AboutStack.isHidden = false
                self.AboutLabel.text = "About"
                self.AboutInfoLbl.text = aboutDetail
            } else {
                // Handle the case where aboutDetail is empty
                self.AboutStack.isHidden = true
            }
        } else {
            // Handle the case where aboutDetail is nil
            self.AboutStack.isHidden = true
        }
        
        //PHONE NUMNBER DETAILS - ProfileDetails
        
        if let phoneNumber = self.ProfileIDJSON.first?.data?.contact {
            if phoneNumber == "" {
                // Handle the case where the about detail is "String" (consider it as empty)
                self.PhoneNumber.isHidden = true
            } else if !phoneNumber.isEmpty {
                // Handle the case where aboutDetail is not empty
                self.PhoneNumber.isHidden = false
                self.PhoneLbl.text = "Phone Number"
                self.PhonedetailLbl.text = phoneNumber
            } else {
                // Handle the case where aboutDetail is empty
                self.PhoneNumber.isHidden = true
            }
        } else {
            // Handle the case where aboutDetail is nil
            self.PhoneNumber.isHidden = true
        }
        
            
        //Role User Hide & Unhide according to APi
        if let RoleUser = self.ProfileIDJSON.first?.data?.role {
            if RoleUser == "" {
              
                self.RoleUser.isHidden = true
            } else if !RoleUser.isEmpty {
                // Handle the case where aboutDetail is not empty
                self.RoleUser.isHidden = false
                self.RoleLbl.text = "Role"
                self.RoleInfo.text = RoleUser
            } else {
                // Handle the case where aboutDetail is empty
                self.RoleUser.isHidden = true
            }
        } else {
            // Handle the case where aboutDetail is nil
            self.RoleUser.isHidden = true
        }
        
        //License real Estate
            
        if let RealEstateLicense = self.ProfileIDJSON.first?.data?.license_number {
            if RealEstateLicense == "" {
              
                self.RealEstateLicense.isHidden = true
            } else if !RealEstateLicense.isEmpty {
                // Handle the case where aboutDetail is not empty
                self.RealEstateLicense.isHidden = false
                self.RealEstateLbl.text = "Real Estate License Number"
                self.RealEstateInfo.text = RealEstateLicense
            } else {
                // Handle the case where aboutDetail is empty
                self.RealEstateLicense.isHidden = true
            }
        } else {
            // Handle the case where aboutDetail is nil
            self.RealEstateLicense.isHidden = true
        }
        
        //Address - Profile Details
            
        if let AddressViewProfile = self.ProfileIDJSON.first?.data?.address {
        if AddressViewProfile == "string" {
          
            self.AddressViewProfile.isHidden = true
        } else if !AddressViewProfile.isEmpty {
            // Handle the case where aboutDetail is not empty
            self.AddressViewProfile.isHidden = false
            self.AdressProfileLbl.text = "Address"
            self.AdressInfoLbl.text = AddressViewProfile
        } else {
            // Handle the case where aboutDetail is empty
            self.AddressViewProfile.isHidden = true
        }
    } else {
        // Handle the case where aboutDetail is nil
        self.AddressViewProfile.isHidden = true
    }
        
           
        //Refreal Code - Profile Details
        if let RefferalCode = self.ProfileIDJSON.first?.data?.referral_code {
            if RefferalCode == "string" {
              
                self.RefferalCode.isHidden = true
            } else if !RefferalCode.isEmpty {
                // Handle the case where aboutDetail is not empty
                self.RefferalCode.isHidden = false
                self.RefferalLbl.text = "Referral Code"
                self.RefferealCodeInfo.text = RefferalCode
            } else {
                // Handle the case where aboutDetail is empty
                self.RefferalCode.isHidden = true
            }
        } else {
           
            self.RefferalCode.isHidden = true
        }
        
        if AboutStack.isHidden && PhoneNumber.isHidden && RoleUser.isHidden && RealEstateLicense.isHidden && AddressViewProfile.isHidden && RefferalCode.isHidden {
              // Show the No Data view if all other views are hidden
            NodataProfileDetail.isHidden = false
          } else {
              // Hide the No Data view if any of the other views are visible
              NodataProfileDetail.isHidden = true
          }
            
    }
    
    func setAutoresizingLayoutCompanyDetails(){
        
       

        if let companyName = self.ProfileIDJSON.first?.data?.company_details?.name, !companyName.isEmpty {
                    // 'companyName' is not nil and not an empty string
                    self.CompanyNames.isHidden = false
                    self.CompanyNameLbl.text = "Company Name"
                    self.CompanyNameInfo.text = companyName
                } else {
                    // 'companyName' is either nil or an empty string
                    self.CompanyNames.isHidden = true
                }
        if let companyWebsite = self.ProfileIDJSON.first?.data?.company_details?.website, !companyWebsite.isEmpty {
                    // If companyWebsite is not nil and not empty
                    self.CompanyWebsite.isHidden = false
                    self.CompanyLbl.text = "Company Website"
                    self.CompanyInfoLbl.text = companyWebsite
                } else {
                    // If companyWebsite is nil or empty
                    self.CompanyWebsite.isHidden = true
                }
        
        if let companyContact = self.ProfileIDJSON.first?.data?.company_details?.contact, !companyContact.isEmpty {
                    // If companyContact is not nil and not empty
                    self.CompanyCOntact.isHidden = false
                    self.companyContactlbl.text = "Company Contact"
                    self.CompanyContactInfo.text = companyContact
                } else {
                    // If companyContact is nil or empty
                    self.CompanyCOntact.isHidden = true
                }
        if let companyAddress = self.ProfileIDJSON.first?.data?.company_details?.address, !companyAddress.isEmpty {
                    // If companyAddress is not nil and not empty
                    self.CompanyAddress.isHidden = false
                    self.AdressCompany.text = "Company Address"
                    self.CompanyadressInfo.text = companyAddress
                } else {
                    // If companyAddress is nil or empty
                    self.CompanyAddress.isHidden = true
                }
        
        if CompanyNames.isHidden && CompanyWebsite.isHidden && CompanyCOntact.isHidden && CompanyAddress.isHidden {
              // Show the No Data view if all other views are hidden
            NodataViewCompanyDetais.isHidden = false
          } else {
              // Hide the No Data view if any of the other views are visible
              NodataViewCompanyDetais.isHidden = true
          }
         
   
        
    }
       
   }
    
// MARK: - UPDATE PROFILE FRAME
extension MyProfileVC{
    
    func didSelectColor(_ color: Int) {
        UpdateFrameForProfile(color: color)
        switch color {
          case 0: // Yellow
              print("Selected color: Yellow")
              MyProfileImage.setColor(App.C.YellowProfileColor)
              DottedLinesProfile.borderColor = App.C.YellowProfileColor
          case 1: // Green
              print("Selected color: Green")
              MyProfileImage.setColor( App.C.GreenProfileColor)
              DottedLinesProfile.borderColor = App.C.GreenProfileColor
          case 2: // Gray
              print("Selected color: Gray")
              MyProfileImage.setColor(App.C.GrayProfileColor )
              DottedLinesProfile.borderColor = App.C.GrayProfileColor
          default:
              print("Unknown color")
          }
    }
    
    func UpdateFrameForProfile(color: Int) {
        // Pass the color integer to the function
        let UpdateFrmaeAPiCall = UpdateFrameAPIData(frame: color)
        NetworkManager.shared.startRequest(apiData: UpdateFrmaeAPiCall, completion: HandleUpdateFrameModel)
        
//        DataManager.shared.saveProfileColor(colorInteger: color)

    }

    
    
    
    
    func HandleUpdateFrameModel(data: Data?, response: URLResponse?, error: Error?) {
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
            let UpdateFrameModel = try JSONDecoder().decode(UpdateFrameModel.self, from: responseData)
            print("UpdateFrameModel: \(UpdateFrameModel)")
//            self.ProfileIDJSON.append(profileModel)

        } catch {
            print("Error parsing JSON: \(error)")
        }
    }
}

extension MyProfileVC{
    func GetProfileDetails() {
        let userID = KeyChainService.shared.getSavedUserID() ?? "" // Providing a default value here

        let ProfileAPICALl = ProfileDataAPI(userID: userID)
        
        NetworkManager.shared.startRequest(apiData: ProfileAPICALl, completion: HandleProfileData)
        
    }
    
    func HandleProfileData(data: Data?, response: URLResponse?, error: Error?) {
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
            let profileModel = try JSONDecoder().decode(Profile_JSON.self, from: responseData)
            self.ProfileIDJSON.removeAll()
            self.ProfileIDJSON.append(profileModel)
            DispatchQueue.main.async {
                
                if profileModel.code == 203 {
                    CustomAlert.showAlert(with: "Session expired, Please login again", in: self) {
                        //Make Sign- In root
                        KeyChainService.shared.deleteSavedDeviceToken()
                        self.appCoordinator?.navigateToSignIn()
                        print("Tapped")
                    }
                }
                //Hardcore data

                let color = profileModel.data?.frame
//                DataManager.shared.saveProfileColor(colorInteger: color)
                self.setUpProfileFrame()
                self.UpdateUIMyProfileVC()
                self.setAutoresizingLayoutProfileDetails()
                self.setAutoresizingLayoutCompanyDetails()
//                self.UpdateProfileTapVC()
            }
          

            
        } catch {
            print("Error parsing JSON: \(error)")
        }
    }
}
