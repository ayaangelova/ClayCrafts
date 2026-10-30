//
//  ClayCrafts.swift
//  ClayCrafts
//
//  Created by Aya on 20.08.26.
//

import Foundation
import SwiftData

@Model
class ClayCrafts: Hashable{
    var name: String
    var details: String
    var difficulty: Int
    var startDate: Date
    var endDate:Date
    @Relationship(deleteRule: .cascade) var notes = [Note]()
    @Attribute(.externalStorage) var photoData:[Data]
    
    init(name: String = "", details: String = "", difficulty: Int = 2 , startDate:Date = Date.now, endDate: Date = Date.now, photoData: [Data] = []) {
        self.name = name
        self.details = details
        self.difficulty = difficulty
        self.startDate = startDate
        self.endDate = endDate
        self.photoData = photoData
    }
}
