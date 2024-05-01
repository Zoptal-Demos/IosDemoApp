//
//  MyBiddingListVC.swift
//  MUNZUL
//
//  Created by Sonoma on 05/04/24.
//

import UIKit

class MyBiddingListVC: UIViewController {
    
    
    @IBOutlet var bckGroundmain: UIView!
    
    
    @IBOutlet weak var SortView: UIView!
    
    @IBOutlet weak var MyBiddingTable: UITableView!
    
    private var optionsView: UIView!
    private var optionsViewButton: UIView!
    private var optionsStackView: UIStackView!
  

    
    var imageDataArray: [[String]] = [["image1", "image2", "image3"], ["image4", "image5", "image6"]]

    
    var appCoordinator: AppCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        if let navigationController = navigationController as? UINavigationController {
            appCoordinator = AppCoordinator(navigationController: navigationController)
        }
        
        MyBiddingTable.delegate = self
        MyBiddingTable.dataSource = self
        MyBiddingTable.showsHorizontalScrollIndicator = false
        bckGroundmain.backgroundColor = App.C.AppBackgroundColor
        MyBiddingTable.register(UINib(nibName: "PropertiesTableCell", bundle: nil), forCellReuseIdentifier: "PropertiesTableCell")

        // Do any additional setup after loading the view.
    }

    @IBAction func ActionRentalList(_ sender: Any) {
        print("ActionRentalListActionRentalList ----- Tapped ")
        if optionsView == nil {

        optionsView = UIView()
        optionsView?.backgroundColor = .white
        optionsView?.layer.cornerRadius = 8
        optionsView?.layer.borderWidth = 1.0
        optionsView?.layer.borderColor = UIColor.clear.cgColor
        optionsView?.translatesAutoresizingMaskIntoConstraints = false
        optionsView?.backgroundColor = .white
        optionsView?.layer.shadowColor = UIColor.black.cgColor
        optionsView?.layer.shadowOpacity = 0.2
        optionsView?.layer.shadowOffset = CGSize(width: 0, height: 2)
        optionsView?.layer.shadowRadius = 4
        
        let buttonTitles = ["Sale Auction", "Rental Auction", "Rented Properties"]
        let buttonActions: [Selector] = [#selector(sellButtonTapped), #selector(rentButtonTapped), #selector(auctionButtonTapped)]
        var previousButton: UIButton?
        
        for (title, action) in zip(buttonTitles, buttonActions) {
            let button = UIButton(type: .system)
            button.setTitle(title, for: .normal)
            button.titleLabel?.font = UIFont(name: "Poppins-Regular", size: 12) ?? UIFont.systemFont(ofSize: 12)
            let customColor = UIColor(red: 86/255, green: 83/255, blue: 91/255, alpha: 0.90)
            button.setTitleColor(customColor, for: .normal)
            button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 0, bottom: 5, right: 0)
            button.addTarget(self, action: action, for: .touchUpInside)
            optionsView?.addSubview(button)
            
            button.translatesAutoresizingMaskIntoConstraints = false
            button.leadingAnchor.constraint(equalTo: optionsView!.leadingAnchor).isActive = true
            button.trailingAnchor.constraint(equalTo: optionsView!.trailingAnchor).isActive = true
            button.heightAnchor.constraint(equalToConstant: 30).isActive = true
            
            if let prevButton = previousButton {
                button.topAnchor.constraint(equalTo: prevButton.bottomAnchor, constant: 10).isActive = true
            } else {
                button.topAnchor.constraint(equalTo: optionsView!.topAnchor, constant: 10).isActive = true
            }
            
            previousButton = button
        }
        
        guard let optionsView = optionsView else { return }
        
        view.addSubview(optionsView)
        
        optionsView.topAnchor.constraint(equalTo: SortView.bottomAnchor, constant: 5).isActive = true
        optionsView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25).isActive = true
        optionsView.widthAnchor.constraint(equalToConstant: 135).isActive = true
        optionsView.bottomAnchor.constraint(equalTo: previousButton!.bottomAnchor, constant: 10).isActive = true
        } else {
            closeOptionsView()
        }
    }
    
    @IBAction func ActionBckBtn(_ sender: Any) {
        appCoordinator?.pop(animated: true)
    }

}
// MARK: - UITableViewDataSource

extension MyBiddingListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10 // Number of rows based on your data
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PropertiesTableCell", for: indexPath) as! PropertiesTableCell
        cell.ForSaleView.isHidden = true
        
//        cell.ForSaleView.layer.cornerRadius = 13
//        cell.ForSaleView.layer.masksToBounds = true

          cell.LocationText.text = "1065 6th Ave, New York, NY 10001"
 
        return cell
    }
}

// MARK: - UITableViewDelegate

extension MyBiddingListVC: UITableViewDelegate {
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
extension MyBiddingListVC{
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        if let touch = touches.first {
            if touch.view != optionsView && touch.view != MyBiddingTable {
                closeOptionsView()
            }
        }
    }
      
      private func closeOptionsView() {
          UIView.animate(withDuration: 0.3, animations: {
              self.optionsView?.alpha = 0
          }) { _ in
              self.optionsView?.removeFromSuperview()
              self.optionsView = nil
          }
      }
    @objc private func sellButtonTapped() {
         print(" Sell Auction button tapped")
        closeOptionsView()

     }
     
     @objc private func rentButtonTapped() {
         print("Rental Auction button tapped")
         closeOptionsView()

     }
     
     @objc private func auctionButtonTapped() {
         print("Rented Properties tapped")
         closeOptionsView()

     }
}
