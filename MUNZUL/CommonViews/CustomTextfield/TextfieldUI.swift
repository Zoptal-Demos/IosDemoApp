//
//  TextfieldUI.swift
//  MUNZUL
//
//  Created by Navdeep Singh on 07/03/24.
//

import UIKit
import SnapKit

protocol RoundedTextFieldViewDelegate: AnyObject {
    func textFieldViewDidUpdateText(_ textFieldView: RoundedTextFieldView, text: String)
}

class RoundedTextFieldView: UIView, UITextFieldDelegate {
    let circularView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20.0
        view.layer.borderWidth = 1.0
        view.layer.borderColor = UIColor.lightGray.cgColor
        return view
    }()
    
    let textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter text"
        textField.backgroundColor = .clear
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10)) // Add left padding
        textField.leftViewMode = .always
        textField.borderStyle = .none // Remove the border from the text field
        return textField
    }()
    
    let spacerView: UIView = {
        let spacer = UIView()
        spacer.backgroundColor = .clear
        spacer.snp.makeConstraints { make in
            make.width.equalTo(18)
        }
        return spacer
    }()
    
    let spacerView2: UIView = {
        let spacer = UIView()
        spacer.backgroundColor = .clear
        spacer.snp.makeConstraints { make in
            make.width.equalTo(18)
        }
        return spacer
    }()
    
    let rightButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "Message_icon"), for: .normal)
        button.tintColor = .red

        button.addTarget(self, action: #selector(rightButtonTapped), for: .touchUpInside)
        return button
    }()
    
    weak var delegate: RoundedTextFieldViewDelegate?

    var isPasswordField: Bool = false {
        didSet {
            if isPasswordField {
                textField.isSecureTextEntry = true
            } else {
                textField.isSecureTextEntry = false
            }
        }
    }
    
    let visibilityButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "Hide_eye"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(visibilityButtonTapped), for: .touchUpInside)
        return button
    }()
    
    
    
    @objc private func visibilityButtonTapped() {
        guard isPasswordField else {
               // If it's not a password field, do nothing
               return
           }

        textField.isSecureTextEntry.toggle()
        
        if textField.isSecureTextEntry {
            visibilityButton.setImage(UIImage(named: "Hide_eye"), for: .normal)
        } else {
            visibilityButton.setImage(UIImage(named: "Show_Eye"), for: .normal)
        }
    }
    
    
    
    func setRightButtonBackgroundImage(_ image: UIImage?) {
        rightButton.setImage(image ?? UIImage(named: "Message_icon"), for: .normal)
    }
    
    
    func setLeftButtonBackgroundImage(_ image: UIImage?) {
        visibilityButton.setImage(image ?? UIImage(named: "Message_icon"), for: .normal)
    }
    
    @objc private func rightButtonTapped() {
        print("Tapped on right button")
    }
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
        setupTextFieldDelegate()
        
    }
    
    
    private func setupTextFieldDelegate() {
        textField.delegate = self
    }
    
    
    private var isVisibilityButtonHidden: Bool = true {
        didSet {
            visibilityButton.isHidden = isVisibilityButtonHidden
        }
    }
    
    
    
    func hideVisibilityButton() {
        isVisibilityButtonHidden = true
    }
    
    
    
    func showVisibilityButton() {
        isVisibilityButtonHidden = false
    }
    
    
    
    
    private func commonInit() {
        isVisibilityButtonHidden = true
        backgroundColor = .clear
        // Add circularView to the main view
        addSubview(circularView)
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 5
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.addArrangedSubview(spacerView)
        stackView.addArrangedSubview(rightButton)
        stackView.addArrangedSubview(textField)
        stackView.addArrangedSubview(visibilityButton)
        stackView.addArrangedSubview(spacerView2)
        
        circularView.addSubview(stackView)
        circularView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5))
        }
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        rightButton.snp.makeConstraints { make in
            make.width.equalTo(18)
            make.height.equalTo(18)
        }
    }
    
    func clearTextField() {
        textField.text = ""
    }
    
}

extension RoundedTextFieldView {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        circularView.layer.borderColor = App.C.txtfieldStart.cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let updatedText = textField.text ?? ""
        circularView.layer.borderColor = updatedText.isEmpty ? App.C.txtfieldNone.cgColor : App.C.txtfieldStart.cgColor
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        let updatedText = textField.text ?? ""
        circularView.layer.borderColor = updatedText.isEmpty ? App.C.txtfieldNone.cgColor : App.C.txtfieldStart.cgColor
        delegate?.textFieldViewDidUpdateText(self, text: updatedText)
    }
}
