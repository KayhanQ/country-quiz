//
//  GameViewController.swift
//  country-quiz
//
//  Created by Mac on 2016-07-18.
//  Copyright © 2016 PaddyCrab. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet weak var topCountryView: UIView!
    @IBOutlet weak var bottomCountryView: UIView!
    
    var countryViews = [UIView]()
    
    // when a country is moving on/off screen we should make the screen not tappable
    var tappable: Bool = false
    
    var gameState = GameState()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        gameState.addRandomCountryAtRow(0)
        countryViews.append(topCountryView)
        countryViews.append(bottomCountryView)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(GameViewController.countryAddedWithNotification(_:)), name: "countryAdded", object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(GameViewController.countryRemovedWithNotification), name: "countryRemoved", object: nil)
        
        // start game after a delay or animation
        NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(1), target: self, selector: #selector(GameViewController.startGame), userInfo: nil, repeats: false)

        
    }
    
    // Gamestate informs us if a country has been added and we update the view
    func countryAddedWithNotification(notification: NSNotification) {
        let array =  notification.object as! [AnyObject]
        let row = array[0] as! Int
        let country = array[1] as! String
        
        let countryView = countryViews[row]
        createNextCountryView(countryView, country: country)
    }
    
    // Gamestate informs us if a country has been removed and we update the view
    func countryRemovedWithNotification(notification: NSNotification) {
        let array =  notification.object as! [AnyObject]
        let row = array[0] as! Int
        let index = array[1] as! Int
        
        let countryView = countryViews[row]

        for (childIndex, view) in countryView.subviews.enumerate() {
            if index == childIndex {
                view.removeFromSuperview()
            }
        }
    }

    
    func startGame() {
        gameState.addRandomCountryAtRow(0)
        gameState.addRandomCountryAtRow(1)
    }
    
    
    func animateMoveCountry() {

    }
    
    func createNextCountryView(parentView: UIView, country: String) {
        let shapeView = getShapeView(parentView.frame.size, country: country)
        //shapeView.frame.origin.x = parentView.frame.size.width
        
        //shapeView.topAnchor.constraintLessThanOrEqualToAnchor(view.topAnchor, constant: 20)

        parentView.addSubview(shapeView)
        
        // TODO
        // add the label with the name of the Country
        // add constraints to everything so we can play in landscape (this can be done later)
    }
    
    // will draw from country shape data
    func getShapeView(size: CGSize, country: String) -> UIView {
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
        
        let view: UIView = UIView(frame: CGRect(origin: CGPoint.zero, size: size))
        view.layer.addSublayer(shape)

        return view
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func topCountryViewTapped(sender: AnyObject) {
        
        gameState.removeCountryFromRow(0, atIndex: 0)

    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
