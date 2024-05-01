//
//  Discover_TabVC.swift
//  MUNZUL
//
//  Created by Sonoma on 10/04/24.
//

import UIKit

class Discover_TabVC: UIViewController {

    @IBOutlet var backGroundView: UIView!
    
    @IBOutlet weak var SearchTextField: RoundedTextFieldView!
    
    @IBOutlet weak var DiscoveResultTable: UITableView!
    
    @IBOutlet weak var Hide_BtnView: UIView!
    
    @IBOutlet weak var HideFilterView: UIView!
    var appCoordinator: AppCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)

        if let navigationController = navigationController as? UINavigationController {
            appCoordinator = AppCoordinator(navigationController: navigationController)
        }
        SetUIDesignForDiscoverTab()
    }
    
    @IBAction func BckToSearchAction(_ sender: Any) {
        //Hide some view
        HideFilterView.isHidden = true
        Hide_BtnView.isHidden = true
    }
    
    
    @IBAction func FilterBtnAction(_ sender: Any) {
        appCoordinator?.BottomSheetHistoryFilterVC()

    }
    
}
// MARK: - UITableViewDataSource

extension Discover_TabVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PropertiesTableCell", for: indexPath) as! PropertiesTableCell
        
        cell.ForSaleView.layer.cornerRadius = 13
        cell.ForSaleView.layer.masksToBounds = true
          cell.LocationText.text = "1065 6th Ave, New York, NY 10001"
          cell.ForSaleLbel.text = "FOR RENT"
        return cell
    }
}

// MARK: - UITableViewDelegate

extension Discover_TabVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 320
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
extension Discover_TabVC{
    func SetUIDesignForDiscoverTab(){
        
        
        backGroundView.backgroundColor = App.C.AppBackgroundColor

        DiscoveResultTable.delegate = self
        DiscoveResultTable.dataSource = self
        DiscoveResultTable.showsHorizontalScrollIndicator = false
        DiscoveResultTable.backgroundColor = App.C.AppBackgroundColor
        DiscoveResultTable.register(UINib(nibName: "PropertiesTableCell", bundle: nil), forCellReuseIdentifier: "PropertiesTableCell")
        
        
        //set search field with result
        
        SearchTextField.hideVisibilityButton()
        SearchTextField.rightButton.isHidden = true
        SearchTextField.textField.placeholder = Localization.DiscoverSearchTitle

    }
}
