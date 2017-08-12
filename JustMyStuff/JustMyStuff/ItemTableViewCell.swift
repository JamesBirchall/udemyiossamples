//
//  ItemTableViewCell.swift
//  JustMyStuff
//
//  Created by James Birchall on 07/08/2017.
//  Copyright © 2017 James Birchall. All rights reserved.
//

import UIKit

class ItemTableViewCell: UITableViewCell {
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    
    func configureCell(item: Item) {
        
        titleLabel.text = item.title
        
        let numberFormatter = NumberFormatter()
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.maximumFractionDigits = 2
        let priceAsNSNumber = NSNumber(floatLiteral: item.price)
        let price = numberFormatter.string(from: priceAsNSNumber)
        if let price = price {
            priceLabel.text = "£\(price)"
        }
        
        detailsLabel.text = item.details
        
        if let image = item.image?.image as? UIImage {
            thumbnailImageView.image = image
        }
    }
}
