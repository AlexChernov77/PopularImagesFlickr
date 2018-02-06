//
//  DataLayer.swift
//  MyFlickr
//
//  Created by Александр Чернов on 02.01.2018.
//  Copyright © 2018 Александр Чернов. All rights reserved.
//

import UIKit

class DataLayer {
    
    static let shared = DataLayer()
    func getData ( completion: @escaping () -> Void) {
        API_WRAPPER.getRawData { response in
            let photosObject = response["photos"]
            let photosArray = photosObject["photo"].arrayValue

            let backgroundContext = CoreDataManager.sharedInstance.getBackgroudContext()
            
            for i in 0..<photosArray.count {
                let photo = photosArray[i]
                
                let id = photo["id"].stringValue
                let farmId = photo["farm"].int64Value
                let serverId = photo["server"].int64Value
                let secret = photo["secret"].stringValue
                let photoURL = "https://farm\(farmId).staticflickr.com/\(serverId)/\(id)_\(secret).jpg"
                let title = photo["title"].stringValue

                print ("\(i) - \(photo)")
                
                NewsFabrique.setNews(id: id, url: photoURL, title: title, context: backgroundContext)
            }
            _ = try? backgroundContext.save()
        }
                completion()
    }
}

