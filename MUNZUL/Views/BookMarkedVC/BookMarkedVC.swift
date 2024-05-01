//
//  BookMarkedVC.swift
//  MUNZUL
//
//  Created by Sonoma on 05/04/24.
//

import UIKit

class BookMarkedVC: UIViewController {

    @IBOutlet var MainBckGround: UIView!
    
    @IBOutlet weak var SavedTable: UITableView!
    
    var appCoordinator: AppCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        if let navigationController = navigationController as? UINavigationController {
            appCoordinator = AppCoordinator(navigationController: navigationController)
        }
        
        MainBckGround.backgroundColor = App.C.AppBackgroundColor

        SavedTable.delegate = self
        SavedTable.dataSource = self
        SavedTable.showsHorizontalScrollIndicator = false
        SavedTable.backgroundColor = App.C.AppBackgroundColor
        SavedTable.register(UINib(nibName: "PropertiesTableCell", bundle: nil), forCellReuseIdentifier: "PropertiesTableCell")
        
    }
    @IBAction func ActionBckBtn(_ sender: Any) {
        appCoordinator?.pop(animated: true)
    }
 

}
// MARK: - UITableViewDataSource

extension BookMarkedVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10 // Number of rows based on your data
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

extension BookMarkedVC: UITableViewDelegate {
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
