//
//  CountryView.swift
//  country-quiz
//
//  Created by Mac on 2016-07-18.
//  Copyright © 2016 PaddyCrab. All rights reserved.
//

import UIKit

class CountryView: UIView {
    
    
    init(frame: CGRect, country: Country) {
        super.init(frame: frame)
        
        // TODO
        // add the label with the name of the Country
        // add constraints to everything so we can play in landscape (this can be done later)
        //shapeView.topAnchor.constraintLessThanOrEqualToAnchor(view.topAnchor, constant: 20)
        
        addShapeView(frame.size, country: country)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addShapeView(size: CGSize, country: Country) {
        let width = size.width
        let height = size.height
        
        let shape = CAShapeLayer()
        shape.opacity = 0.5
        shape.lineWidth = 2
        shape.lineJoin = kCALineJoinMiter
        shape.strokeColor = UIColor(hue: 0.786, saturation: 0.79, brightness: 0.53, alpha: 1.0).CGColor
        shape.fillColor = UIColor(hue: 0.786, saturation: 0.15, brightness: 0.89, alpha: 1.0).CGColor
        
        let path = UIBezierPath()
        path.moveToPoint(CGPointMake(0, 0))
        path.addLineToPoint(CGPointMake(width, 0))
        path.addLineToPoint(CGPointMake(240, 50))
        path.addLineToPoint(CGPointMake(0, height))
        path.addLineToPoint(CGPointMake(100, 150))
        path.closePath()
        shape.path = path.CGPath
        
        self.layer.addSublayer(shape)
    }
}
