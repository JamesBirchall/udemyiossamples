//
//  ViewController.swift
//  JustMyStuff
//
//  Created by James Birchall on 06/08/2017.
//  Copyright © 2017 James Birchall. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate {

    // MARK: - Outlets
    
    @IBOutlet weak var sortingSegmentedControl: UISegmentedControl!
    @IBOutlet weak var itemTableView: UITableView!
    
    // MARK: - Private Variables
    
    var fetchedResultsController: NSFetchedResultsController<Item>!
    private let itemDetailSegue = "ItemDetailsSegue"
    
    // MARK: - Overrides for ViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        itemTableView.delegate = self
        itemTableView.dataSource = self
        
        // generateTestData()
        
        attemptFetch()
    }
    
    // MARK: - UITableViewDataSource Methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if let sections = fetchedResultsController.sections {
            return sections.count
        }
        
        return 0
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let sections = fetchedResultsController.sections {
            let sectionInfo = sections[section]
            return sectionInfo.numberOfObjects
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = itemTableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as? ItemTableViewCell {
            configureCell(cell: cell, indexPath: indexPath)
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    // MARK: - UITableViewDelegate Methods
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let items = fetchedResultsController.fetchedObjects, items.count > 0 {
            let item = items[indexPath.row]
            performSegue(withIdentifier: itemDetailSegue, sender: item)
        }
    }
    
    // MARK: - FetchResultsControllerDelegate Methods

    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        
        // listens for changes to Core Data Context
        itemTableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        
        itemTableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .insert:
            if let indexPath = newIndexPath {
                itemTableView.insertRows(at: [indexPath], with: .fade)
            }
        case .delete:
            if let indexPath = indexPath {
                itemTableView.deleteRows(at: [indexPath], with: .fade)
            }
        case .update:
            if let indexPath = indexPath {
                let cell = itemTableView.cellForRow(at: indexPath) as! ItemTableViewCell
                configureCell(cell: cell, indexPath: indexPath)
            }
        case .move:
            if let indexPath = indexPath {
                itemTableView.deleteRows(at: [indexPath], with: .fade)
            }
            if let newIndexPath = newIndexPath {
                itemTableView.insertRows(at: [newIndexPath], with: .fade)
            }
        }
    }
    
    // MARK: - Private Methods
    
    private func configureCell(cell: ItemTableViewCell, indexPath: IndexPath) {
        
        let item = fetchedResultsController.object(at: indexPath)
        cell.configureCell(item: item)
    }
    
    private func attemptFetch() {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let dateSort = NSSortDescriptor(key: "created", ascending: false)   // created is timestamp in Item
        let priceSort = NSSortDescriptor(key: "price", ascending: true)
        let titleSort = NSSortDescriptor(key: "title", ascending: true)
        
        let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
        
        switch sortingSegmentedControl.selectedSegmentIndex {
        case 0:
            fetchRequest.sortDescriptors = [dateSort]
        case 1:
            fetchRequest.sortDescriptors = [priceSort]
        case 2:
            fetchRequest.sortDescriptors = [titleSort]
        default:
            print("Not possible to get to another SelectedSegmentIndex - Out of Bounds.")
            return
        }
        
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        fetchedResultsController = controller
        
        controller.delegate = self
        
        do {
            try controller.performFetch()
        } catch {
            print("Problem Fetching Data: \(error)")
        }
    }
    
    private func generateTestData() {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let item = Item(context: context)
        item.title = "Macbook Pro 2018"
        item.price = 1200.00
        item.details = "A slick new looking Macbook line, with a touchbar keyboard & no ports!"
        
        let item2 = Item(context: context)
        item2.title = "Nintendo Switch"
        item2.price = 190.00
        item2.details = "A way to game on the go, great with friends."
        
        let item3 = Item(context: context)
        item3.title = "Tesla Model 3"
        item3.price = 40000.00
        item3.details = "A more affordable Tesla, with an awesome drive smart and energy re-use technology."
        
        try! context.save() // perists the data to disk in Core Data.
    }
    
    // MARK: - Segue Methods
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == itemDetailSegue {
            if let destination = segue.destination as? ItemDetailsViewController {
                if let item = sender as? Item {
                    destination.itemToEdit = item
                }
            }
        }
    }
    
    // MARK: - IBActions
    
    @IBAction func segmentSelectorPressed(_ sender: UISegmentedControl) {
        attemptFetch()
        itemTableView.reloadData()
    }
    
}

