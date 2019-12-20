//
//  EditViewController.swift
//  CodeSnap
//
//  Created by Samuel Kyu-Seo Lee on 12/13/19.
//  Copyright © 2019 Samuel Kyu-Seo Lee. All rights reserved.
//

import UIKit

class EditViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var codeTextView: UITextView!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    let singleton = SavedCodeDataModel.singleton
      
    var editIndex: Int?
    var tableView: UITableView?
      //Global variable for text view and text field
    var textViewField = ["view": false, "field":false]

    override func viewDidLoad() {
        super.viewDidLoad()

        saveButton.isEnabled = false
        codeTextView.delegate = self
        titleTextField.delegate = self
        if let index = editIndex {
            codeTextView.text = singleton.savedCode(at: index)?.code ?? ""
            titleTextField.text = singleton.savedCode(at: index)?.title ?? ""
        }
        enableSaveButton()
      // Do any additional setup after loading the view.
    }
      
    //Actually change the singleton, after change is made. Update table view after doing so
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        if (saveButton.isEnabled) {
            let code = codeTextView.text ?? ""
            let title = titleTextField.text ?? ""
            print(editIndex!)
            singleton.remove(at: editIndex!)
            singleton.insert(title: title, code: code, at: editIndex!)
            if let tV = tableView {
                tV.reloadData()
            }
            dismiss(animated: true, completion: nil)
        }
    }
   
    //IB outlet for canceling segue
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        titleTextField.text = ""
        codeTextView.text = ""
        
        // close view
        dismiss(animated: true, completion: nil)
    }
    //Keyboard disappearing
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
      //Only enable if both are full
      func enableSaveButton() {
          saveButton.isEnabled = titleTextField.text != nil && codeTextView.text != nil
    }

}
