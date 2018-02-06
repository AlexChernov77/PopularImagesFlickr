//
//  NewsFabrique.swift
//  MyFlickr
//
//  Created by Александр Чернов on 07.01.2018.
//  Copyright © 2018 Александр Чернов. All rights reserved.
//

import CoreData

class NewsFabrique
{
    class func setNews ( id : String , url : String , title : String , context : NSManagedObjectContext )
    {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "News")
        let predicate = NSPredicate(format: "id=%@", id)
        fetchRequest.predicate = predicate
        
        let fetchResults = try? context.fetch(fetchRequest) as! [News]
        
        if fetchResults!.count == 0
        {
            let news = NSEntityDescription.insertNewObject(forEntityName: "News", into: context) as! News
            
            news.id = id
            news.photoURL = url
            news.title = title
        }
        else
        {
            let news = fetchResults![0]
            
            news.photoURL = url
            news.title = title
        }
    }
}
