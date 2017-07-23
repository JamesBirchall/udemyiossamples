//
//  Constants.swift
//  TuppenceWeather
//
//  Created by James Birchall on 16/07/2017.
//  Copyright © 2017 James Birchall. All rights reserved.
//

let BASE_URL = "http://api.openweathermap.org/data/2.5/weather?appid="
let BASE_FORECAST_URL = "http://api.openweathermap.org/data/2.5/forecast/daily?appid="
let BASE_LAT = "\(Location.sharedInstance.latitude!)"
let BASE_LON = "\(Location.sharedInstance.longitude!)"
let BASE_COUNT = "7"

let BASE_WEATHERURL = "\(BASE_URL)\(OPENWEATHER_API_KEY)&lat=\(BASE_LAT)&lon=\(BASE_LON)"
let BASE_WEATHERFORECASTSURL = "\(BASE_FORECAST_URL)\(OPENWEATHER_API_KEY)&lat=\(BASE_LAT)&lon=\(BASE_LON)&cnt=\(BASE_COUNT)"
