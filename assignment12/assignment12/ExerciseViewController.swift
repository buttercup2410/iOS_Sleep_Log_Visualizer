//
//  ExerciseViewController.swift
//  assignment12
//
//  Created by Yash Patil on 19/04/24.
//

import UIKit

class ExerciseViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var pickerView: UIPickerView!
    
    let exerciseRange: [Double] = Array(stride(from: 0.5, through: 15.0, by: 0.5))
            
    let exerciseSelectionNotification = Notification.Name("ExerciseSelectionNotification")
       
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedHours = exerciseRange[row]
        NotificationCenter.default.post(name: exerciseSelectionNotification, object: nil, userInfo: ["exercise": selectedHours])
        dismiss(animated: true, completion: nil)
    }
    
    func handleExerciseSelection(_ exercise: Double) {
        NotificationCenter.default.post(name: exerciseSelectionNotification, object: nil, userInfo: ["exercise": exercise])
        dismiss(animated: true, completion: nil)
    }
        
    func hourSelected(_ exercise: Double) {
        handleExerciseSelection(exercise)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
            
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return exerciseRange.count
    }
        
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(exerciseRange[row]) hours"
    }
}
