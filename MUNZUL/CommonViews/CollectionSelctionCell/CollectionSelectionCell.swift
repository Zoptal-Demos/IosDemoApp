//
//  CollectionSelectionCell.swift
//  MUNZUL
//
//  Created by Sonoma on 10/04/24.
//

import UIKit

class CollectionSelectionCell: UICollectionViewCell {

    var tickImageView: UIImageView!
        var labelTxt: UILabel!
        var stackView: UIStackView!

        override init(frame: CGRect) {
            super.init(frame: frame)
            setupViews()
        }
        
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            setupViews()
        }
        
        private func setupViews() {
            // Create tick image view
            tickImageView = UIImageView()
            tickImageView.contentMode = .scaleAspectFit
            // Set initial tick image
            tickImageView.image = UIImage(named: "No_Selection_009") // Change the image name as per your requirement

            // Create label
            labelTxt = UILabel()
            labelTxt.textAlignment = .left
            tickImageView.widthAnchor.constraint(equalToConstant: 40).isActive = true

            // Create stack view
            stackView = UIStackView(arrangedSubviews: [tickImageView, labelTxt])
            stackView.axis = .horizontal
            stackView.spacing = 8 // Adjust spacing as needed
            stackView.alignment = .center
            
            // Add stack view to cell's content view
            contentView.addSubview(stackView)
            stackView.translatesAutoresizingMaskIntoConstraints = false
            
            // Set constraints for stack view
            NSLayoutConstraint.activate([
                stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8), // Adjust leading inset as needed
                stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8), // Adjust trailing inset as needed
                stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
                stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            ])
        }
        
        // Function to toggle the tick mark image
        func toggleTick() {
            // Change the image based on current state
            if tickImageView.image == UIImage(named: "Filled_Tick") {
                tickImageView.image = UIImage(named: "No_Selection_009")
            } else {
                tickImageView.image = UIImage(named: "Filled_Tick")
            }
        }
    }
