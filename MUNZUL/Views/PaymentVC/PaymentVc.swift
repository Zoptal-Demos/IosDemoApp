//
//  PaymentVc.swift
//  MUNZUL
//
//  Created by Sonoma on 05/04/24.
//

import UIKit

class PaymentVc: UIViewController {

    
    var appCoordinator: AppCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        if let navigationController = navigationController as? UINavigationController {
            appCoordinator = AppCoordinator(navigationController: navigationController)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func ActionBckBtn(_ sender: Any) {
        appCoordinator?.pop(animated: true)

    }
}
