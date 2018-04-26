//
//  ItemsViewController.swift
//  Homepwner
//
//  Created by T1aluno10 on 26/04/18.
//  Copyright © 2018 T1aluno10. All rights reserved.
//

import UIKit
class ItemsViewController: UITableViewController {
    var itemStore: ItemStore!
    let tableTitles = ["Description", "Price"]
        
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return itemStore.allItems.count
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Create an instance of UITableViewCell, with default appearance
        //let cell = UITableViewCell(style: .value1, reuseIdentifier: "UITableViewCell")
        // Set the text on the cell with the description of the item
        // that is at the nth index of items, where n = row this cell
        // will appear in on the tableview
        
        // Get a new or recycled cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell",
                                                 for: indexPath)
        
        let item = itemStore.allItems[indexPath.row]
        cell.textLabel?.text = item.name
        cell.detailTextLabel?.text = "$ \(item.valueInDollars)"
        return cell }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection tableTitles: Int) -> String? {
        let TableHeaderTitles = tableTitles[tableTitles]
        return self.tableTitles\[tableTitles\]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Get the height of the status bar
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        let insets = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
        tableView.contentInset = insets
        tableView.scrollIndicatorInsets = insets
    }
}
