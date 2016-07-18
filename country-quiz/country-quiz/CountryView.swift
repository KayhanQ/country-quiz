//
//  CountryView.swift
//  country-quiz
//
//  Created by Mac on 2016-07-18.
//  Copyright © 2016 PaddyCrab. All rights reserved.
//

import UIKit

class CountryView: UIView {
    
    var country: Country?
    
    init(frame: CGRect, country: Country) {
        super.init(frame: frame)
        self.country = country

        setup()
    }
    
    func setup() {
        //self.backgroundColor = UIColor.yellowColor()
        
        let container = UILayoutGuide()
        self.addLayoutGuide(container)
        
        let shapeViewFrame = CGRect(x: 20, y: 0, width: self.frame.width-20, height: self.frame.height-20)
        let shapeView = getShapeView(shapeViewFrame)
        shapeView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(shapeView)

        // TODO
        // add the label with the name of the Country
        // add constraints to everything so we can play in landscape (this can be done later)
        shapeView.topAnchor.constraintLessThanOrEqualToAnchor(self.layoutMarginsGuide.topAnchor).active = true
        shapeView.trailingAnchor.constraintEqualToAnchor(self.layoutMarginsGuide.trailingAnchor).active = true
        shapeView.leadingAnchor.constraintEqualToAnchor(self.layoutMarginsGuide.leadingAnchor).active = true
        shapeView.bottomAnchor.constraintEqualToAnchor(self.layoutMarginsGuide.trailingAnchor, constant: 20.0).active = true

//        shapeView.topAnchor.constraintEqualToAnchor(container.topAnchor, constant: 40).active = true

    }
    
    func getShapeView(frame: CGRect) -> UIView {
        let width = frame.size.width
        let height = frame.size.height
        
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
        
        let shapeView = UIView(frame: frame)
        shapeView.layer.addSublayer(shape)
        
        return shapeView
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
