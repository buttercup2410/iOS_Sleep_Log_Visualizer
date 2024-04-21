//
//  LogList+CoreDataProperties.swift
//  assignment12
//
//  Created by Yash Patil on 20/04/24.
//
//

import Foundation
import CoreData


extension LogList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LogList> {
        return NSFetchRequest<LogList>(entityName: "LogList")
    }

    @NSManaged public var dateAndTime1: Date?
    @NSManaged public var sleepHours1: Double
    @NSManaged public var exerciseHours1: Double
    @NSManaged public var weightInPounds1: Double

}

extension LogList : Identifiable {
    
}
