//
//  CircularButtons.swift
//  MUNZUL
//
//  Created by Navdeep Singh on 14/03/24.
//


import UIKit
import SnapKit


class CircularButtons: UIView {

     let button: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("", for: .normal)
        button.backgroundColor = .green
         button.layer.cornerRadius = 0.5 // Adjust corner radius as needed
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }

    private func setupViews() {
        // Set background color
        backgroundColor = .clear
        
        // Add button
        addSubview(button)
        button.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func setImage(_ image: UIImage?) {
        button.setImage(image, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
    }
    
    func setBackgroundColor(_ color: UIColor) {
        button.backgroundColor = color
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Update corner radius based on button width
        let cornerRadius = min(bounds.width, bounds.height) / 2
        button.layer.cornerRadius = cornerRadius
    }
}

