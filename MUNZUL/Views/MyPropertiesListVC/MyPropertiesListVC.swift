//
//  MyPropertiesListVC.swift
//  MUNZUL
//
//  Created by Sonoma on 05/04/24.
//


import UIKit

class MyPropertiesListVC: UIViewController {
    
    @IBOutlet var BackGroundView: UIView!
    
    @IBOutlet weak var MyPropertiesTable: UITableView!
    
    @IBOutlet weak var ViewSort: UIView!
    
    var imageDataArray: [[String]] = [["image1", "image2", "image3"], ["image4", "image5", "image6"]]

    var appCoordinator: AppCoordinator?
    
    private var optionsView: UIView!
    private var optionsViewButton: UIView!
    private var optionsStackView: UIStackView!
  

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        MyPropertiesTable.delegate = self
        MyPropertiesTable.dataSource = self
        MyPropertiesTable.showsHorizontalScrollIndicator = false

        if let navigationController = navigationController as? UINavigationController {
            appCoordinator = AppCoordinator(navigationController: navigationController)
        }
        
        BackGroundView.backgroundColor = App.C.AppBackgroundColor

        // Register the PropertiesTableCell for the table view
       
        MyPropertiesTable.register(UINib(nibName: "PropertiesTableCell", bundle: nil), forCellReuseIdentifier: "PropertiesTableCell")
        // Set table view delegate and data source
     
        // Do any additional setup after loading the view.
        
        
    }


  
    @IBAction func ActionRentSortList(_ sender: Any) {
        print("ActionRentSortListActionRentSortList ----- Tapped")
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
        
        let buttonTitles = ["Sell", "Rent", "Auction", "Rental Auction", "RUMA", "Ongoing Rent", "Ongoing Rental Auction"]
        let buttonActions: [Selector] = [#selector(sellButtonTapped), #selector(rentButtonTapped), #selector(auctionButtonTapped), #selector(rentalAuctionButtonTapped), #selector(rumaButtonTapped), #selector(ongoingRentButtonTapped), #selector(ongoingRentalAuctionButtonTapped)]
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
        
        optionsView.topAnchor.constraint(equalTo: ViewSort.bottomAnchor, constant: 5).isActive = true
        optionsView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25).isActive = true
        optionsView.widthAnchor.constraint(equalToConstant: 135).isActive = true
        optionsView.bottomAnchor.constraint(equalTo: previousButton!.bottomAnchor, constant: 10).isActive = true
        } else {
            closeOptionsView()
        }
    }
    
    @IBAction func BckActionBtn(_ sender: Any) {
        appCoordinator?.pop(animated: true)
    }
    
    
}
// MARK: - UITableViewDataSource

extension MyPropertiesListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10 // Number of rows based on your data
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PropertiesTableCell", for: indexPath) as! PropertiesTableCell

        cell.ForSaleView.layer.cornerRadius = 13
        cell.ForSaleView.layer.masksToBounds = true

          cell.LocationText.text = "1065 6th Ave, New York, NY 10001"
          cell.ForSaleLbel.text = "FOR SALE"
 
        return cell
    }
}

// MARK: - UITableViewDelegate

extension MyPropertiesListVC: UITableViewDelegate {
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



extension MyPropertiesListVC{
   
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        if let touch = touches.first {
            if touch.view != optionsView && touch.view != MyPropertiesTable {
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
         print("Sell button tapped")
        closeOptionsView()

     }
     
     @objc private func rentButtonTapped() {
         print("Rent button tapped")
         closeOptionsView()

     }
     
     @objc private func auctionButtonTapped() {
         print("Auction button tapped")
         closeOptionsView()

     }
     
     @objc private func rentalAuctionButtonTapped() {
         print("Rental Auction button tapped")
         closeOptionsView()

     }
     
     @objc private func rumaButtonTapped() {
         print("RUMA button tapped")
         closeOptionsView()

     }
     
     @objc private func ongoingRentButtonTapped() {
         print("Ongoing Rent button tapped")
         closeOptionsView()

     }
     
     @objc private func ongoingRentalAuctionButtonTapped() {
         print("Ongoing Rental Auction button tapped")
         closeOptionsView()

     }
    
    
     
}
