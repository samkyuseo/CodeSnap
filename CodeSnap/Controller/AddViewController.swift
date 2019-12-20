//
//  AddViewController.swift
//  CodeSnap
//
//  Created by Samuel Kyu-Seo Lee on 12/12/19.
//  Copyright © 2019 Samuel Kyu-Seo Lee. All rights reserved.
//

import UIKit

class AddViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate {
    
    //IBOutlets
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var codeTextView: UITextView!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    //Data for this variable will be received from ViewController.swift
    var unEditedCode:String?
    //Global variable for text view and text field
    var textViewField = ["view": false, "field":false]
    //Shared model
    var singleton = SavedCodeDataModel.singleton
    override func viewDidLoad() {
        super.viewDidLoad()
        
        saveButton.isEnabled = false
        codeTextView.delegate = self
        titleTextField.delegate = self
        if let text = unEditedCode {
            codeTextView.text = text
            
        }
        else {
            codeTextView.text = "Could not convert code"
        }
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        if (saveButton.isEnabled) {
            let code = codeTextView.text ?? ""
            let title = titleTextField.text ?? ""
            singleton.insert(title: title, code: code, at: singleton.numSavedCodes()-1)
           dismiss(animated: true, completion: nil)
       }
    }
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        titleTextField.text = ""
        codeTextView.text = ""
        
        
        // close view
        dismiss(animated: true, completion: nil)
    }
    //Functions below do two things 1) Make keyboard go away appropriately, 2) update text in the textView/Field
    func textFieldShouldReturn (_ textField: UITextField) -> Bool {
        if textField == titleTextField {
            titleTextField.resignFirstResponder()
            codeTextView.becomeFirstResponder()
            enableSaveButton()
        }
        enableSaveButton()
        return true
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
  
        if let text = textView.text, let textRange = Range(range, in: text) {
            
            let updatedText = text.replacingCharacters(in: textRange, with: text)
            
            if updatedText.count > 0 {
                enableSaveButton()
            }
            else if updatedText.count == 0 {
                enableSaveButton()
            }
        }
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

         if let text = textField.text, let textRange = Range(range, in: text) {
             
             let updatedText = text.replacingCharacters(in: textRange, with: string)
             
             if updatedText.count > 0 && textField == titleTextField {
                 enableSaveButton()
             }
             else if updatedText.count == 0 && textField == titleTextField  {
                 enableSaveButton()
             }
             
         }
         return true
     }
    //Enable save button if both fields are filled out
    func enableSaveButton() {
        saveButton.isEnabled = titleTextField.text != nil && codeTextView.text != nil
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//    }
    

}
