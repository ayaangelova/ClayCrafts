//
//  Note.swift
//  ClayCrafts
//
//  Created by Aya on 20.08.26.
//

import Foundation
import SwiftData

@Model
class Note{
    var name: String
    var craft: ClayCrafts
    
    init(name: String, craft: ClayCrafts) {
        self.name = name
        self.craft = craft
    }
}
