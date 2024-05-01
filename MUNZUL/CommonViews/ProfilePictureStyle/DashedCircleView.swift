//
//  DashedCircleView.swift
//  MUNZUL
//
//  Created by Navdeep Singh on 14/03/24.
//

import UIKit
import SnapKit

class DashedCircleView: UIView {
    private var shapeLayer: CAShapeLayer = {
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = 2
        shapeLayer.lineCap = .round
        shapeLayer.lineDashPattern = [7, 7]
        return shapeLayer
    }()
    // Property to manage border color
       var borderColor: UIColor = UIColor.red {
           didSet {
               shapeLayer.strokeColor = borderColor.cgColor
           }
       }

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        updatePath()
    }

    private func configure() {
        layer.addSublayer(shapeLayer)
        updateConstraintsIfNeeded()
    }
    

    private func updatePath() {
        let rect = bounds.insetBy(dx: shapeLayer.lineWidth / 2, dy: shapeLayer.lineWidth / 2)
        let radius = min(rect.width, rect.height) / 2
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let path = UIBezierPath(arcCenter: center, radius: radius, startAngle: 0, endAngle: .pi * 2, clockwise: true)
        shapeLayer.path = path.cgPath
    }
}
