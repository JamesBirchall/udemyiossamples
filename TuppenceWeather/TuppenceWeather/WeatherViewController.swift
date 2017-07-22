//
//  ViewController.swift
//  TuppenceWeather
//
//  Created by James Birchall on 13/07/2017.
//  Copyright © 2017 James Birchall. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController, UITableViewDataSource {

    // MARK: - IBOutlets
    
    @IBOutlet private weak var todaysDateLabel: UILabel!
    @IBOutlet private weak var todaysTemperatureLabel: UILabel!
    @IBOutlet private weak var todaysLocationLabel: UILabel!
    @IBOutlet private weak var todaysWeatherDescriptionLabel: UILabel!
    @IBOutlet private weak var todaysWeatherIcon: UIImageView!
    @IBOutlet private weak var tableView: UITableView!
    
    private var currentWeather: CurrentWeather!
    private var forecasts: Forecasts!
    
    // MARK: - ViewController Override Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // print(#file,#function + " Successfully Loaded.") print out the file and function we are in
        
        tableView.dataSource = self
        
        currentWeather = CurrentWeather()
        currentWeather.downloadWeatherDetails {
            self.updateMainUI()
        }
        
        forecasts = Forecasts()
        forecasts.downloadWeatherDetails {
            print("Forecast Data updated")
            self.tableView.reloadData() // refresh table now we have data
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
}

