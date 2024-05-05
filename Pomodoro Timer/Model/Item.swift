//
//  Item.swift
//  Pomodoro Timer
//
//  Created by Ray Chow on 18/4/2024.
//

import Foundation
import SwiftData

@Model
final class Item : ObservableObject, Hashable{
    var timestamp: Date
    @Attribute var name: String
    static let defaultNamePrefix = "Timer"
    
    var workTime: Int
    var shortBreakTime:Int
    var longBreakTime: Int
    var cycle: Int
    var breakArray: [TimeInterval]
    var editHistory:[String]
    var displayOrder: Int
    var notes: String
    
    init(timestamp: Date = .now, nameSuffix: Int, displayOrder: Int, notes: String = "") {
        self.timestamp = timestamp
        self.name = "\(Item.defaultNamePrefix)\(nameSuffix)"
        self.workTime = 25
        self.shortBreakTime = 5
        self.longBreakTime = 25
        self.cycle = 4
        self.breakArray = []
        self.editHistory = []
        self.displayOrder = displayOrder
        self.notes = notes
    }
}
