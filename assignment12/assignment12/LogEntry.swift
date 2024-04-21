//
//  LogEntry.swift
//  assignment12
//
//  Created by Yash Patil on 20/04/24.
//

import Foundation
import RealmSwift

class LogEntry: Object {
    @objc dynamic var date: Date = Date()
    @objc dynamic var hoursOfSleep: Double = 0.0
    @objc dynamic var qualityOfSleep: String = ""
    @objc dynamic var exerciseDuration: Double = 0.0
    @objc dynamic var weight: Double = 0.0
}
