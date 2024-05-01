//
//  ProfileTapVC.swift
//  MUNZUL
//
//  Created by Navdeep Singh on 13/03/24.
//

import UIKit

class ProfileTapVC: UIViewController {

    @IBOutlet var BackgroundView: UIView!
    @IBOutlet weak var BackgrounImage_Bottom: ColoredCircularView!
    @IBOutlet weak var ProfileView: ColoredCircularView!
    @IBOutlet weak var TableView_setting: UITableView!
    @IBOutlet weak var TableView: UIView!
    @IBOutlet weak var CurveProfileTapView: UIView!
    @IBOutlet weak var Curve_BottomView: UIView!
    @IBOutlet weak var NameTxt: UILabel!
    @IBOutlet weak var EmailTxt: UILabel!
    @IBOutlet weak var DottedProfile: DashedCircleView!
    
    var  ProfileIDJSON = [Profile_JSON]()
    var appCoordinator: AppCoordinator?
    var cellData: [[String: String]] = [
         ["imageName": "My_property", "labelText": "My Properties"],
         ["imageName": "My_Biddings", "labelText": "My Biddings"],
         ["imageName": "History_icon", "labelText": "History"],
         ["imageName": "Bookmarked_icon", "labelText": "Bookmarked"],
         ["imageName": "About_icon", "labelText": "About Us"],
         ["imageName": "payment_icon", "labelText": "Payment"],
         ["imageName": "Term_ICON", "labelText": "Additional Info"],
         ["imageName": "Settings_icon", "labelText": "Settings"]
     ]
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.setNavigationBarHidden(true, animated: false)

        if let navigationController = navigationController as? UINavigationController {
                 appCoordinator = AppCoordinator(navigationController: navigationController)
             }
        GetProfileDetails()
        SetUpLayoutCurve()
        TableView_setting.register(UINib(nibName: "Profile_TableCell", bundle: nil), forCellReuseIdentifier: "Profile_TableCell")
        
        TableView_setting.dataSource = self
        TableView_setting.delegate = self
        TableView.layer.cornerRadius = 20
        TableView.layer.masksToBounds = true
        TableView.layer.shadowColor = UIColor.black.cgColor
        TableView.layer.shadowOpacity = 0.5
        TableView.layer.shadowOffset = CGSize(width: 0, height: 2)
        TableView.layer.shadowRadius = 4
        TableView.backgroundColor = App.C.AppWhiteBackground
        Curve_BottomView.layer.cornerRadius = 20
        Curve_BottomView.layer.masksToBounds = true
        Curve_BottomView.layer.shadowColor = UIColor.black.cgColor
        Curve_BottomView.layer.shadowOpacity = 0.5
        Curve_BottomView.layer.shadowOffset = CGSize(width: 0, height: 2)
        Curve_BottomView.layer.shadowRadius = 4
        Curve_BottomView.backgroundColor = App.C.AppWhiteBackground
        
    }

    @IBAction func ActionProfile(_ sender: Any) {
        
    
          appCoordinator?.MyProfileVC()
    }
    
    
    @IBAction func BackgroundCheckAction(_ sender: Any) {
        print("Tapped on My profile VC")
        appCoordinator?.navigateToSignIn()
    }
    func SetUpLayoutCurve(){
        BackgrounImage_Bottom.setColor(.clear)
        let profileBottom = UIImage(named: "Background_doc")
        BackgrounImage_Bottom.setImage(profileBottom)
        BackgrounImage_Bottom.backgroundColor = App.C.GrenishColor
        CurveProfileTapView.layer.cornerRadius = 20
        CurveProfileTapView.layer.masksToBounds = true
        CurveProfileTapView.layer.shadowColor = UIColor.black.cgColor
        CurveProfileTapView.layer.shadowOpacity = 0.5
        CurveProfileTapView.layer.shadowOffset = CGSize(width: 0, height: 2)
        CurveProfileTapView.layer.shadowRadius = 4
        BackgroundView.backgroundColor = App.C.AppBackgroundColor
        CurveProfileTapView.backgroundColor = App.C.AppWhiteBackground
//        let profileImage = UIImage(named: "Profile_pic")
        let profileColor = UIColor.blue  // Set your desired border color
        ProfileView.setImage(App.Images.ProfilePic)
//        ProfileView.setColoredCircularViewColor(profileColor)
    }

   
}

extension ProfileTapVC: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "Profile_TableCell", for: indexPath) as! Profile_TableCell

           let data = cellData[indexPath.row]

           if let imageName = data["imageName"], let labelText = data["labelText"] {
               let profileImage = UIImage(named: imageName)
               let profileColor = UIColor.clear

               cell.configureCell(profileImage: profileImage, profileColor: profileColor, labelText: labelText)
           }
        cell.CircularViewWidth.constant = 35
           // Configure other cell properties if needed

           return cell
       }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedData = cellData[indexPath.row]

        if let labelText = selectedData["labelText"] as? String {
            print("Cell tapped at index: \(indexPath.row), Label text: \(labelText)")

            if labelText == "Settings" {
                appCoordinator?.NavigateToSettingVC()
            }
            if labelText == "My Properties" {
                appCoordinator?.NavigateToMyPropertiesListVC()
            }
            if labelText == "My Biddings" {
                appCoordinator?.NavigateToMyBiddingsListVC()
            }
            if labelText == "History" {
                appCoordinator?.NavigateToHistoryList()
            }
            if labelText == "Bookmarked" {
                appCoordinator?.NavigateToBookMarkedVC()
            }
            if labelText == "Payment" {
                appCoordinator?.NavigateToPaymentVc()
            }
            
              
            
        } else {
            print("Error: labelText not found or not a String")
        }

        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
}
//FetchData
extension ProfileTapVC {
    
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

                self.UpdateProfileTapVC()
            }
          

            
        } catch {
            print("Error parsing JSON: \(error)")
        }
    }
    
    func UpdateProfileTapVC() {
        DispatchQueue.main.async {

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
            // Extract notification preferences
              let notificationPush = profileModel.data?.notifications?.pushNotification ?? false  // Default to false if not found
              let notificationPushEmail = profileModel.data?.notifications?.emailNotification ?? false // Default to false if not found

              // Store notification preferences in UserDefaults
              UserDefaults.standard.set(notificationPush, forKey: "pushNotificationEnabled")
              UserDefaults.standard.set(notificationPushEmail, forKey: "emailNotificationEnabled")

         


            print("Name: \(name)")
            print("Email: \(email)")
            print("Profile Pic: \(profilePic)")
            
            self.NameTxt.text = name
            self.EmailTxt.text = email
             
            
            guard let profileFrameColor = profileModel.data?.frame else {
                print("No profile color found in userdefault - ProfileTapVC")
                return
            }
          

            switch profileFrameColor {
            case 0: // Yellow
                print("Selected color: Yellow")
                self.ProfileView.setColor(App.C.YellowProfileColor)
                self.DottedProfile.borderColor = App.C.YellowProfileColor
            case 1: // Green
                print("Selected color: Green")
                self.ProfileView.setColor(App.C.GreenProfileColor)
                self.DottedProfile.borderColor = App.C.GreenProfileColor
            case 2: // Gray
                print("Selected color: Gray")
                self.ProfileView.setColor(App.C.GrayProfileColor)
                self.DottedProfile.borderColor = App.C.GrayProfileColor
            default:
                print("Unknown color")
            }

        }
    }
    
}
