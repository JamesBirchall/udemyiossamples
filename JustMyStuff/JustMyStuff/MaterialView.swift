//
//  MaterialView.swift
//  JustMyStuff
//
//  Created by James Birchall on 06/08/2017.
//  Copyright © 2017 James Birchall. All rights reserved.
//

import UIKit

private var materialKey = false

extension UIView {
    
    @IBInspectable var materialDesign: Bool {
        get {
            return materialKey
        }
        
        set {
            materialKey = newValue
            
            if materialKey {
                layer.masksToBounds = false
                layer.cornerRadius = 3.0
                layer.shadowOpacity = 0.8
                layer.shadowRadius = 3.0
                layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
                layer.shadowColor = UIColor(colorLiteralRed: 157/255, green: 157/255, blue: 157/255, alpha: 1.0).cgColor
            } else {
                layer.cornerRadius = 0
                layer.shadowOpacity = 0
                layer.shadowRadius = 0
                layer.shadowColor = nil
            }
        }
    }
}
