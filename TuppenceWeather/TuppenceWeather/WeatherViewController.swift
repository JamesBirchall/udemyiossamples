//
//  ViewController.swift
//  TuppenceWeather
//
//  Created by James Birchall on 13/07/2017.
//  Copyright © 2017 James Birchall. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController, UITableViewDataSource, CLLocationManagerDelegate {

    // MARK: - IBOutlets
    
    @IBOutlet private weak var todaysDateLabel: UILabel!
    @IBOutlet private weak var todaysTemperatureLabel: UILabel!
    @IBOutlet private weak var todaysLocationLabel: UILabel!
    @IBOutlet private weak var todaysWeatherDescriptionLabel: UILabel!
    @IBOutlet private weak var todaysWeatherIcon: UIImageView!
    @IBOutlet private weak var tableView: UITableView!
    
    private let locationManager = CLLocationManager()
    private var currentLocation: CLLocation?
    
    private var currentWeather: CurrentWeather!
    private var forecasts: Forecasts!
    
    // MARK: - ViewController Override Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // print(#file,#function + " Successfully Loaded.") print out the file and function we are in
        

        
        tableView.dataSource = self
        
        currentWeather = CurrentWeather()
        forecasts = Forecasts()
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Core Location related setup
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
        locationAuthorisationStatus()
        
        let queue = DispatchQueue(label: "locationQueue")
        
        queue.asyncAfter(deadline: .now() + 2) {
            [weak self] in
            print("Starting Location Updates...")
            self?.locationManager.startUpdatingLocation() // we want to check location on each run of the app
        }
    }
    
    // MARK: - TableView Data Source Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecasts.forecastList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as? WeatherTableViewCell {
            cell.updateCell(forecast: forecasts.forecastList[indexPath.row])
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    // MARK: - Private Methods
    private func updateMainUI() {
        todaysDateLabel.text = currentWeather.date
        let temperature = Int(currentWeather.currentTemperature)
        todaysTemperatureLabel.text = "\(temperature)°"
        todaysLocationLabel.text = currentWeather.cityName
        todaysWeatherDescriptionLabel.text = currentWeather.weatherType
        todaysWeatherIcon.image = UIImage(named: "\(currentWeather.weatherType)")
    }
    
    // MARK: - CoreLocation Methods
    private func locationAuthorisationStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            // get location and co-ordinates for the request
            print("Status ok.")
        } else {
            // not authorised
            locationManager.requestWhenInUseAuthorization()
            locationAuthorisationStatus()   // runs this function again 
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        // this is where we know we will have a location to use - only write the once currentLocation
        if currentLocation == nil {
            currentLocation = locations.first
            print(currentLocation.debugDescription)
            Location.sharedInstance.latitude = currentLocation?.coordinate.latitude
            Location.sharedInstance.longitude = currentLocation?.coordinate.longitude
            
            // Lets force the updates only when we have location data
            currentWeather.downloadWeatherDetails {
                self.updateMainUI()
            }
            
            forecasts.downloadWeatherDetails {
                self.tableView.reloadData() // refresh table now we have data
            }
        }
        
        locationManager.stopUpdatingLocation()  // we only check the once rather than waste time.
    }
}

