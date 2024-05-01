//
//  ImageCollection.swift
//  MUNZUL
//
//  Created by Sonoma on 05/04/24.
//

import UIKit

class ImageCollection: UICollectionViewCell {

    @IBOutlet weak var ImageLoader: UIActivityIndicatorView!
    
    @IBOutlet weak var UIImagesForCollection: UIImageView!
    var imageDataArray: [UIImage] = [] // Assuming you have UIImage data

    override func awakeFromNib() {
        super.awakeFromNib()
        UIImagesForCollection.contentMode = .scaleAspectFill
        UIImagesForCollection.clipsToBounds = true

        // Initialization code
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollection", for: indexPath) as! ImageCollection
        return cell
    }
 
}
