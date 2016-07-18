//
//  CoreDataHerper.swift
//  RSSReader
//
//  Created by Vladyslav on 7/18/16.
//  Copyright © 2016 Vladyslav. All rights reserved.
//

import UIKit
import CoreData

class CoreDataHerper: NSObject {

    var applicationDelegate: AppDelegate!
    var context: NSManagedObjectContext!
    
    // Create class singleton
    static let sharedInstance = CoreDataHerper()
    
    //MARK: Initialization
    
    private override init() {
        super.init()
        applicationDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        context = applicationDelegate.managedObjectContext
    }
        
    // MARK: CoreData managing
    
    func saveToCoreData(newsDataModel: [RSSItemModel]) {
        //let appDel = UIApplication.sharedApplication().delegate as! AppDelegate
        //let context = appDel.managedObjectContext
        
        for item in newsDataModel {
            do {
                let feedEntity = NSEntityDescription.insertNewObjectForEntityForName("Feed", inManagedObjectContext: context) as! Feed
                feedEntity.title = item.title
                feedEntity.descriptionText = item.descriptionText
                feedEntity.pubDate = item.pubDate
                feedEntity.url = item.link
                
                try context.save()
            } catch {
                //do nothing
            }
        }
    }
    
    func readFromCoreData() -> [RSSItemModel] {
        //let appDel = UIApplication.sharedApplication().delegate as! AppDelegate
        //let context = appDel.managedObjectContext
        
        let fetchRequest = NSFetchRequest(entityName: "Feed")
        
        do {
            let fetchedResults = try context.executeFetchRequest(fetchRequest) as! [Feed]
            let modelsArray = self.convertFromCoreData(fetchedResults)
            return modelsArray
            // success ...
        } catch let error as NSError {
            // failure
            print("Fetch failed: \(error.localizedDescription)")
            let modelsArray: [RSSItemModel] = []
            return modelsArray
        }
    }
    
    func deleteAllData() -> Bool {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "Feed")
        fetchRequest.returnsObjectsAsFaults = false
        
        do
        {
            let results = try managedContext.executeFetchRequest(fetchRequest)
            for managedObject in results
            {
                let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
                managedContext.deleteObject(managedObjectData)
            }
            return true
        } catch let error as NSError {
            print("Error: \(error)")
            return false
        }
    }
    
    //MARK: Objects Converting
    
    func convertFromCoreData(coreDataNews: [Feed]) -> [RSSItemModel] {
        var modelArray: [RSSItemModel] = []
        
        for feedCoreDataItem in coreDataNews {
            let newsItem = RSSItemModel()
            
            newsItem.title = feedCoreDataItem.title!
            newsItem.descriptionText = feedCoreDataItem.descriptionText!
            newsItem.pubDate = feedCoreDataItem.pubDate!
            newsItem.link = feedCoreDataItem.url!
            
            modelArray.append(newsItem)
        }
        return modelArray
    }
    
}
