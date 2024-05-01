//
//  CustomToogleView.swift
//  MUNZUL
//
//  Created by Navdeep on 01/04/24.
//

import UIKit

class CustomToogleView: UIView {

     var toggleSwitch: UISwitch!
     var isOn: Bool = true {
           didSet {
               toggleSwitch.isOn = isOn
               UpdateColor()
           }
       }
      
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    // MARK: - Setup
    
    private func setupView() {
          // Add toggle switch
          toggleSwitch = UISwitch()
          toggleSwitch.addTarget(self, action: #selector(toggleSwitchValueChanged(_:)), for: .valueChanged)
          addSubview(toggleSwitch)
          
          // Initial state
          isOn = true
          
          // Customize switch appearance
          toggleSwitch.onTintColor = App.C.BtnColor0898 // Color when switch is ON
          toggleSwitch.thumbTintColor = .white
          toggleSwitch.tintColor =  App.C.BtnColor0898Faid
      }
      
      // MARK: - Actions
      
      @objc private func toggleSwitchValueChanged(_ sender: UISwitch) {
          // Ensure that tapping the switch always toggles its state
          isOn = !isOn
      }

    func UpdateColor(){
        toggleSwitch.tintColor = .red
    }
}

