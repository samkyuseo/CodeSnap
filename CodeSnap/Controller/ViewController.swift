//
//  ViewController.swift
//  CodeSnap
//
//  Created by Samuel Kyu-Seo Lee on 11/20/19.
//  Copyright © 2019 Samuel Kyu-Seo Lee. All rights reserved.
//

import UIKit
import CoreML
import Vision //Allow us to us to process images more easily
import FirebaseMLVision


//UIImagePickerClass needs two delegates
@available(iOS 13.0, *)

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    //ImageView on the camera view controller
    @IBOutlet weak var imageView: UIImageView!
    
    //Converted text will be placed here
    @IBOutlet weak var codeTextLabel: UILabel!
    
    //Opens segue
    @IBOutlet weak var processResultsButton: UIBarButtonItem!
    
    //Create image picker object
    let imagePicker = UIImagePickerController()
    
    //Declare text recognizer
    var textRecognizer: VisionTextRecognizer!
    
    //Declare any global vars
    var detectedText:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let vision = Vision.vision()
        textRecognizer = vision.onDeviceTextRecognizer()
    
        imagePicker.delegate = self  //Set image picker's delegate to the current VC
        //imagePicker.sourceType = .photoLibrary //Brings in camera module
        imagePicker.sourceType = .camera //Replace with this when you get a ipod
        imagePicker.allowsEditing = true //user is allowed to edit the image
        navigationItem.title = "Snap some code!"
        // Request that processes any text that is found
        if detectedText == nil {
            processResultsButton.isEnabled = false
        }
    }
    
    //Tells delegate that user has picked image
    //picker - the vc that image was picked in
    //info - contains image user picked in dictionary form
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //Access original unedited image downcasting to a UIImage
        if let userPickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            //Set image view to the image that was taken
            imageView.image = userPickedImage
            detect(image: userPickedImage)
        }
        imagePicker.dismiss(animated: true, completion: nil)
        
    }
    
    // This function finds text with the image
    func detect(image: UIImage){
        let visionImage = VisionImage(image: image)
        self.textRecognizer.process(visionImage) {(result, error) in
            guard error == nil, let result = result else {
              fatalError("Error while trying to process image")
            }
            //results are stored in blocks of text/ Each block contains lines 
            let features = result
            var resultsString: String = "";
            for block in features.blocks {
                for line in block.lines {
                    resultsString += "\(line.text)\n"
                }
            }
            self.navigationItem.title = "Results"
            self.processResultsButton.isEnabled = true
            self.detectedText = resultsString
        }
    }
    
    //Camera Icon tapped on the navigation bar
    @IBAction func cameraTapped(_ sender: UIBarButtonItem) {
        //Present the imagePicker controller when the  camera button is clicked
        present(imagePicker, animated: true, completion: nil)
    }
    
    //Before taking segue pass in string to next view controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if segue.identifier == "goToAddViewController", let vc = segue.destination as? AddViewController {
            if let text = detectedText {
                vc.unEditedCode = text
            }
            else {
                vc.unEditedCode = nil
           }
        }
   }
}

