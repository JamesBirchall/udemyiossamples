//
//  ItemDetailsViewController.swift
//  JustMyStuff
//
//  Created by James Birchall on 08/08/2017.
//  Copyright © 2017 James Birchall. All rights reserved.
//

import UIKit

class ItemDetailsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // replace the text show in the bar button item for the back button
        if let topItem = navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }
    }
}
