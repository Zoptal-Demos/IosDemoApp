//
//  MyMessagesVC.swift
//  MUNZUL
//
//  Created by Sonoma on 10/04/24.
//

import UIKit

class MyMessagesVC: UIViewController {

    
    @IBOutlet var MainBackGroundView: UIView!
    
    @IBOutlet weak var SearchMessagesField: RoundedTextFieldView!
    
    @IBOutlet weak var MessagesTableView: UITableView!
    
  
    var cellData: [[String: String]] = [
         ["imageName": "Background_Sign", "labelText": "My Properties"],
         ["imageName": "Background_Sign", "labelText": "My Biddings"],
         ["imageName": "Background_Sign", "labelText": "History"],
         ["imageName": "Background_Sign", "labelText": "Bookmarked"],
         ["imageName": "Background_Sign", "labelText": "About Us"],
         ["imageName": "Background_Sign", "labelText": "Payment"],
         ["imageName": "Background_Sign", "labelText": "Additional Info"],
         ["imageName": "Background_Sign", "labelText": "Settings"]
     ]
    var appCoordinator: AppCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)

        if let navigationController = navigationController as? UINavigationController {
            appCoordinator = AppCoordinator(navigationController: navigationController)
        }
        
        SetUIDesignForMyMessagesVCTab()
        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

// MARK: - UITableViewDataSource

extension MyMessagesVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessagesTableCell", for: indexPath) as! MessagesTableCell
        
        
        let data = cellData[indexPath.row]
        
       
        if let imageName = data["imageName"] {
            cell.UserPictureProfile.setImage(UIImage(named: imageName))
        }
        if let labelText = data["labelText"] {
            cell.UserNameLbl.text = labelText
        }
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension MyMessagesVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
         return 40
     }
     
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        
        return headerView
    }
}
extension MyMessagesVC{
    func SetUIDesignForMyMessagesVCTab(){
        
        
        MainBackGroundView.backgroundColor = App.C.AppBackgroundColor

        MessagesTableView.delegate = self
        MessagesTableView.dataSource = self
        MessagesTableView.showsHorizontalScrollIndicator = false
        MessagesTableView.backgroundColor = App.C.AppBackgroundColor
        MessagesTableView.register(UINib(nibName: "MessagesTableCell", bundle: nil), forCellReuseIdentifier: "MessagesTableCell")
        
        
        //set search field with result
        
        SearchMessagesField.hideVisibilityButton()
        SearchMessagesField.rightButton.isHidden = true
        SearchMessagesField.textField.placeholder = Localization.MessagesSearchTitle

    }
}
