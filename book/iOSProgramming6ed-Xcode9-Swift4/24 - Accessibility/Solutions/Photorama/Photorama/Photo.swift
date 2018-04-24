//
//  Copyright © 2015 Big Nerd Ranch
//

import UIKit
import CoreData

class Photo: NSManagedObject {

    var image: UIImage?
    
    override func awakeFromInsert() {
        super.awakeFromInsert()
        
        // Give the properties their initial values
        title = ""
        photoID = ""
        remoteURL = URL(string:"https://path-to-placeholder")!
        photoKey = UUID().uuidString
        dateTaken = Date()
    }
    
    func addTagObject(_ tag: NSManagedObject) {
        let currentTags = mutableSetValue(forKey: "tags")
        currentTags.add(tag)
    }
    
    func removeTagObject(_ tag: NSManagedObject) {
        let currentTags = mutableSetValue(forKey: "tags")
        currentTags.remove(tag)
    }

}
