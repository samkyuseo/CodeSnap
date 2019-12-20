//
//  SavedCodeDataModel.swift
//  CodeSnap
//
//  Created by Samuel Kyu-Seo Lee on 12/13/19.
//  Copyright © 2019 Samuel Kyu-Seo Lee. All rights reserved.
//

import Foundation
// Class containing single ton
class SavedCodeDataModel: NSObject {
    static let singleton = SavedCodeDataModel()
    private var savedCodes = [SavedCode]()
    var filepath:String
    
    override init() {
        //Implement data persistance 
        let manager = FileManager.default
        filepath = ""
        if let url = manager.urls(for: .documentDirectory,
                                  in: .userDomainMask).first {
            filepath = url.appendingPathComponent("savedCodes.plist").path
            print("filepath=\(filepath)")
        }
        //if file path, extract content to display in app
        if manager.fileExists(atPath: filepath) {
            if let savedCodesArray = NSArray(contentsOfFile: filepath) {
                if savedCodesArray.count == 0 {
                    savedCodes = []
                }
                else {
                    for dict in savedCodesArray {
                        // converting from NSString to String
                        let savedCodesDict = dict as! [String: String]
                        if let titleString = savedCodesDict["titleKey"],
                            let codeString = savedCodesDict["codeKey"] {
                            
                            let savedCode = SavedCode(title: titleString, code: codeString)
                            savedCodes.append(savedCode)
                        }
                    }
                }
            }
        }
        else {
            savedCodes = []
        }
    }
    func numSavedCodes() -> Int {
        return savedCodes.count
    }
    
    func savedCode (at index: Int) -> SavedCode? {
        if index >= 0 && index <= savedCodes.count {
            return savedCodes[index]
        }
        else {
            return nil
        }
    }
    
    func rearrageSavedCodes(from: Int, to: Int) {
       let temp = savedCodes[from]
       savedCodes[from] = savedCodes[to]
       savedCodes[to] = temp
       save()
    }
    
    //insert flashcard with an index --> add it at the index lol
    func insert(title: String, code: String, at index: Int) { //tested
       let savedCode = SavedCode(title: title, code: code)
       if savedCodes.count == 0 {
           savedCodes.append(savedCode)
       }
       else if index >= 0 && index <= savedCodes.count {
           savedCodes.insert(savedCode, at: index)
       }
       save()
    }

    func remove(at index: Int) { //tested
       if savedCodes.count == 0 {
           return
       }
       if index >= 0 && index < savedCodes.count {
           savedCodes.remove(at: index)
           save()
       }
    }
    
    private func save() {
        // an array of dictionary objects where the keys are Strings and values are Strings
        var savedCodesArray = [[String:String]]()
        
        // loop thru array of Quotes and put into quotesArray
        for savedCode in savedCodes {
            let dict = ["titleKey": savedCode.title,
                        "codeKey": savedCode.code]
            savedCodesArray.append(dict)
        }
        
        // write to the file system
        (savedCodesArray as NSArray).write(toFile: filepath, atomically: true)
    }
}
