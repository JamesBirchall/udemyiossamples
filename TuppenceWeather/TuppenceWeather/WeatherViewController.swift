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
    
    // MARK: - ViewController Override Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // print(#file,#function + " Successfully Loaded.") print out the file and function we are in
        
        tableView.dataSource = self
        
        currentWeather = CurrentWeather()
        currentWeather.downloadWeatherDetails { 
            print("Download and Show Complete")
        }
    }
    
    // MARK: - TableView Data Source Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath)
        return cell
    }
}

