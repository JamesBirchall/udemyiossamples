//
//  Forecasts.swift
//  TuppenceWeather
//
//  Created by James Birchall on 22/07/2017.
//  Copyright © 2017 James Birchall. All rights reserved.
//

import Foundation
import Alamofire

class Forecasts {
    
    var forecastList = [Forecast]()
    
    func downloadWeatherDetails(completed: @escaping () -> ()) {
        let currentWeatherURL = URL(string: BASE_WEATHERFORECASTSURL)
        
        Alamofire.request(currentWeatherURL!).responseJSON {
            [weak self] response in
            print("Request: \(String(describing: response.request))")   // original url request
            
            if let json = response.result.value as? Dictionary<String, Any> {
                if let list = json["list"] as? [Dictionary<String, Any>] {
                    
                    
                    
                    for item in list {
                        let currentForecast = Forecast()
                        // get min and max temp first
                        if let temp = item["temp"] as? Dictionary<String, Any> {
                            if let minTemp = temp["min"] as? Double {
                                
                                let intVersion = Int(minTemp - 273.15)
                                currentForecast.lowTemp = "\(intVersion)"
                            }
                            if let maxTemp = temp["max"] as? Double {
                                let intVersion = Int(maxTemp - 273.15)
                                currentForecast.highTemp = "\(intVersion)"
                            }
                        }
                        // get weather Type
                        if let weather = item["weather"] as? [Dictionary<String, Any>] {
                            if let weatherType = weather.first?["main"] as? String {
                                currentForecast.weatherType = weatherType
                            }
                        }
                        // get date
                        if let date = item["dt"] as? Double {
                            let unixConvertableDate = Date(timeIntervalSince1970: date)
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateStyle = .full
                            dateFormatter.dateFormat = "EEEE"
                            dateFormatter.timeStyle = .none
                            currentForecast.date = unixConvertableDate.dayOfWeek()
                        }
                        self?.forecastList.append(currentForecast)
                    }
                }
            }
            print("Completed forecast download and show")
            print("We have set forecast variables.")
            completed()
        }
    }
}
