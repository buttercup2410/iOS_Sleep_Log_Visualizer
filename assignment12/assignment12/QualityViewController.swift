//
//  QualityViewController.swift
//  assignment12
//
//  Created by Yash Patil on 19/04/24.
//

import UIKit

class QualityViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var pickerView: UIPickerView!
    
    let sleepQualityOptions = ["Excellent", "Very good", "Good", "Fair", "Poor"]
        
    let qualitySelectionNotification = Notification.Name("QualitySelectionNotification")
        
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedHours = sleepQualityOptions[row]
        NotificationCenter.default.post(name: qualitySelectionNotification, object: nil, userInfo: ["quality": selectedHours])
        dismiss(animated: true, completion: nil)
    }
    
    func handleQualitySelection(_ quality: String) {
        NotificationCenter.default.post(name: qualitySelectionNotification, object: nil, userInfo: ["quality": quality])
        dismiss(animated: true, completion: nil)
    }
        
    func qualitySelected(_ quality: String) {
        handleQualitySelection(quality)
    }
                
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
        
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return sleepQualityOptions.count
    }
        
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return sleepQualityOptions[row]
    }

}
