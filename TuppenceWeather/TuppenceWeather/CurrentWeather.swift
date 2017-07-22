//
//  CurrentWeather.swift
//  TuppenceWeather
//
//  Created by James Birchall on 19/07/2017.
//  Copyright © 2017 James Birchall. All rights reserved.
//

import Foundation
import Alamofire

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
    
    func downloadWeatherDetails(completed: @escaping () -> ()) {
        let currentWeatherURL = URL(string: BASE_WEATHERURL)
        
        Alamofire.request(currentWeatherURL!).responseJSON {
            [weak self] response in
            print("Request: \(String(describing: response.request))")   // original url request
            
            if let json = response.result.value as? Dictionary<String, Any> {
                if let name = json["name"] as? String {
                    self?._cityName = name.capitalized
                    //print("City: \(name)")
                }
                
                if let weather = json["weather"] as? [Dictionary<String, Any>] {
                    // get weather main string
                    if let weatherDescription = weather[0]["main"] as? String {
                        self?._weatherType = weatherDescription
                        //print("Weather Description: \(weatherDescription)")
                    }
                }
                
                // get temperature
                if let weatherTemperature = json["main"] as? Dictionary<String, Any> {
                    if let dayTemp = weatherTemperature["temp"] as? Double {
                        let celsius = dayTemp - 273.15
                        self?._currentTemperature = celsius
                        //print("Temperature: \(celsius)")
                    }
                }
            }
            print("Completed download and show")
            print("We have set variables.")
            completed()
        }
    }
}
