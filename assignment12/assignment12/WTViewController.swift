//
//  WTViewController.swift
//  assignment12
//
//  Created by Yash Patil on 19/04/24.
//

import UIKit
import CoreData

class WTViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
        
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    var items:[LogList]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "LogCell")

        fetchLogEntry()
//        (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }
    
    func fetchLogEntry(){
        do{
            self.items = try context.fetch(LogList.fetchRequest())
            self.tableView.reloadData()
        }
        catch{
            print("Error fetching log: \(error)")
        }
    }
    
    func addLogEntry(hours: Double, quality: String, exercise: Double, weight: Double, date: Date) {
        let newItem = LogList(context: context)
        newItem.sleepHours = hours
        newItem.sleepQuality = quality
        newItem.exerciseHours = exercise
        newItem.weight = weight
        newItem.dateAndTime = date
        
        do {
            try context.save()
            fetchLogEntry()
        } catch {
            print("Error saving log: \(error)")
        }
    }
    
    func deleteLogEntry(at indexPath: IndexPath){
        guard let logToDelete = items?[indexPath.row] 
        else {
            print("Error: Unable to find log to delete at index \(indexPath.row)")
            return
        }
        context.delete(logToDelete)
        print("Deleting log: ", logToDelete)
        do {
            try context.save()
            fetchLogEntry()
        } catch {
            print("Error deleting log: \(error)")
        }
    }
    
}

extension WTViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LogCell", for: indexPath)
        if let log = self.items?[indexPath.row] {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM dd, yyyy - HH:mm"
                    
            let logText = """
                    Date & Time: \(dateFormatter.string(from: log.dateAndTime ?? Date()))
                    Hours of sleep: \(log.sleepHours) hours
                    Exercise time: \(log.exerciseHours) hours
                    Weight in pounds: \(log.weight) pounds
                    """
                    
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.text = logText
        } else {
            cell.textLabel?.text = "Unknown"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete Log") { [weak self] (action, view, completionHandler) in
            self?.deleteLogEntry(at: indexPath)
            completionHandler(true)
        }
        
        deleteAction.backgroundColor = UIColor(red: 147/255, green: 233/255, blue: 163/255, alpha: 1.0)
        
        if let trashIcon = UIImage(systemName: "trash.fill")?.withTintColor(.white, renderingMode: .alwaysOriginal) {
            deleteAction.image = trashIcon
        }
        
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [deleteAction])
        return swipeConfiguration
    }


}
