//
//  GameViewController.swift
//  country-quiz
//
//  Created by Mac on 2016-07-18.
//  Copyright © 2016 PaddyCrab. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet weak var topRow: UIView!
    @IBOutlet weak var bottomRow: UIView!

    enum Direction : Int {
        case OffScreen = 0
        case OnScreen = 1
    }
    
    var rowViews = [UIView]()
    
    var gameState = GameState()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        rowViews.append(topRow)
        rowViews.append(bottomRow)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(GameViewController.countryAddedWithNotification(_:)), name: "countryAdded", object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(GameViewController.countryRemovedWithNotification(_:)), name: "countryRemoved", object: nil)
        
        // start game after a delay or animation
        NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(1), target: self, selector: #selector(GameViewController.startGame), userInfo: nil, repeats: false)

        
    }
    
    override func viewWillAppear(animated: Bool) {
        
    }
    
    func startGame() {

        gameState.addRandomCountryAtRow(0)
        gameState.addRandomCountryAtRow(0)
        
        gameState.addRandomCountryAtRow(1)
        gameState.addRandomCountryAtRow(1)
    }
    
    // Gamestate informs us if a country has been added and we update the view
    func countryAddedWithNotification(notification: NSNotification) {
        let array =  notification.object as! [AnyObject]
        let row = array[0] as! Int
        let index = array[1] as! Int
        let country = array[2] as! Country
        
        let rowView = rowViews[row]
        
        createCountryViewIn(rowView, forCountry: country)
        
        
        // if there is only one child we are at the start of the game so we must move the country view on screen
        if gameState.numChildrenInRow(row) == 1 {
            animateCountryViewAtIndex(index, inRow: row, inDirection: .OnScreen)
        }
    }
    
    // Gamestate informs us if a country has been removed and we update the view
    func countryRemovedWithNotification(notification: NSNotification) {
        print("removing Country")
        let array =  notification.object as! [AnyObject]
        let row = array[0] as! Int
        let index = array[1] as! Int
        
        let rowView = rowViews[row]
        let countryView = getSubviewAtIndex(index, inParent: rowView)!
        countryView.removeFromSuperview()
    }
    
    func animateCountryViewAtIndex(index: Int, inRow row: Int, inDirection direction: Direction) {
        var x: CGFloat = 0
        switch direction {
        case .OnScreen:
            x = 0
        case . OffScreen:
            x = -view.frame.size.width
        }
        
        let countryView = getSubviewAtIndex(index, inParent: rowViews[row])!

        UIView.animateWithDuration(0.8, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 10.0, options: UIViewAnimationOptions(), animations: { () -> Void in
            countryView.frame.origin = CGPoint(x: x, y: countryView.frame.origin.y)
            }, completion: {(_) -> Void in
                if direction == .OnScreen {
                    
                } else if direction == .OffScreen {
                    self.gameState.removeCountryFromRow(row, atIndex: index)
                    self.gameState.addRandomCountryAtRow(row)
                }
            })
    }
    
    func createCountryViewIn(parentView: UIView, forCountry country: Country) {
        let frame = CGRect(origin: CGPointMake(parentView.frame.origin.x + parentView.frame.size.width, 0) , size: parentView.frame.size)
        let countryView = CountryView(frame: frame, country: country)
        parentView.addSubview(countryView)
    }
    
    func rowNumberForRowView(rowView: UIView) -> Int {
        for (childIndex, view) in rowViews.enumerate() {
            if rowView == view {
                return childIndex
            }
        }
        return -1
    }

    @IBAction func topRowTapped(sender: AnyObject) {
        print("top row tapped")
        animateCountryViewAtIndex(0, inRow: 0, inDirection: .OffScreen)
        animateCountryViewAtIndex(1, inRow: 0, inDirection: .OnScreen)

    }
    
    @IBAction func bottomRowTapped(sender: AnyObject) {
        print("bot row tapped")
        animateCountryViewAtIndex(0, inRow: 1, inDirection: .OffScreen)
        animateCountryViewAtIndex(1, inRow: 1, inDirection: .OnScreen)
    }
    
    
    func getSubviewAtIndex(index: Int, inParent parentView: UIView) -> UIView? {
        for (childIndex, view) in parentView.subviews.enumerate() {
            if index == childIndex {
                return view
            }
        }
        return nil
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
