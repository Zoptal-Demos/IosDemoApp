//
//  TabBarCustom.swift
//  MUNZUL
//
//  Created by Navdeep Singh on 14/03/24.
//

import UIKit

class TabBarCustom: UIViewController {
    @IBOutlet weak var TabBarViewBottom: UIView!
    @IBOutlet var TabButtons: [UIButton]!
    @IBOutlet weak var ContainerView: UIView!
    @IBOutlet var TapImages: [UIImageView]!
    
    var appCoordinator: AppCoordinator?
    var viewControllers = [UIViewController]()
    var currentViewController: UIViewController?
    let unselectedTabImages = [ "Profile_Unselected", "Message_Icon", "Profile_icon", "Discover_Icon","Home_Icon"]
    let selectedTabImages = ["Plus_Icon", "Message_selected", "Profile_icon", "Discover_Selected", "Home_Selected_icon"]
    
    
    static let HomeTabBtn = ProfileTapVC(nibName: "ProfileTapVC", bundle: nil) //Profile
    static let DiscoverTabBtn = MyMessagesVC(nibName: "MyMessagesVC", bundle: nil) //Messages
    static let PlusTabBtn = MyProfileVC(nibName: "MyProfileVC", bundle: nil) // Plus
    static let MessagesTabBtn = Discover_TabVC(nibName: "Discover_TabVC", bundle: nil) //Discover
    static let ProfileTabBtn = RecoverVC(nibName: "RecoverVC", bundle: nil)//Home
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        view.bringSubviewToFront(TabBarViewBottom)
        
        for button in TabButtons {
            button.addTarget(self, action: #selector(tabButtonTapped(_:)), for: .touchUpInside)
        }
        viewControllers.append(TabBarCustom.HomeTabBtn)
        viewControllers.append(TabBarCustom.DiscoverTabBtn)
        viewControllers.append(TabBarCustom.PlusTabBtn)
        viewControllers.append(TabBarCustom.MessagesTabBtn)
        viewControllers.append(TabBarCustom.ProfileTabBtn)
        
        // Load the initial view controller
        loadInitialViewController()
    }
    
    func loadInitialViewController() {
        // Assuming you want to load the first view controller initially
        if let initialViewController = viewControllers.first {
            displayViewController(initialViewController, at: 0)
        }
    }
    
    
    @objc func tabButtonTapped(_ sender: UIButton) {
        guard let tabIndex = TabButtons.firstIndex(of: sender) else {
            return
        }
        guard tabIndex >= 0 && tabIndex < viewControllers.count else {
            return
        }
        displayViewController(viewControllers[tabIndex], at: tabIndex)
    }
    
    func displayViewController(_ viewController: UIViewController, at index: Int) {
        // Update tab bar images
        for (i, imageView) in TapImages.enumerated() {
            imageView.image = UIImage(named: i == index ? selectedTabImages[i] : unselectedTabImages[i])
        }

        // Remove the current view controller from its parent
        currentViewController?.willMove(toParent: nil)
        currentViewController?.view.removeFromSuperview()
        currentViewController?.removeFromParent()

        // Add and display the new view controller
        currentViewController = viewController
        addChild(currentViewController!)
        currentViewController!.view.frame = ContainerView.bounds
        ContainerView.addSubview(currentViewController!.view)
        currentViewController!.didMove(toParent: self)
        ContainerView.bringSubviewToFront(TabBarViewBottom)
        
    }

}
