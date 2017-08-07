//
//  ViewController.swift
//  JustMyStuff
//
//  Created by James Birchall on 06/08/2017.
//  Copyright © 2017 James Birchall. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // MARK: - Outlets
    
    @IBOutlet weak var sortingSegmentedControl: UISegmentedControl!
    @IBOutlet weak var itemTableView: UITableView!
    
    // MARK: - Overrides for ViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        itemTableView.delegate = self
        itemTableView.dataSource = self
    }
    
    // MARK: - UITableViewDataSource Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = itemTableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as? ItemTableViewCell {
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    // MARK: - UITableViewDelegate Methods
}

