//
//  RoundedButtonUI.swift
//  MUNZUL
//
//  Created by Navdeep Singh on 12/03/24.
//

import UIKit

class RoundedButtonUI: UIView {
     let button: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 10
        return button
    }()

    var label: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        return label
    }()
    var viewColor: UIColor = .clear {
         didSet {
             backgroundColor = viewColor
         }
     }
    
    var borderColor: UIColor = .clear {
           didSet {
               layer.borderColor = borderColor.cgColor
           }
       }
    var borderWidth: CGFloat = 1.0 {
          didSet {
              layer.borderWidth = borderWidth
          }
      }
    var submitAction: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }

    private func setupUI() {
        addSubview(button)
        addSubview(label)
        button.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: leadingAnchor),
            button.trailingAnchor.constraint(equalTo: trailingAnchor),
            button.topAnchor.constraint(equalTo: topAnchor),
            button.bottomAnchor.constraint(equalTo: bottomAnchor),

            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor),
            label.topAnchor.constraint(equalTo: topAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        
        // Make the RoundedButtonUI view rounded
//        layer.cornerRadius = 20
        layer.borderColor = borderColor.cgColor
        layer.borderWidth = borderWidth
    

    }


    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Update corner radius based on button width
        let cornerRadius = min(bounds.width, bounds.height) / 2
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = true

    }
    func setLabelText(_ text: String, textColor: UIColor) {
        label.text = text
        label.textColor = textColor
    }
    
}
