//
//  CircularProfile.swift
//  MUNZUL
//
//  Created by Navdeep Singh on 13/03/24.
//

import UIKit

import UIKit

class ColoredCircularView: UIView {

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    func setImage(_ image: UIImage?) {
        imageView.image = image
    }
    
    func setColor(_ color: UIColor) {
        layer.borderColor = color.cgColor
    }
    
    private func setupViews() {
        addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 1),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 1),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -1),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -1),
        ])
        
        layer.cornerRadius = bounds.width / 2
//        layer.borderWidth = 2.0
        clipsToBounds = true
    }
}
