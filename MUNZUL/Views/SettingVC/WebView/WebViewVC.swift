//
//  WebViewVC.swift
//  MUNZUL
//
//  Created by Sonoma on 01/04/24.
//

import UIKit


class WebViewVC: UIViewController {

    @IBOutlet weak var HeaderTitle: UILabel!
    
    
    
    
    
    enum WebPageType {
            case termsOfUse
            case privacyPolicy
            case about
        }

    var WebPageSetUp: WebPageType = .termsOfUse
    var appCoordinator: AppCoordinator?

    override func viewDidLoad() {
          super.viewDidLoad()
        if let navigationController = navigationController as? UINavigationController {
            appCoordinator = AppCoordinator(navigationController: navigationController)
        }
          // Set up the web page based on the WebPageSetUp enum value
          switch WebPageSetUp {
          case .termsOfUse:
              HeaderTitle.text = "Terms of Use"
          case .privacyPolicy:
              HeaderTitle.text = "Privacy Policy"
          case .about:
              HeaderTitle.text = "About"
          }
      }
    
    @IBAction func ActionBckBtn(_ sender: Any) {
        appCoordinator?.pop(animated: true)
    }
    
    
    
  }
    
   
 

   


