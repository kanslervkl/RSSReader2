//
//  News+CoreDataProperties.swift
//  RSSReader3
//
//  Created by Mac on 10.09.16.
//  Copyright © 2016 KanslerSoft. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension News {

    @NSManaged var descriptionNews: String?
    @NSManaged var image: NSData?
    @NSManaged var pubDate: String?
    @NSManaged var title: String?

}
