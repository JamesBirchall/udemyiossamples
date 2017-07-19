//
//  CurrentWeather.swift
//  TuppenceWeather
//
//  Created by James Birchall on 19/07/2017.
//  Copyright © 2017 James Birchall. All rights reserved.
//

import Foundation

class CurrentWeather {
    
    private var _cityName: String!
    private var _weatherType: String!
    private var _date: String!
    private var _currentTemperature: Double!
    
    var cityName: String {
        get {
            return _cityName
        }
        
        set {
            _cityName = newValue
        }
    }
    
    var weatherType: String {
        get {
            return _weatherType
        }
        
        set {
            _weatherType = newValue
        }
    }
    
    var currentTemperature: Double {
        get {
            return _currentTemperature
        }
        
        set {
            _currentTemperature = newValue
        }
    }
    
    var date: String {
        if _date == nil {
            _date = ""
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        
        let currentDate = dateFormatter.string(from: Date())
        _date = "Today, \(currentDate)"
        
        return _date
    }
}
