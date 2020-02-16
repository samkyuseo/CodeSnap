//
//  CodeFormatter.swift
//  CodeSnap
//
//  Created by Samuel Kyu-Seo Lee on 12/20/19.
//  Copyright © 2019 Samuel Kyu-Seo Lee. All rights reserved.
//

import Foundation
struct CodeFormatter {
    
    func add_indents(formatted_string: inout String, indents: Int) -> Void {
        for _ in 0..<indents {
            formatted_string += "\t";
        }
        return
    }
    
    func formatCode(code: String, language: String) -> String {
        
        if (code == "") {
            return ""
        }
        
        var result = ""
        var indents = 0

        var i=0
        
        while (i < code.count-2 ) {
            
            var temp_word = "";
            while (Array(code)[i] != " " && i < code.count-2) {
                let curr = Array(code)[i];
                let next = Array(code)[i+1];
                
                if (next == "}") {
                    indents -= 1
                }
                else if (curr == "{") {
                    indents += 1
                }
                
                if (String(Array(code)[i]) == "\n") {
                    temp_word += "\n";
                    temp_word += "~";
                    break;
                    
                }
                else {
                    temp_word += String(Array(code)[i]);
                }
                
                i += 1;
            }
            
            result += temp_word;
            result += " ";
            
           // print(String(Array(temp_word)[temp_word.count-1]));
            if (String(Array(temp_word)[temp_word.count-1]) == "~") {
                result = String(result.dropLast());
                add_indents(formatted_string: &result, indents: indents)
            }
            
            i += 1;
        }
        result += "}"
        //print(result);
        let trimmedString = result.replacingOccurrences(of: "~", with: "", options: .regularExpression)
        return trimmedString;
    }
    
}
//struct CodeFormatter {
//    let formatterURL = "http://localhost:5000/api/format"
//
//    func fetchUnformatted(code: String, language: String) {
//        let dict = ["unformattedCode": code, "codeLanguage":language]
//        guard let jsonData = try? JSONSerialization.data(withJSONObject: dict) else {
//            print("JSON Serialization Error")
//            return
//        }
//        performRequest(jsonData: jsonData)
//    }
//    func performRequest (jsonData: Data) {
//        //1. Create URL
//        if let url = URL(string: formatterURL) {
//            //1.5 create URL request, add header and body
//            var request = URLRequest(url: url)
//            request.httpMethod = "POST"
//            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//            request.httpBody = jsonData
//            //2. Create a URL Session
//            let session = URLSession(configuration: .default)
//            //3. Give URL Sesson a task
//            let task = session.dataTask(with: request, completionHandler: handle(data:response:error:))
//            //4. Start the task
//            task.resume()
//        }
//    }
//    func handle(data: Data?, response: URLResponse?, error: Error?) {
//        if error != nil {
//            print(error!)
//            return
//        }
//        if let safeData = data {
//            let dataString = String(data: safeData, encoding: .utf8)
//            print(dataString!)
//        }
//     }
//}
