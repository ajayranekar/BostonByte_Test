//
//  DetailsVC.swift
//  BostonByte_Test
//
//  Created by Apple on 18/11/19.
//  Copyright © 2019 Ajay Ranekar. All rights reserved.
//

import UIKit

class DetailsVC: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var bottomView: UIView!
    
    var vcType: String?
    var data: [String: Any]?
    
    var completionHandler: (([String: Any]) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initViews()
    }
    
    
    //    MARK:- Initialize View Method
    fileprivate func initViews() {
        descriptionTextView.layer.borderColor = UIColor.lightGray.cgColor
        descriptionTextView.layer.borderWidth = 0.5
        descriptionTextView.layer.cornerRadius = 4
        
        titleTextField.delegate = self
        saveButton.layer.cornerRadius = 2
        
        if ((vcType ?? "") == "details" ) {
            // if this is details screen
            titleTextField.text = data?["title"] as? String
            descriptionTextView.text = data?["details"] as? String
            
            imageView.image = data?["image"] as? UIImage
            
            titleTextField.isEnabled = false
            descriptionTextView.isEditable = false
            
            self.title = "Details"
            saveButton.isHidden = true
            bottomView.isHidden = true
        } else {
            // if this is add screen
            self.title = "Add Movie"
            saveButton.isHidden = false
            bottomView.isHidden = false
            
            titleTextField.text = ""
            descriptionTextView.text = ""
            
            titleTextField.isEnabled = true
            descriptionTextView.isEditable = true
            
            imageView.image = #imageLiteral(resourceName: "home")
        }
    }
    
    @IBAction func saveButtonAction(_ sender: UIButton) {
        if isValid() {
            let title = titleTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
            let description = descriptionTextView.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
            completionHandler?(["title": title, "details": description, "image": #imageLiteral(resourceName: "home")])
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    fileprivate func isValid() -> Bool {
        let title = titleTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let description = descriptionTextView.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        
        if (title.isEmpty) {
            self.alert(message: "Please enter the title.")
            return false
        } else if (description.isEmpty) {
            self.alert(message: "Please enter the description.")
            return false
        }
        return true
    }
}

extension DetailsVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
