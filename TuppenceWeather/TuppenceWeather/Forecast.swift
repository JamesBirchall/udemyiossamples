//
//  Forecast.swift
//  TuppenceWeather
//
//  Created by James Birchall on 22/07/2017.
//  Copyright © 2017 James Birchall. All rights reserved.
//

import Foundation

class Forecast: CustomStringConvertible {
    private var _date: String!
    private var _weatherType: String!
    private var _highTemp: String!
    private var _lowTemp: String!
    
    var date: String {
        get {
        if _date == nil {
            _date = ""
        }
        return _date
        }
        set {
            _date = newValue
        }
    }
    
    var weatherType: String {
                get {
        if _weatherType == nil {
            
        }
        return _weatherType
        }
        set {
            _weatherType = newValue
        }
    }
    
    var highTemp: String {
                get {
        if _highTemp == nil {
            
        }
        return _highTemp
        }
        set {
            _highTemp = newValue + "°"
        }
    }
    
    var lowTemp: String {
                get {
        if _lowTemp == nil {
            
        }
        return _lowTemp
        }
        set {
            _lowTemp = newValue + "°"
        }
    }
    
    var description: String {
        return "Date: \(date) | Weather: \(weatherType) | LowTemp: \(lowTemp) | HighTemp: \(highTemp)"
    }
}

extension Date {
    func dayOfWeek() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
    }
}
