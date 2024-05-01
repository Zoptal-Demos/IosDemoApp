//
//  HistoryFilterVC.swift
//  MUNZUL
//
//  Created by Sonoma on 05/04/24.
//

import UIKit

class HistoryFilterVC: UIViewController {

    @IBOutlet var MainBackground_View: UIView!
    
    @IBOutlet weak var Image1022: UIImageView! //Done Globar Rectangular bar
    
    @IBOutlet weak var FilterHeadTxt: UILabel! //done localization
    
    @IBOutlet weak var Property_Label: UILabel! // done
    
    @IBOutlet weak var Property_Label_Min: RoundedTextFieldView! //dome
    
    @IBOutlet weak var Property_Label_Max: RoundedTextFieldView! // dome
    
    
    @IBOutlet weak var Property_2Label: UILabel!// dome
    @IBOutlet weak var Property_2Label_Min: RoundedTextFieldView!// dome
    

    @IBOutlet weak var Property_2Label_Max: RoundedTextFieldView!// dome
    
    
    @IBOutlet weak var Peroperty_l3Label_Min: RoundedTextFieldView!// dome
    


    
    @IBOutlet weak var Property_3Label_Max: RoundedTextFieldView!// dome
    
    
    @IBOutlet weak var Property_3Label: UILabel! // done
    
    
    @IBOutlet weak var Property_4Label: UILabel! //dpme
    
    
    @IBOutlet weak var Property_4Label_Min: RoundedTextFieldView!  //dpme
    
    
    //Additional Feature Section with Colelction view
    
    @IBOutlet weak var Additional_Feature_Title: UILabel!
    
    
    @IBOutlet weak var Additional_FeatureSelection: UICollectionView!
    
    
    // peroperty tyep
    
    
    @IBOutlet weak var Property_Type_Head: UILabel!
    
    @IBOutlet weak var Select_ForSale: RoundedTextFieldView!
    
    @IBOutlet weak var Select_Home_type: RoundedTextFieldView!
    
    
    @IBOutlet weak var Price_RangeTextField: RoundedTextFieldView!
    
    
    
    @IBOutlet weak var ApplyFilter_Btn: RoundedButtonUI!
    
 
    
    let flowLayout = UICollectionViewFlowLayout()

    var appCoordinator: AppCoordinator?

    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)

        if let navigationController = navigationController as? UINavigationController {
            appCoordinator = AppCoordinator(navigationController: navigationController)
        }
        MainBackground_View.backgroundColor = App.C.AppBackgroundColor
        

        UpdateUIDesignFilterVC()
        
        setupCollectionView()
    }

    
    
    
// MARK: - Rectangular Btn Tapped HistoryFilterVC
    @IBAction func RectangleBarBtnTapped(_ sender: Any) {
        
        print("Rectangular Btn Tapped HistoryFilterVC")
        
    }
    
    @IBAction func CrossBtnAction(_ sender: Any) {
        print("CrossBtnAction HistoryFilterVC")

        appCoordinator?.pop(animated: true)
    }
}



extension HistoryFilterVC{
    
    
   func UpdateUIDesignFilterVC(){

       Image1022.image = App.Images.RectangularBar
       
       FilterHeadTxt.text = Localization.Property_LabelTitle
       
       Additional_Feature_Title.text = Localization.Additional_Title

       Property_Label.text = Localization.Property_LabelTitle
       
       FilterHeadTxt.text = Localization.FilterHeadTitle
    
       Property_Label_Min.textField.placeholder = Localization.MinimunTitle
       Property_Label_Max.textField.placeholder = Localization.maximunTitle

       Property_2Label_Min.textField.placeholder = Localization.MinimunTitle
       Property_2Label_Max.textField.placeholder = Localization.maximunTitle
       
       Peroperty_l3Label_Min.textField.placeholder = Localization.MinimunTitle
       Peroperty_l3Label_Min.textField.placeholder = Localization.maximunTitle
       Property_3Label_Max.textField.placeholder = Localization.maximunTitle

       Property_2Label.text = Localization.Property_2LabelTitle
       Property_3Label.text = Localization.Property_3LabelTitle
       
       
       
       Property_4Label.text = Localization.Property_4LabelTitle
       Property_4Label_Min.textField.placeholder = Localization.HOA_FeeTitle

       //Hide email right btn + Setup plaeholder + font
       Select_ForSale.hideVisibilityButton()
       Property_Label_Min.hideVisibilityButton()
       Property_Label_Max.hideVisibilityButton()
       Property_2Label_Min.hideVisibilityButton()
       Property_2Label_Max.hideVisibilityButton()
       Property_3Label_Max.hideVisibilityButton()
       Peroperty_l3Label_Min.hideVisibilityButton()

       
       Property_4Label_Min.hideVisibilityButton()
       Select_Home_type.hideVisibilityButton()
       Price_RangeTextField.hideVisibilityButton()
       
       Select_ForSale.rightButton.isHidden = true
       Property_Label_Min.rightButton.isHidden = true
       Property_Label_Max.rightButton.isHidden = true
       Property_2Label_Min.rightButton.isHidden = true
       Property_2Label_Max.rightButton.isHidden = true
       Property_3Label_Max.rightButton.isHidden = true
       Peroperty_l3Label_Min.rightButton.isHidden = true
       
       Property_4Label_Min.rightButton.isHidden = true
       Select_Home_type.rightButton.isHidden = true
                 
       Price_RangeTextField.rightButton.isHidden = true

   
//Property type details
       
       
       Property_Type_Head.text = Localization.Property_Title
       Select_ForSale.textField.placeholder = Localization.Select_ForSaleTitle
       Select_Home_type.textField.placeholder = Localization.Home_typeTitle
       Price_RangeTextField.textField.placeholder = Localization.Price_range_title

       
       ApplyFilter_Btn.setLabelText(Localization.Submit, textColor: App.C.AppWhiteBackground )
       ApplyFilter_Btn.viewColor = App.C.BtnColor0898
       
       
       ApplyFilter_Btn.button.addTarget(self, action: #selector(submitButtonAction), for: .touchUpInside)
       ApplyFilter_Btn.viewColor = App.C.BtnColor0898
       ApplyFilter_Btn.borderColor = App.C.BtnColor0898
       ApplyFilter_Btn.borderWidth = 1.0
       
   }
    @objc func submitButtonAction() {
         print("submitButtonAction Pressed - HistoryFilterVc")
         
  }
}
extension HistoryFilterVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func setupCollectionView() {
        Additional_FeatureSelection.register(UINib(nibName: "CollectionSelectionCell", bundle: nil), forCellWithReuseIdentifier: "CollectionSelectionCell")
        
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        
        Additional_FeatureSelection.collectionViewLayout = flowLayout
        Additional_FeatureSelection.delegate = self
        Additional_FeatureSelection.dataSource = self
    }
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // Return the number of items in your collection view
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Configure your collection view cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionSelectionCell", for: indexPath) as! CollectionSelectionCell
        switch indexPath.item {
         case 0:
             cell.labelTxt.text = "Swimming Pool"
         case 1:
             cell.labelTxt.text = "Gas"
         case 2:
             cell.labelTxt.text = "Heating"
         case 3:
             cell.labelTxt.text = "Air Conditioner"
         case 4:
             cell.labelTxt.text = "Other"
         default:
             break
         }
        return cell
    }

}
extension HistoryFilterVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Calculate the size based on the content of the label and tick mark
        let cellPadding: CGFloat = 10 // Adjust padding as needed
        let labelWidth = collectionView.bounds.width - cellPadding * 3 // Subtracting padding from both sides
        let cellHeight: CGFloat = 40 // Adjust height as needed
        
        return CGSize(width: labelWidth, height: cellHeight)
    }
    
}
