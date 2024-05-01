//
//  PropertiesTableCell.swift
//  MUNZUL
//
//  Created by Sonoma on 05/04/24.
//

import UIKit

class PropertiesTableCell: UITableViewCell {

    @IBOutlet weak var CollectionImagesProperties: UICollectionView!
    
    @IBOutlet weak var CellCornerRadius: UIView!
    @IBOutlet weak var LabelSale: UILabel!
    
    @IBOutlet weak var LabelTxtDollor: UILabel!

    @IBOutlet weak var LocationImage: UIImageView!
    
    @IBOutlet weak var LocationText: UILabel!
    
    @IBOutlet weak var BookMarkImage: UIImageView!
    
    @IBOutlet weak var BookMarked_Btn: UIButton!
    
    @IBOutlet weak var ForSaleView: UIView!
    
    @IBOutlet weak var ForSaleLbel: UILabel!
    
    @IBOutlet weak var ImagesCornerRadiusView: UIView!
    @IBOutlet weak var ImagesCollectionViewStack: UIView!
    var ImageDataArray: [String] = []

    
    let flowLayout = UICollectionViewFlowLayout()

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        ImagesCornerRadiusView.layer.cornerRadius = 15
        ImagesCornerRadiusView.layer.masksToBounds = true
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 0, bottom: 25, right: 0))

        CellCornerRadius.layer.cornerRadius = 15
        CellCornerRadius.layer.masksToBounds = true

        CollectionImagesProperties.register(UINib(nibName: "ImageCollection", bundle: nil), forCellWithReuseIdentifier: "ImageCollection")

        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        let modelName = UIDevice.current.modelName //Simulator - iPhone14,2
        // Set the RatingTopHeight based on the device model
        if modelName == "iPhone12,1" || modelName == "iPhone12,3" || modelName == "iPhone12,5" || modelName == "iPhone13,1" || modelName == "iPhone13,2" || modelName == "iPhone11,8" || modelName == "iPhone12,8" || modelName == "iPhone13,1" || modelName == "iPhone13,2" || modelName == "iPhone13,3" || modelName == "iPhone13,4" || modelName == "iPhone14,4" || modelName == "iPhone14,5" || modelName == "Simulator" || modelName == "iPhone14,3" || modelName == "iPhone15,5"{
            
      
            flowLayout.itemSize = CGSize(width: self.ImagesCollectionViewStack.bounds.width + 65 , height: self.ImagesCollectionViewStack.bounds.height)

        } else {
            flowLayout.itemSize = CGSize(width: self.ImagesCollectionViewStack.bounds.width + 37  , height: self.ImagesCollectionViewStack.bounds.height)

        }
    
        CollectionImagesProperties.collectionViewLayout = flowLayout
        CollectionImagesProperties.delegate = self
        CollectionImagesProperties.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

}
extension PropertiesTableCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           // Return the count of ImageDataArray or 1 if it's empty
           return 5
       }
       
       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollection", for: indexPath) as! ImageCollection
           
           if ImageDataArray.isEmpty {
               // Show a placeholder image when ImageDataArray is empty
               cell.UIImagesForCollection.image = UIImage(named: "Background_Sign")

           } else {
               // Load actual image data when ImageDataArray contains data
               guard indexPath.item < ImageDataArray.count else {
                   print("Index out of bounds for ImageDataArray.")
                   return cell
               }
               let imageURLString = ImageDataArray[indexPath.item]
               if let imageURL = URL(string: imageURLString) {
                   // You can use SDWebImage or any other library to load images asynchronously
//                   cell.UIImagesForCollection.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "PlaceholderImage"))
               } else {
                   print("Invalid image URL: \(imageURLString)")
               }
           }
           return cell
       }

}
