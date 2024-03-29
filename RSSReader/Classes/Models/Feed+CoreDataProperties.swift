//
//  Feed+CoreDataProperties.swift
//  RSSReader
//
//  Created by Vladyslav on 7/17/16.
//  Copyright © 2016 Vladyslav. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Feed {

    @NSManaged var title: String?
    @NSManaged var descriptionText: String?
    @NSManaged var pubDate: String?
    @NSManaged var url: String?

}
