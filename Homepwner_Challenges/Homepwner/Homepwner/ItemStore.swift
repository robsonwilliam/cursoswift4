//
//  ItemStore.swift
//  Homepwner
//
//  Created by T1aluno10 on 26/04/18.
//  Copyright © 2018 T1aluno10. All rights reserved.
//

import UIKit
class ItemStore {
    var allItems = [Item]()
    
    @discardableResult func createItem() -> Item {
        let newItem = Item(random: true)
        
        allItems.append(newItem)
        
        return newItem
    }
    
    init() {
        for _ in 0..<21 {
            createItem()
        }
    }
    
}

