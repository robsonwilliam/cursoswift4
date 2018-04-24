//
//  Copyright © 2015 Big Nerd Ranch
//

import Foundation
import CoreData

extension Photo {

    @NSManaged var photoID: String
    @NSManaged var photoKey: String
    @NSManaged var title: String
    @NSManaged var dateTaken: Date
    @NSManaged var remoteURL: URL
    @NSManaged var tags: Set<NSManagedObject>

}
