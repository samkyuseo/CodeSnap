//
//  SavedCode.swift
//  CodeSnap
//
//  Created by Samuel Kyu-Seo Lee on 12/13/19.
//  Copyright © 2019 Samuel Kyu-Seo Lee. All rights reserved.
//

import Foundation
//Basic Struct with title and codesnippet
struct SavedCode:Equatable {
    public var title: String
    public var code: String
    
    init(title: String, code: String) {
        self.title = title
        self.code = code
    }
}
