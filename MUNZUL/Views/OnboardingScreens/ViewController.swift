//
//  ViewController.swift
//  MUNZUL
//
//  Created by Navdeep Singh on 05/03/24.
//

import UIKit
import SnapKit
import CoreLocation

class OnboardingScreen: UIViewController {
    @IBOutlet weak var CollectionOnboarding: UICollectionView!
    @IBOutlet weak var BottomView: UIView!
    @IBOutlet weak var PageControl: UIPageControl!
    @IBOutlet weak var SkipBtnView: UIView!
    @IBOutlet weak var NxtBtnView: UIView!
    @IBOutlet weak var ViewForHide: UIView!
    @IBOutlet weak var GettingStartedView: UIView!
    @IBOutlet weak var ViewBtns: UIStackView!
     
    @IBOutlet weak var LblTxtGettingStarted: UILabel!
    let flowLayout = UICollectionViewFlowLayout()
    var currentPage: Int = 0
//    let locationManager = CLLocationManager()
//    var selectedLatitude: Double = 0.0
//    var selectedLongitude: Double = 0.0
    var appCoordinator: AppCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
        print("View Did load -: OnboardingScreen")
        ViewForHide.isHidden = true
        if let navigationController = navigationController as? UINavigationController {
                 appCoordinator = AppCoordinator(navigationController: navigationController)
             }
//        locationManager.delegate = self
//          locationManager.requestWhenInUseAuthorization()
//          locationManager.startUpdatingLocation()
        
//        LocationManager.shared.requestLocationAtOnce()
        
        layoutSetup()
        setupCollectionView()
    }
    
    func layoutSetup(){
        let buttonSize = CGSize(width: 73, height: 49)
        let GettingBtn = CGSize(width: 327, height: 56)
        GettingStartedView.backgroundColor = App.C.BtnColor0898
        NxtBtnView.backgroundColor = App.C.BtnColor0898
        SkipBtnView.backgroundColor = App.C.BtnColor0898
        configureButton(SkipBtnView, withSize: buttonSize)
        configureButton(NxtBtnView, withSize: buttonSize)
        configureButton(GettingStartedView, withSize: GettingBtn)
        
    }
    
    //MARK: -  ActionGettingStarted

    
    @IBAction func ActionGettingStarted(_ sender: Any) {
        print("Tapped on GettingStarted")
        appCoordinator?.navigateToSignIn()
    }
  
    //MARK: -  NextBtnAction

    @IBAction func NextBtnAction(_ sender: Any) {
        print("tapped on NextBtnAction")
             currentPage += 1
             if currentPage < CollectionOnboarding.numberOfItems(inSection: 0) {
                 let nextIndexPath = IndexPath(item: currentPage, section: 0)
                 CollectionOnboarding.scrollToItem(at: nextIndexPath, at: .centeredHorizontally, animated: true)
                 
                 PageControl.currentPage = currentPage
             } else {
                 currentPage = 0
                 let firstIndexPath = IndexPath(item: currentPage, section: 0)
                 CollectionOnboarding.scrollToItem(at: firstIndexPath, at: .centeredHorizontally, animated: true)
                 
                 PageControl.currentPage = currentPage
             }
             
             // Check if it's the last page to hide/show the appropriate views
             if currentPage == CollectionOnboarding.numberOfItems(inSection: 0) - 1 {
                 ViewBtns.isHidden = true
                 ViewForHide.isHidden = false
             } else {
                 ViewBtns.isHidden = false
                 ViewForHide.isHidden = true
             }
    }


    //MARK: -  SkipAction-btn

    
    @IBAction func SkipAction(_ sender: Any) {
        print("tapped on SkipAction")
        // Scroll to the last cell directly
             let lastIndexPath = IndexPath(item: CollectionOnboarding.numberOfItems(inSection: 0) - 1, section: 0)
             CollectionOnboarding.scrollToItem(at: lastIndexPath, at: .centeredHorizontally, animated: true)

             // Update the current page and PageControl
             currentPage = lastIndexPath.item
             PageControl.currentPage = currentPage
             
             if currentPage == CollectionOnboarding.numberOfItems(inSection: 0) - 1 {
                 ViewBtns.isHidden = true
                 ViewForHide.isHidden = false
             } else {
                 ViewBtns.isHidden = false
                 ViewForHide.isHidden = true
             }
         }
    
    //MARK: -  SetButtonSize with size- NextBtn/ SkipBtn
    func configureButton(_ button: UIView, withSize size: CGSize) {
        let cornerRadius = min(size.width, size.height) / 2
        button.frame.size = size
        button.layer.cornerRadius = cornerRadius
    }
   
    //MARK: -  setupCollectionView

    func setupCollectionView() {
        // Configure PageControl
        PageControl.numberOfPages = 3
        PageControl.pageIndicatorTintColor = UIColor(red: 2/255, green: 145/255, blue: 154/255, alpha: 0.1)
        PageControl.currentPageIndicatorTintColor = UIColor(red: 2/255, green: 145/255, blue: 154/255, alpha: 1.0)

        // Configure Flow Layout
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 20
        flowLayout.scrollDirection = .horizontal

        CollectionOnboarding.delegate = self
        CollectionOnboarding.dataSource = self
        CollectionOnboarding.collectionViewLayout = flowLayout
        CollectionOnboarding.reloadData()
       
    }

}
//MARK: -  extension - OnboardingScreen -collection

extension OnboardingScreen: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,UIScrollViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OnboardingCollectionCell", for: indexPath) as! OnboardingCollectionCell
        
        switch indexPath.item {
        case 0:
            cell.OnBoardingImages.image = App.Images.onBoardingScreen0

            cell.LblText1.text = Localization.ScreenTxt0
            cell.LblText1.font = App.F.ScreenFont0
            cell.LblText1.textColor = App.C.ScreenColor

            
            cell.LblText2.text = Localization.LblTxt0
            cell.LblText2.font = App.F.ScreenFont1
            cell.LblText2.textColor = App.C.DescriptionColor

        case 1:
            cell.OnBoardingImages.image = App.Images.onBoardingScreen1

            cell.LblText1.text = Localization.ScreenTxt1
            cell.LblText1.font = App.F.ScreenFont0
            cell.LblText1.textColor = App.C.ScreenColor

            cell.LblText2.text = Localization.LblTxt1
            cell.LblText2.font = App.F.ScreenFont1
            cell.LblText2.textColor = App.C.DescriptionColor

            
        case 2:
            cell.OnBoardingImages.image = App.Images.onBoardingScreen2
            cell.LblText1.text = Localization.ScreenTxt2
            cell.LblText1.font = App.F.ScreenFont0
            cell.LblText1.textColor = App.C.ScreenColor

            cell.LblText2.text = Localization.LblTxt2
            cell.LblText2.font = App.F.ScreenFont1
            cell.LblText2.textColor = App.C.DescriptionColor

            
        default:
            break
        }
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.size.width
        let height = collectionView.frame.size.height
        return CGSize(width: width, height: height)
        
    }
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let currentPage = Int(scrollView.contentOffset.x / scrollView.frame.width)
              PageControl.currentPage = currentPage
              
              // Check if it's the last page to hide/show the appropriate views
              if currentPage == CollectionOnboarding.numberOfItems(inSection: 0) - 1 {
                  ViewBtns.isHidden = true
                  ViewForHide.isHidden = false
              } else {
                  ViewBtns.isHidden = false
                  ViewForHide.isHidden = true
              }
          }
    
}
