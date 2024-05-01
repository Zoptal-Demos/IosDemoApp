//
//  SeperatorSignINView.swift
//  MUNZUL
//
//  Created by Navdeep Singh on 07/03/24.
//

import UIKit
import SnapKit

class SeperatorSignINView: UIView {
    
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = App.C.Seperator0898Faid
        label.textAlignment = .center
        label.font = App.F.GettingSortFont
        label.text = "Or Sign In With"
        return label
    }()
    
    private let lineViewLeft: UIView = {
        let view = UIView()
        view.backgroundColor = App.C.Seperator0898Faid
        return view
    }()
    
    private let lineViewRight: UIView = {
        let view = UIView()
        view.backgroundColor = App.C.Seperator0898Faid
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        addSubview(label)
        addSubview(lineViewLeft)
        addSubview(lineViewRight)
        setupConstraints()
    }

    private func setupConstraints() {
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        lineViewLeft.snp.makeConstraints { make in
            make.centerY.equalTo(label)
            make.left.equalToSuperview().offset(5)
            make.right.equalTo(label.snp.left).offset(-5)
            make.height.equalTo(1)
        }
        
        lineViewRight.snp.makeConstraints { make in
            make.centerY.equalTo(label)
            make.left.equalTo(label.snp.right).offset(5)
            make.right.equalToSuperview().offset(-5)
            make.height.equalTo(1)
        }
    }
}
