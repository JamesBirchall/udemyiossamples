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
    
    func downloadWeatherDetails(completed: () -> ()) {
        let currentWeatherURL = URL(string: BASE_WEATHERURL)
        
        Alamofire.request(currentWeatherURL!).responseJSON {
            response in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")                         // response serialization result
            
            if let json = response.result.value {
                print("JSON: \(json)") // serialized json response
            }
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)") // original server data as UTF8 string
            }
        }
        
        completed()
    }
}
