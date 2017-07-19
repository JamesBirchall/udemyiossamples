//
//  WeatherTableViewCell.swift
//  TuppenceWeather
//
//  Created by James Birchall on 16/07/2017.
//  Copyright © 2017 James Birchall. All rights reserved.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var weatherDayOfWeekLabel: UILabel!
    @IBOutlet weak var weatherTypeOfWeatherLabel: UILabel!
    @IBOutlet weak var weatherHighTemperatureLabel: UILabel!
    @IBOutlet weak var weatherLowTemperatureLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
