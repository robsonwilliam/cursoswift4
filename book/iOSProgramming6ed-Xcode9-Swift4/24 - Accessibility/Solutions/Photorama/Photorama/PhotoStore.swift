//
//  Copyright © 2015 Big Nerd Ranch
//

import UIKit
import CoreData

enum ImageResult {
    case success(UIImage)
    case failure(Error)
}

enum PhotoError: Error {
    case imageCreationError
}

class PhotoStore {
    
    let coreDataStack = CoreDataStack(modelName: "Photorama")
    let imageStore = ImageStore()
    
    let session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
        }()
    
    func processPhotosRequest(data: Data?, error: Error?) -> PhotosResult {
        guard let jsonData = data else {
            return .failure(error!)
        }
        
        return FlickrAPI.photosFromJSONData(jsonData,
            inContext: self.coreDataStack.privateQueueContext)
    }
    
    func processImageRequest(data: Data?, error: Error?) -> ImageResult {
        
        guard let
            imageData = data,
            let image = UIImage(data: imageData) else {
                
                // Couldn't create an image
                if data == nil {
                    return .failure(error!)
                }
                else {
                    return .failure(PhotoError.imageCreationError)
                }
        }
        
        return .success(image)
    }
    
    func fetchImageForPhoto(_ photo: Photo, completion: @escaping (ImageResult) -> Void) {
        
        let photoKey = photo.photoKey
        if let image = imageStore.imageForKey(photoKey) {
            completion(.success(image))
            return
        }
        
        let photoURL = photo.remoteURL
        let request = URLRequest(url: photoURL as URL)
        
        let task = session.dataTask(with: request, completionHandler: {
            (data, response, error) -> Void in
            
            let result = self.processImageRequest(data: data, error: error)
            
            if case let .success(image) = result {
                photo.image = image
                self.imageStore.setImage(image, forKey: photoKey)
            }
            
            completion(result)
        }) 
        task.resume()
    }
    
    func fetchMainQueuePhotos(predicate: NSPredicate? = nil,
        sortDescriptors: [NSSortDescriptor]? = nil) throws -> [Photo] {
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Photo")
            fetchRequest.sortDescriptors = sortDescriptors
            
            let mainQueueContext = self.coreDataStack.mainQueueContext
            var mainQueuePhotos: [Photo]?
            var fetchRequestError: Error?
            mainQueueContext.performAndWait({
                do {
                    mainQueuePhotos = try mainQueueContext.fetch(fetchRequest) as? [Photo]
                }
                catch let error {
                    fetchRequestError = error
                }
            })
            
            guard let photos = mainQueuePhotos else {
                throw fetchRequestError!
            }
            
            return photos
    }
    
    func fetchInterestingPhotos(completion: @escaping (PhotosResult) -> Void) {
        
        let url = FlickrAPI.interestingPhotosURL()
        let request = URLRequest(url: url as URL)
        let task = session.dataTask(with: request, completionHandler: {
            (data, response, error) -> Void in
            
            var result = self.processPhotosRequest(data: data, error: error)
            
            if case let .success(photos) = result {
                let privateQueueContext = self.coreDataStack.privateQueueContext
                privateQueueContext.performAndWait({
                    try! privateQueueContext.obtainPermanentIDs(for: photos)
                })
                let objectIDs = photos.map{ $0.objectID }
                let predicate = NSPredicate(format: "self IN %@", objectIDs)
                let sortByDateTaken = NSSortDescriptor(key: "dateTaken", ascending: true)
                
                do {
                    try self.coreDataStack.saveChanges()
                    
                    let mainQueuePhotos = try self.fetchMainQueuePhotos(predicate: predicate,
                        sortDescriptors: [sortByDateTaken])
                    result = .success(mainQueuePhotos)
                }
                catch let error {
                    result = .failure(error)
                }
            }
            
            completion(result)
        })
        task.resume()
    }
    
    func fetchMainQueueTags(predicate: NSPredicate? = nil,
        sortDescriptors: [NSSortDescriptor]? = nil) throws -> [NSManagedObject] {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Tag")
            fetchRequest.predicate = predicate
            fetchRequest.sortDescriptors = sortDescriptors
            
            let mainQueueContext = self.coreDataStack.mainQueueContext
            var mainQueueTags: [NSManagedObject]?
            var fetchRequestError: Error?
            mainQueueContext.performAndWait({
                do {
                    mainQueueTags = try mainQueueContext.fetch(fetchRequest) as? [NSManagedObject]
                }
                catch let error {
                    fetchRequestError = error
                }
            })
            
            guard let tags = mainQueueTags else {
                throw fetchRequestError!
            }
            
            return tags
    }
    
}
