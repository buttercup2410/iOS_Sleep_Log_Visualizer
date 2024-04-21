//
//  VisualizeViewController.swift
//  assignment12
//
//  Created by Yash Patil on 19/04/24.
//

import UIKit
//import Charts
import DGCharts
import RealmSwift
import CoreData

class VisualizeViewController: UIViewController {
    
    @IBOutlet weak var sleepChartView: LineChartView!
    
    @IBOutlet weak var qualityChartView: LineChartView!
    
    @IBOutlet weak var exerciselineChartView: LineChartView!
    
    @IBOutlet weak var weightChartView: LineChartView!
    
    let sleepQualityOptions = ["Excellent", "Very good", "Good", "Fair", "Poor"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchLogs()
    }
    
    func fetchLogs() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<LogList> = LogList.fetchRequest()
        do {
            let logs = try context.fetch(fetchRequest)
            print("Fetched \(logs.count) logs.")
            print(logs)
            createLineChartForHoursSlept(logs: logs)
            createLineChartForQuality(logs: logs)
            createLineChartForExercise(logs: logs)
            createLineChartForWeight(logs: logs)
        } catch {
            print("Error fetching logs: \(error)")
        }
    }
       
    func createLineChartForHoursSlept(logs: [LogList]) {
        var dataEntries: [ChartDataEntry] = []
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy - HH:mm"
        
        // Sort logs by date and time in ascending order
        let sortedLogs = logs.sorted { $0.dateAndTime! < $1.dateAndTime! }
        
        for (index, log) in sortedLogs.enumerated() {
            let dataEntry = ChartDataEntry(x: Double(index), y: log.sleepHours)
            dataEntries.append(dataEntry)
        }
        
        let dataSet = LineChartDataSet(entries: dataEntries, label: "Hours Slept")
        let data = LineChartData(dataSet: dataSet)
        dataSet.colors = [UIColor(red: 244/255, green: 124/255, blue: 124/255, alpha: 1)]
        dataSet.circleColors = [UIColor(red: 255/255, green: 124/255, blue: 124/255, alpha: 1)]

        sleepChartView.data = data
        

    }
//    func createLineChartForHoursSlept(logs: [LogList]) {
//        var dataEntries: [ChartDataEntry] = []
//        for (index, log) in logs.enumerated() {
//            let dataEntry = ChartDataEntry(x: Double(index), y: log.sleepHours)
//            dataEntries.append(dataEntry)
//        }
//            
//        let dataSet = LineChartDataSet(entries: dataEntries, label: "Hours Slept")
//        let data = LineChartData(dataSet: dataSet)
//            
//        sleepChartView.data = data
//    }
    
    func createLineChartForQuality(logs: [LogList]) {
        var dataEntries: [ChartDataEntry] = []
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy - HH:mm"
            
        let sortedLogs = logs.sorted { $0.dateAndTime! < $1.dateAndTime! }
            
        for (index, log) in sortedLogs.enumerated() {
            let qualityNum = 5 - sleepQualityOptions.firstIndex(of: log.sleepQuality)!
            let dataEntry = ChartDataEntry(x: Double(index), y: Double(qualityNum))
            dataEntries.append(dataEntry)
        }
            
        let dataSet = LineChartDataSet(entries: dataEntries, label: "Sleep Quality")
        let data = LineChartData(dataSet: dataSet)
        dataSet.colors = [UIColor(red: 241/255, green: 180/255, blue: 47/255, alpha: 1)]
        dataSet.circleColors = [UIColor(red: 241/255, green: 180/255, blue: 47/255, alpha: 1)]

        qualityChartView.data = data

    }
    
    func createLineChartForExercise(logs: [LogList]) {
        var dataEntries: [ChartDataEntry] = []
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM dd, yyyy - HH:mm"
            
        let sortedLogs = logs.sorted { $0.dateAndTime! < $1.dateAndTime! }
            
        for (index, log) in sortedLogs.enumerated() {
            let dataEntry = ChartDataEntry(x: Double(index), y: log.exerciseHours)
            dataEntries.append(dataEntry)
        }
            
        let dataSet = LineChartDataSet(entries: dataEntries, label: "Hours Exercised")
        let data = LineChartData(dataSet: dataSet)
        dataSet.colors = [UIColor(red: 161/255, green: 235/255, blue: 147/255, alpha: 1)]
        dataSet.circleColors = [UIColor(red: 161/255, green: 235/255, blue: 147/255, alpha: 1)]

        exerciselineChartView.data = data

    }
    
    func createLineChartForWeight(logs: [LogList]) {
        var dataEntries: [ChartDataEntry] = []
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy - HH:mm"
            
        let sortedLogs = logs.sorted { $0.dateAndTime! < $1.dateAndTime! }
            
        for (index, log) in sortedLogs.enumerated() {
            let dataEntry = ChartDataEntry(x: Double(index), y: log.weight)
            dataEntries.append(dataEntry)
        }
            
        let dataSet = LineChartDataSet(entries: dataEntries, label: "Weight in Pounds")
        let data = LineChartData(dataSet: dataSet)
        dataSet.colors = [UIColor(red: 112/255, green: 161/255, blue: 215/255, alpha: 1)]
        dataSet.circleColors = [UIColor(red: 112/255, green: 161/255, blue: 215/255, alpha: 1)]

        weightChartView.data = data

    }
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

}
