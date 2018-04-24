//
//  Copyright © 2015 Big Nerd Ranch
//

import Foundation
import CoreData

enum Method: String {
    case InterestingPhotos = "flickr.interestingness.getList"
}

enum PhotosResult {
    case success([Photo])
    case failure(Error)
}

enum FlickrError: Error {
    case invalidJSONData
}

class FlickrAPI {
    
    fileprivate static let baseURLString = "https://api.flickr.com/services/rest"
    fileprivate static let APIKey = "a6d819499131071f158fd740860a5a88"
    
    fileprivate static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter
        }()
    
    fileprivate class func flickrURL(method: Method,
        parameters: [String:String]?) -> URL {
            var components = URLComponents(string: baseURLString)!
            
            var queryItems = [URLQueryItem]()
            
            let baseParams = [
                "method": method.rawValue,
                "format": "json",
                "nojsoncallback": "1",
                "api_key": APIKey
            ]
            
            for (key, value) in baseParams {
                let item = URLQueryItem(name: key, value: value)
                queryItems.append(item)
            }
            
            if let additionalParams = parameters {
                for (key, value) in additionalParams {
                    let item = URLQueryItem(name: key, value: value)
                    queryItems.append(item)
                }
            }
            components.queryItems = queryItems
            
            return components.url!
    }
    
    class func interestingPhotosURL() -> URL {
        return flickrURL(method: .InterestingPhotos,
            parameters: ["extras": "url_h,date_taken"])
    }
    
    class func photosFromJSONData(_ data: Data,
        inContext context: NSManagedObjectContext) -> PhotosResult {
            
            do {
                let jsonObject: Any = try JSONSerialization.jsonObject(with: data, options: [])
                
                guard let
                    jsonDictionary = jsonObject as? [AnyHashable: Any],
                    let photos = jsonDictionary["photos"] as? [String:AnyObject],
                    let photosArray = photos["photo"] as? [[String:AnyObject]] else {
                        
                        // The JSON structure doesn't match our expectations
                        return .failure(FlickrError.invalidJSONData)
                }
                
                var finalPhotos = [Photo]()
                for photoJSON in photosArray {
                    if let photo = photoFromJSONObject(photoJSON, inContext: context) {
                        finalPhotos.append(photo)
                    }
                }
                
                if finalPhotos.isEmpty && !photosArray.isEmpty {
                    // We weren't able to parse any of the photos.
                    // Maybe the JSON format for photos has changed.
                    return .failure(FlickrError.invalidJSONData)
                }
                return .success(finalPhotos)
            }
            catch let error {
                return .failure(error)
            }
    }
    
    fileprivate class func photoFromJSONObject(_ json: [String : AnyObject],
        inContext context: NSManagedObjectContext) -> Photo? {
            
            guard let
                photoID = json["id"] as? String,
                let title = json["title"] as? String,
                let dateString = json["datetaken"] as? String,
                let photoURLString = json["url_h"] as? String,
                let url = URL(string: photoURLString),
                let dateTaken = dateFormatter.date(from: dateString) else {
                    
                    // Don't have enough information to construct a Photo
                    return nil
            }
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Photo")
            let predicate = NSPredicate(format: "photoID == \(photoID)")
            fetchRequest.predicate = predicate
            
            var fetchedPhotos: [Photo]!
            context.performAndWait() {
                fetchedPhotos = try! context.fetch(fetchRequest) as! [Photo]
            }
            if let existingPhoto = fetchedPhotos.first {
                return existingPhoto
            }
            
            var photo: Photo!
            context.performAndWait({ () -> Void in
                photo = NSEntityDescription.insertNewObject(forEntityName: "Photo",
                    into: context) as! Photo
                photo.title = title
                photo.photoID = photoID
                photo.remoteURL = url
                photo.dateTaken = dateTaken
            })
            
            return photo
    }
    
}
