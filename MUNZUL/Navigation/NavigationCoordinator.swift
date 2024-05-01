//
//  NavigationCoordinator.swift
//  MUNZUL
//
//  Created by Navdeep Singh on 06/03/24.
//

import Foundation
import SwiftUI
import UIKit


protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get set }
    var parentCoordinator: Coordinator? { get set }
    var children:[Coordinator]{ get set }
    func start()
}

class AppCoordinator: Coordinator {
 
    
    weak var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    internal var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let onboardingVC = instantiateViewController(OnboardingScreen.self)
        navigationController.pushViewController(onboardingVC, animated: true)
    }

    func NavigateToProfileTab() {
        let profileTapVC = ProfileTapVC()
        profileTapVC.navigationItem.hidesBackButton = true
        navigationController.pushViewController(profileTapVC, animated: true)
    }
    
    func NavigateSelectedFrame(delegate: UIFrameSetUpDelegate) {
        let uiFrameSetUp = UIFrameSetUp(nibName: "UIFrameSetUp", bundle: nil)
        uiFrameSetUp.navigationItem.hidesBackButton = true
        uiFrameSetUp.delegate = delegate
        navigationController.present(uiFrameSetUp, animated: true)
    }

    func NavigateToEditProfile(profileData: [Profile_JSON]){
        let EditProfileDetail: EditProfileDetail = instantiateViewController(EditProfileDetail.self, fromNib: true)
        EditProfileDetail.profileData = profileData 
        EditProfileDetail.navigationItem.hidesBackButton = true
        navigationController.pushViewController(EditProfileDetail, animated: true)

    }
    
    func NavigateToEditCompany(profileData: [Profile_JSON]){
        let EditCompanyDetails: EditCompanyDetails = instantiateViewController(EditCompanyDetails.self, fromNib: true)
        EditCompanyDetails.profileData = profileData
        EditCompanyDetails.navigationItem.hidesBackButton = true
        navigationController.pushViewController(EditCompanyDetails, animated: true)

    }
    
    func NavigateToMyPropertiesListVC(){
        let MyPropertiesListVC: MyPropertiesListVC = instantiateViewController(MyPropertiesListVC.self, fromNib: true)
        MyPropertiesListVC.navigationItem.hidesBackButton = true
        navigationController.pushViewController(MyPropertiesListVC, animated: true)

    }
    func NavigateToMyBiddingsListVC(){
        let MyBiddingListVC: MyBiddingListVC = instantiateViewController(MyBiddingListVC.self, fromNib: true)
        MyBiddingListVC.navigationItem.hidesBackButton = true
        navigationController.pushViewController(MyBiddingListVC, animated: true)

    }
    func NavigateToHistoryList(){
        let MyHistoryVC: MyHistoryVC = instantiateViewController(MyHistoryVC.self, fromNib: true)
        MyHistoryVC.navigationItem.hidesBackButton = true
        navigationController.pushViewController(MyHistoryVC, animated: true)

    }
    func NavigateToPaymentVc(){
        let PaymentVc: PaymentVc = instantiateViewController(PaymentVc.self, fromNib: true)
        PaymentVc.navigationItem.hidesBackButton = true
        navigationController.pushViewController(PaymentVc, animated: true)

    }
    
    
  
    
    func NavigateToBookMarkedVC(){
        let BookMarkedVC: BookMarkedVC = instantiateViewController(BookMarkedVC.self, fromNib: true)
        BookMarkedVC.navigationItem.hidesBackButton = true
        navigationController.pushViewController(BookMarkedVC, animated: true)

    }
    
    func BottomSheetHistoryFilterVC(){
        let HistoryFilterVC: HistoryFilterVC = instantiateViewController(HistoryFilterVC.self, fromNib: true)

        HistoryFilterVC.navigationItem.hidesBackButton = true
        if let presentationController = HistoryFilterVC.presentationController as? UISheetPresentationController {
            presentationController.detents = [.medium(), .large()]
        }
        navigationController.present(HistoryFilterVC, animated: true, completion: nil)

    }
    
    func NavigateToTabBar(){
        let tabBarCustom = instantiateViewController(TabBarCustom.self, fromNib: true)
        tabBarCustom.appCoordinator = self
        navigationController.setViewControllers([tabBarCustom], animated: false)
    }
    
    func navigateToSignIn() {
        let signInVC: SignInVC = instantiateViewController(SignInVC.self, fromNib: true)
        signInVC.navigationItem.hidesBackButton = true
        signInVC.authenticationType = .signIn
        navigationController.pushViewController(signInVC, animated: true)
    }
    
    func RecoverVC() {
        
        let recoverVC = MUNZUL.RecoverVC(nibName: "RecoverVC", bundle: nil)
        recoverVC.navigationItem.hidesBackButton = true
        navigationController.pushViewController(recoverVC, animated: true)
        
    }
    func NavigateToSettingVC() {
        let SettingVC = MUNZUL.SettingVc(nibName: "SettingVc", bundle: nil)
        SettingVC.navigationItem.hidesBackButton = true
        navigationController.pushViewController(SettingVC, animated: true)
    }
 
    func NavigateToChangePasswordVC() {
        let ChangePasswordVC = MUNZUL.ChangePasswordVC(nibName: "ChangePasswordVC", bundle: nil)
        ChangePasswordVC.navigationItem.hidesBackButton = true
        navigationController.pushViewController(ChangePasswordVC, animated: true)
    }
    
    
    func NavigateToHelpAndSupportVC() {
        let HelpAndSupportVC = MUNZUL.HelpAndSupportVC(nibName: "HelpAndSupportVC", bundle: nil)
        HelpAndSupportVC.navigationItem.hidesBackButton = true
        navigationController.pushViewController(HelpAndSupportVC, animated: true)
    }
    
    func NavigateToTermOfUse() {
        let TermOfUseVC = MUNZUL.WebViewVC(nibName: "WebViewVC", bundle: nil)
        TermOfUseVC.navigationItem.hidesBackButton = true
        TermOfUseVC.WebPageSetUp = .termsOfUse
        navigationController.pushViewController(TermOfUseVC, animated: true)
    }
    
    func NavigateToPrivacyPolicy() {
        let PrivacyPolicyVC = MUNZUL.WebViewVC(nibName: "WebViewVC", bundle: nil)
        PrivacyPolicyVC.navigationItem.hidesBackButton = true
        PrivacyPolicyVC.WebPageSetUp = .privacyPolicy

        navigationController.pushViewController(PrivacyPolicyVC, animated: true)
    }
    
    func NavigateToAboutMunZul() {
        let AboutMunzulVC = MUNZUL.WebViewVC(nibName: "WebViewVC", bundle: nil)
        AboutMunzulVC.WebPageSetUp = .about
        AboutMunzulVC.navigationItem.hidesBackButton = true
        navigationController.pushViewController(AboutMunzulVC, animated: true)
    }
    
    
    
    
    
    
    
    
    
    
    func NavigateToNotificationSettingVC() {
        let NotificationSettingVC = MUNZUL.NotificationSettingVC(nibName: "NotificationSettingVC", bundle: nil)
        NotificationSettingVC.navigationItem.hidesBackButton = true
        navigationController.pushViewController(NotificationSettingVC, animated: true)
    }
    func NavigateToLocationSetting() {
        let LocationSetting = MUNZUL.LocationSetting(nibName: "LocationSetting", bundle: nil)
        LocationSetting.navigationItem.hidesBackButton = true
        navigationController.pushViewController(LocationSetting, animated: true)
    }
    
    func MyProfileVC() {
        let MyProfileVC = MUNZUL.MyProfileVC(nibName: "MyProfileVC", bundle: nil)
        MyProfileVC.navigationItem.hidesBackButton = true
        navigationController.pushViewController(MyProfileVC, animated: true)
       
    }
    
    //MARK: - NavigateTo-(SetPasswordVC)
    func NavigateToSetPassword() {
        let setpasswordVC: SetPasswordVC = instantiateViewController(SetPasswordVC.self, fromNib: true)
        setpasswordVC.navigationItem.hidesBackButton = true
        navigationController.pushViewController(setpasswordVC, animated: true)
    }
    
    func VerifyOtp(email: String) {
        let verifyOtpVC: VerifyOtpVC = instantiateViewController(VerifyOtpVC.self, fromNib: true)
        verifyOtpVC.navigationItem.hidesBackButton = true
        verifyOtpVC.email = email // Pass the current email text
        navigationController.pushViewController(verifyOtpVC, animated: true)
    }
    
    
    
    func pop(animated: Bool) {
        navigationController.popViewController(animated: animated)
    }
    
    private func instantiateViewController<T: UIViewController>(_ type: T.Type, fromNib: Bool = false) -> T {
        let identifier = String(describing: type)
        if fromNib {
            return T(nibName: identifier, bundle: nil)
        } else {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            return storyboard.instantiateViewController(withIdentifier: identifier) as! T
        }
    }
}

