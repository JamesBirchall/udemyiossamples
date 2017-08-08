//
//  ItemDetailsViewController.swift
//  JustMyStuff
//
//  Created by James Birchall on 08/08/2017.
//  Copyright © 2017 James Birchall. All rights reserved.
//

import UIKit
import CoreData

class ItemDetailsViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var itemThumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: CustomTextField!
    @IBOutlet weak var priceLabel: CustomTextField!
    @IBOutlet weak var detailsLabel: CustomTextField!
    @IBOutlet weak var storePickerView: UIPickerView!
    
    var stores = [Store]()
    
    var itemToEdit: Item?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // replace the text show in the bar button item for the back button
        if let topItem = navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }
        
        storePickerView.dataSource = self
        storePickerView.delegate = self
        
        if itemToEdit != nil {
            loadItemData()
        }
        
        // test data
        // deleteStores()
        // createStores()
        getStores()
    }
    
    // MARK: - PickerView Data Source Methods
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return stores.count
    }
    
    // MARK: - PickerView Delegate Methods
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let store = stores[row]
        return store.name
    }
    
    // MARK: - IBActions
    
    @IBAction func saveItemButton(_ sender: UIButton) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        var item: Item!
        
        if itemToEdit == nil {
            item = Item(context: context)
        } else {
            item = itemToEdit
        }
        
        if titleLabel.text != "" && priceLabel.text != "" && detailsLabel.text != "" {
            item.title = titleLabel.text
            
            var priceLabelAdjusted = priceLabel.text!
            priceLabelAdjusted.remove(at: priceLabelAdjusted.startIndex)
            if let priceDouble = Double(priceLabelAdjusted) {
                item.price = priceDouble
            }
            
            item.details = detailsLabel.text
            
            item.store = stores[storePickerView.selectedRow(inComponent: 0)]
            print(item.store?.name)
        }
        
        try! context.save()
        
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func changeImage(_ sender: UIButton) {
        
    }

    // MARK: - Private Methods
    
    private func createStores() {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let store = Store(context: context)
        store.name = "Amazon"
        let store2 = Store(context: context)
        store2.name = "Best Buy"
        let store3 = Store(context: context)
        store3.name = "Buy Low"
        let store4 = Store(context: context)
        store4.name = "Circus"
        let store5 = Store(context: context)
        store5.name = "Delta"
        let store6 = Store(context: context)
        store6.name = "Tesco"
        let store7 = Store(context: context)
        store7.name = "Zavvi"
        
        try! context.save()
    }
    
    private func deleteStores() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        var tempStores = [Store]()
        let fetchRequest: NSFetchRequest<Store> = Store.fetchRequest()
        
        do {
            tempStores = try context.fetch(fetchRequest)
        } catch {
            print("Problem Fetching Data: \(error)")
        }
        
        for store in tempStores {
            context.delete(store)
            storePickerView.reloadAllComponents()
        }
        
        try! context.save()
    }
    
    private func getStores() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let nameSort = NSSortDescriptor(key: "name", ascending: true)
        let fetchRequest: NSFetchRequest<Store> = Store.fetchRequest()
        fetchRequest.sortDescriptors = [nameSort]
        
        do {
            stores = try context.fetch(fetchRequest)
            storePickerView.reloadAllComponents()
        } catch {
            print("Problem Fetching Data: \(error)")
        }
    }

    private func loadItemData() {
        if let item = itemToEdit {
            titleLabel.text = item.title
            priceLabel.text = "£\(item.price)"
            detailsLabel.text = item.details
            
            if let store = item.store {
                for (index, value) in stores.enumerated() {
                    print("Stores: \(value.name) | \(store.name)")
                    if value.name == store.name {
                        storePickerView.selectRow(index, inComponent: 0, animated: true)
                        print("Found Match! \(value.name.debugDescription), \(store.name.debugDescription)")
                    }
                }
            } else {
                print("No Store to Load")
            }
        }
    }
}
