//
//  SettingVc.swift
//  MUNZUL
//
//  Created by Sonoma on 31/03/24.
//

import UIKit

class SettingVc: UIViewController {
    
    @IBOutlet var BackGroundView: UIView!
    @IBOutlet weak var TableUIview: UIView!
    @IBOutlet weak var Setting_TableVC: UITableView!
    @IBOutlet weak var LogOutUiView: UIView!
    
    @IBOutlet weak var LogOutCircular: ColoredCircularView!
    
    var appCoordinator: AppCoordinator?
    var cellData: [[String: String]] = [
        ["imageName": "Change_Password", "labelText": "Change Password"],
        ["imageName": "Notification_ICON", "labelText": "Notifications"],
        ["imageName": "History_icon", "labelText": "Location Settings"],
        ["imageName": "Term_ICON", "labelText": "Terms Of Use"],
        ["imageName": "Privacy_ICON", "labelText": "Privacy Policy"],
        ["imageName": "Help_Support", "labelText": "Help & Support"],
        ["imageName": "About_Munzul", "labelText": "About Munzul"],
    ]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ViewDidLOad : - SettingVc")
        
        navigationController?.setNavigationBarHidden(true, animated: false)
    
        if let navigationController = navigationController as? UINavigationController {
            appCoordinator = AppCoordinator(navigationController: navigationController)
        }
        
        
        BackGroundView.backgroundColor = App.C.AppBackgroundColor
        Setting_TableVC.register(UINib(nibName: "Profile_TableCell", bundle: nil), forCellReuseIdentifier: "Profile_TableCell")
        Setting_TableVC.dataSource = self
        Setting_TableVC.delegate = self
        Setting_TableVC.layer.cornerRadius = 20
        Setting_TableVC.layer.masksToBounds = true
        Setting_TableVC.layer.shadowColor = UIColor.black.cgColor
        Setting_TableVC.layer.shadowOpacity = 0.5
        Setting_TableVC.layer.shadowOffset = CGSize(width: 0, height: 2)
        Setting_TableVC.layer.shadowRadius = 4
        Setting_TableVC.backgroundColor = App.C.AppWhiteBackground
        TableUIview.layer.cornerRadius = 20
        TableUIview.layer.masksToBounds = true
        TableUIview.layer.shadowColor = UIColor.black.cgColor
        TableUIview.layer.shadowOpacity = 0.5
        TableUIview.layer.shadowOffset = CGSize(width: 0, height: 2)
        TableUIview.layer.shadowRadius = 4
        TableUIview.backgroundColor = App.C.AppWhiteBackground
        
        
        LogOutCircular.setImage(App.Images.LogOUTICON)
        LogOutCircular.setColor(.clear)
        LogOutUiView.layer.cornerRadius = 20
        LogOutUiView.layer.masksToBounds = true
        
    }
    
    @IBAction func BckBtnAction(_ sender: Any) {
        appCoordinator?.pop(animated: true)
    }
    
    @IBAction func ActionLogOut(_ sender: Any) {
        print("Action_LogOUT ----CONTINIUE")
        
        self.appCoordinator?.navigateToSignIn()

//        DispatchQueue.main.async {
//            
//            CustomAlert.showAlert(with: "Do you Really want to LogOUT?", in: self) {
//                
//                let LogOUTAPIData = LogOUTAPIData()
//                
//                NetworkManager.shared.startRequest(apiData: LogOUTAPIData, completion: self.handleLogOutAPiResponse)
//            }
//        }
    }
    
}

//MARK: - Extension UI table Setting VC
extension SettingVc: UITableViewDataSource,UITableViewDelegate {
    
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
        cell.viewBackground.backgroundColor = App.C.BtnColor0898Faid
        cell.CircularViewWidth.constant = 40
        
        // Configure other cell properties if needed
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedData = cellData[indexPath.row]
        
        if let labelText = selectedData["labelText"] as? String {
            print("Cell tapped at index: \(indexPath.row), Label text: \(labelText)")
            
            // Check if the label text is "Settings" and perform navigation
            if labelText == "Change Password" {
                appCoordinator?.NavigateToChangePasswordVC()
            }
            if labelText == "Notifications" {
                appCoordinator?.NavigateToNotificationSettingVC()
            }
            if labelText == "Location Settings" {
                appCoordinator?.NavigateToLocationSetting()
            }
          
            if labelText == "Terms Of Use" {
                appCoordinator?.NavigateToTermOfUse()
            }
            if labelText == "Privacy Policy" {
                appCoordinator?.NavigateToPrivacyPolicy()
            }
            if labelText == "About Munzul" {
                appCoordinator?.NavigateToAboutMunZul()
            }
            if labelText == "Help & Support" {
                appCoordinator?.NavigateToHelpAndSupportVC()
            }
            

        } else {
            print("Error: labelText not found or not a String")
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 62
    }
}


//MARK: - Extension Handling LogOUT API Network HAndling
extension SettingVc{
    func handleLogOutAPiResponse(data: Data?, response: URLResponse?, error: Error?) {
        if let networkError = error as? NetworkError {
            // Handle specific network errors
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
            // Handle invalid status code (e.g., show an alert)
            return
        }
        
        do {
            let LogOUTModel = try JSONDecoder().decode(Log_out_Model.self, from: responseData)
            print("LogOUTModel: \(LogOUTModel)")
            
            if let code = LogOUTModel.code, code == 200 {
                DispatchQueue.main.async {
                    
                    self.appCoordinator?.navigateToSignIn()
                }
                
                
            }else{
                
                DispatchQueue.main.async {
                    CustomAlert.showAlert(with: LogOUTModel.message ?? "MessageNotAvailable", in: self) {
                        
                        print("STATUS CODE Is NOt 200 - SignInVC")
                    }
                }
            }
            
            
        } catch {
            print("Error decoding response data: \(error)")
        }
    }
}
