//
//  TagView.swift
//  Teko-Dev-Test
//
//  Created by Hoàng Hải on 8/4/19.
//  Copyright © 2019 HoangHai. All rights reserved.
//

import UIKit

class TagView: UIView {

    var path: UIBezierPath!
    var containerWidth: CGFloat = 0
    var containerHeight: CGFloat = 0
    let discountLabel = UILabel()
    
    override func draw(_ rect: CGRect) {
        containerHeight = self.frame.height
        containerWidth = self.frame.width
        createTagView()
        addDiscountLabel()
    }
    
    // MARK: - FUNCTIONS
    
    private func createTagView() {
        path = UIBezierPath()
        
        path.move(to: CGPoint(x: 0.0, y: containerHeight / 2))
        
        path.addLine(to: CGPoint(x: containerWidth / 6 - 1, y: 1))
        
        path.addCurve(to: CGPoint(x: containerWidth / 6, y: 0),
            controlPoint1: CGPoint(x: containerWidth / 6 + 1, y: 0.5),
            controlPoint2: CGPoint(x: containerWidth / 6, y: 0.5))
        
        path.addLine(to: CGPoint(x: containerWidth - 2.5, y: 0))
        
        path.addArc(withCenter: CGPoint(x: containerWidth - 2.5, y: 2.5),
            radius: 2.5,
            startAngle: CGFloat(270).degreesToRadians,
            endAngle: CGFloat(0).degreesToRadians,
            clockwise: true)
        
        path.addLine(to: CGPoint(x: containerWidth, y: containerHeight - 2.5))
        
        path.addArc(withCenter: CGPoint(x: containerWidth - 2.5, y: containerHeight - 2.5),
                    radius: 2.5,
                    startAngle: CGFloat(0).degreesToRadians,
                    endAngle: CGFloat(90).degreesToRadians,
                    clockwise: true)
        
        path.addLine(to: CGPoint(x: containerWidth / 6 + 1, y: containerHeight))
        
        path.addCurve(to: CGPoint(x: containerWidth / 6, y: containerHeight - 0.5),
                      controlPoint1: CGPoint(x: containerWidth / 6 + 1, y: containerHeight - 0.5),
                      controlPoint2: CGPoint(x: containerWidth / 6, y: containerHeight - 0.5))
        
        path.addLine(to: CGPoint(x: 0.0, y: containerHeight / 2))
        
        path.close()
        UIColor.tomatoTwo.setFill()
        path.fill()
    }
    
    func addDiscountLabel() {
        discountLabel.frame = CGRect(x: 0, y: 0, width: containerWidth, height: containerHeight)
        discountLabel.center = CGPoint(x: containerWidth / 2, y: containerHeight / 2 - 1)
        discountLabel.numberOfLines = 1
        discountLabel.textAlignment = .center
        discountLabel.font = UIFont.systemFont(ofSize: 10)
        discountLabel.textColor = .white
        self.addSubview(discountLabel)
    }

}
