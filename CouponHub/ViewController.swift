//
//  ViewController.swift
//  CouponHub
//
//  Created by Noah Michel on 12/22/22.
//

import UIKit

class ViewController : UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createDatePicker()
        
    }
    
    @IBOutlet weak var birthDateTxt : UITextField!
    
    let datePicker = UIDatePicker()
    
    func createDatePicker() {
        
        birthDateTxt.textAlignment = .center
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let finishButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(dateChosen))
        toolBar.setItems([finishButton], animated: true)
        
        birthDateTxt.inputAccessoryView = toolBar
        
        birthDateTxt.inputView = datePicker
        
        datePicker.datePickerMode = .date
    }
    
    @objc func dateChosen() {
        
        let format = DateFormatter()
        format.dateStyle = .medium
        format.timeStyle = .none
        
        birthDateTxt.text = format.string(from: datePicker.date)
        self.view.endEditing(true)
        
    }
}
