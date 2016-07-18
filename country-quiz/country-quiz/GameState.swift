//
//  GameState.swift
//  country-quiz
//
//  Created by Mac on 2016-07-18.
//  Copyright © 2016 PaddyCrab. All rights reserved.
//

import Foundation

class GameState {
    // right now we'll keep allCountries in memory
    var allCountries = [Country]()
    
    // there are two rows the game is played in, each row has two countries at time: The one you see and the one that will
    // come next
    var rows = [[Country]]()
    
    
    init() {
        rows.append([])
        rows.append([])
    }
    
    func addRandomCountryAtRow(row: Int) {
        let c = Country()
        rows[row].append(c)
        let index = rows[row].count - 1
        
        let array : [AnyObject] = [row, index, c]

        NSNotificationCenter.defaultCenter().postNotificationName("countryAdded", object: array)
    }
    
    func removeCountryFromRow(row: Int, atIndex index: Int) {
        let country = rows[row][index]
        
        print(country)
        let array : [AnyObject] = [row, index]

        NSNotificationCenter.defaultCenter().postNotificationName("countryRemoved", object: array)

    }
    
    func numChildrenInRow(row: Int) -> Int {
        return rows[row].count
    }
    
    
    
}
