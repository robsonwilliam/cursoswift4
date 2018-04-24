//
//  Copyright © 2015 Big Nerd Ranch
//

import UIKit

class PhotosViewController: UIViewController, UICollectionViewDelegate {
    
    @IBOutlet var collectionView: UICollectionView!
    
    var store: PhotoStore!
    let photoDataSource = PhotoDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = photoDataSource
        collectionView.delegate = self
        
        store.fetchInterestingPhotos() {
            (photosResult) -> Void in
            
            OperationQueue.main.addOperation() {
                switch photosResult {
                case let .success(photos):
                    print("Successfully found \(photos.count) interesting photos.")
                    self.photoDataSource.photos = photos
                case let .failure(error):
                    self.photoDataSource.photos.removeAll()
                    print("Error fetching interesting photos: \(error)")
                }
                self.collectionView.reloadSections(IndexSet(integer: 0))
            }
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
        willDisplay cell: UICollectionViewCell,
        forItemAt indexPath: IndexPath) {
            
            let photo = photoDataSource.photos[indexPath.row]
            
            // Download the image data, which could take some time
            store.fetchImageForPhoto(photo, completion: { (result) -> Void in
                
                OperationQueue.main.addOperation() {
                    
                    // The index path for the photo might have changed between the
                    // time the request started and finished, so find the most
                    // recent index path
                    
                    // (Note: You will have an error on the next line; you will fix it shortly)
                    let photoIndex = self.photoDataSource.photos.index(of: photo)!
                    let photoIndexPath = IndexPath(item: photoIndex, section: 0)
                    
                    // When the request finishes, only update the cell if it's still visible
                    if let cell = self.collectionView.cellForItem(at: photoIndexPath)
                        as? PhotoCollectionViewCell {
                            cell.updateWithImage(photo.image)
                    }
                }
            })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPhoto" {
            if let selectedIndexPath =
                collectionView.indexPathsForSelectedItems?.first {
                    
                    let photo = photoDataSource.photos[selectedIndexPath.row]
                    
                    let destinationVC =
                    segue.destination as! PhotoInfoViewController
                    destinationVC.photo = photo
                    destinationVC.store = store
            }
        }
    }
}
