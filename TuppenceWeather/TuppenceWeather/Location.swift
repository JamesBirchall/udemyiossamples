//
//  Location.swift
//  TuppenceWeather
//
//  Created by James Birchall on 23/07/2017.
//  Copyright © 2017 James Birchall. All rights reserved.
//

import Foundation
import CoreLocation

struct Location {
    static var sharedInstance = Location()
    private init() {}   // no no one can override.
    
    var latitude: Double!
    var longitude: Double!
}
