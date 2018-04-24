//
//  Copyright © 2015 Big Nerd Ranch
//

import UIKit

class PhotoInfoViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    
    var photo: Photo! {
        didSet {
            navigationItem.title = photo.title
        }
    }
    var store: PhotoStore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        store.fetchImageForPhoto(photo, completion: { (result) -> Void in
            switch result {
            case let .success(image):
                OperationQueue.main.addOperation() {
                    self.imageView.image = image
                }
            case let .failure(error):
                print("Error fetching image for photo: \(error)")
            }
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowTags" {
            let navController = segue.destination as! UINavigationController
            let tagController = navController.topViewController as! TagsViewController
            
            tagController.store = store
            tagController.photo = photo
        }
    }
}
