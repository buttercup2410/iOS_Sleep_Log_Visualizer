//
//  HoursViewController.swift
//  assignment12
//
//  Created by Yash Patil on 19/04/24.
//

import UIKit

class HoursViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var pickerView: UIPickerView!
    
    let hoursRange: [Double] = Array(stride(from: 0.5, through: 15.0, by: 0.5))
        
    let hourSelectionNotification = Notification.Name("HourSelectionNotification")
        
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedHours = hoursRange[row]
        NotificationCenter.default.post(name: hourSelectionNotification, object: nil, userInfo: ["hours": selectedHours])
        dismiss(animated: true, completion: nil)
    }
    
    func handleHourSelection(_ hours: Double) {
        NotificationCenter.default.post(name: hourSelectionNotification, object: nil, userInfo: ["hours": hours])
        dismiss(animated: true, completion: nil)
    }
        
    func hourSelected(_ hours: Double) {
        handleHourSelection(hours)
    }
                
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
        
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return hoursRange.count
    }
        
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(hoursRange[row]) hours"
    }

}
