//
//  LogList+CoreDataProperties.swift
//  assignment12
//
//  Created by Yash Patil on 21/04/24.
//
//

import Foundation
import CoreData


extension LogList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LogList> {
        return NSFetchRequest<LogList>(entityName: "LogList")
    }

    @NSManaged public var dateAndTime: Date?
    @NSManaged public var exerciseHours: Double
    @NSManaged public var sleepHours: Double
    @NSManaged public var weight: Double
    @NSManaged public var sleepQuality: String

}

extension LogList : Identifiable {

}
