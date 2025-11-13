//
//  Item.swift
//  ToDoMVVM
//
//  Created by Enzo Henrique Botelho Romão on 04/11/25.
//

import Foundation
import SwiftData

@Model
final class TodoItem {
    var title: String
    var isCompleted: Bool
    
    init(title: String, isCompleted: Bool = false) {
        self.title = title
        self.isCompleted = isCompleted
    }
}
