//
//  ImageListPresenter.swift
//  MyFlickr
//
//  Created by Александр Чернов on 05.01.2018.
//  Copyright © 2018 Александр Чернов. All rights reserved.
//

import CoreData

class ImageListPresenter: NSObject
{
    
    weak var viewInput: ViewInput?

    
    lazy var fetchedResultController : NSFetchedResultsController<NSFetchRequestResult> = {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "News")
        let sortDescriptor = NSSortDescriptor(key: "id", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataManager.sharedInstance.getMainContext(), sectionNameKeyPath: nil, cacheName: nil)
        
        frc.delegate = self
        _ = try? frc.performFetch()
        
        
        return frc
    }()
    
    func getData ()
    {
        DataLayer.shared.getData { () in
            CoreDataManager.sharedInstance.save()
            
        }
    }
}

extension ImageListPresenter: PresenterInput
{


    
    func viewLoaded(view: ViewInput) {
        self.viewInput = view
        getData()
    }
}

extension ImageListPresenter: PresenterOutput
{

    
    func numberOfEntities() -> Int {
        if let objectsArray = fetchedResultController.fetchedObjects
        {
            return objectsArray.count
        }
        
        return 0
    }
    
    func entityAt(indexPath: IndexPath) -> Any? {
    return fetchedResultController.object(at: indexPath)
    }
}

//MARK:- протокол FetchedResultsControllerDelegate
extension ImageListPresenter : NSFetchedResultsControllerDelegate
{
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>)
    {
        
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?)
    {
        viewInput?.reloadData()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>)
    {
        
    }
}


