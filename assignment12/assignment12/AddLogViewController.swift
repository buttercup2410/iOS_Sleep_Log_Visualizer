//
//  AddLogViewController.swift
//  assignment12
//
//  Created by Yash Patil on 19/04/24.
//

import UIKit
import RealmSwift

class AddLogViewController: UIViewController {
    
    let hourSelectionNotification = Notification.Name("HourSelectionNotification")
    let qualitySelectionNotification = Notification.Name("QualitySelectionNotification")
    let exerciseSelectionNotification = Notification.Name("ExerciseSelectionNotification")

    override func viewDidLoad() {
        super.viewDidLoad()
        setupDatePicker()
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleHourSelection(_:)), name: hourSelectionNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleQualitySelection(_:)), name: qualitySelectionNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleExerciseSelection(_:)), name: exerciseSelectionNotification, object: nil)
    }
    
    @IBOutlet weak var dateTextField: UITextField!
    
    @IBOutlet var hoursButton: UIButton!
    
    @IBOutlet var qualityButton: UIButton!
    
    @IBOutlet var exButton: UIButton!
    
    @IBOutlet var weightTextField: UITextField!
    
    var selectedHours: Double = 0.0
    var selectedQuality: String = ""
    var selectedExercise: Double = 0.0
    
    @IBOutlet var hoursLabel: UILabel!
    
    @IBOutlet var qualityLabel: UILabel!
    
    @IBOutlet var exerciseLabel: UILabel!
    
    func didSelectHours(_ hours: Double) {
        selectedHours = hours
        hoursLabel.text = "\(hours) hours"
    }
    
    func didSelectQualityOfSleep(_ quality: String) {
        selectedQuality = quality
        qualityLabel.text = quality
    }
    
    func didSelectExercise(_ exercise: Double) {
        selectedExercise = exercise
        exerciseLabel.text = "\(exercise) hours"
    }
    
    @objc func handleHourSelection(_ notification: Notification) {
        if let userInfo = notification.userInfo, let hours = userInfo["hours"] as? Double {
            selectedHours = hours
            hoursLabel.text = "\(hours) hours"
        }
    }
    
    @objc func handleQualitySelection(_ notification: Notification) {
        if let userInfo = notification.userInfo, let quality = userInfo["quality"] as? String {
            selectedQuality = quality
            qualityLabel.text = quality
        }
    }
    
    @objc func handleExerciseSelection(_ notification: Notification) {
        if let userInfo = notification.userInfo, let exercise = userInfo["exercise"] as? Double {
            selectedExercise = exercise
            exerciseLabel.text = "\(exercise) hours"
        }
    }
    
    @IBAction func submitButton(_ sender: Any) {
        guard let weightText = weightTextField.text, !weightText.isEmpty,
            !qualityLabel.text!.isEmpty,
            !hoursLabel.text!.isEmpty,
            !exerciseLabel.text!.isEmpty,
            !dateTextField.text!.isEmpty else {
            showAlert(message: "Please fill in all fields!")
            return
        }
        
        let selectedDate = datePicker.date
        _ = weightTextField.text ?? ""

        guard let weightText = weightTextField.text, let weight = Double(weightText)
        else {
            return
        }
            
        if let wtVC = presentingViewController as? WTViewController {
            wtVC.addLogEntry(hours: selectedHours, quality: selectedQuality, exercise: selectedExercise, weight: weight, date: selectedDate)
        }
        print("------- Adding log -------")
        print("Date & Time: ", selectedDate)
        print("Hours of sleep: ", selectedHours)
        print("Quality of sleep: ", selectedQuality)
        print("Exercise time: ", selectedExercise)
        print("Weight in pounds: ", weight)
        print("--------------------------")
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    let datePicker = UIDatePicker()
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd, yyyy - HH:mm"
        return formatter
    }()
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    func setupDatePicker() {
        datePicker.datePickerMode = .dateAndTime
        dateTextField.inputView = datePicker
        dateTextField.text = dateFormatter.string(from: datePicker.date)
        datePicker.frame.size = CGSize(width: 0, height: 100)
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneButton], animated: true)
        dateTextField.inputAccessoryView = toolbar
    }
    
    @objc func donePressed() {
        dateTextField.text = dateFormatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
}
