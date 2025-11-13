//
//  ToDoMVVMApp.swift
//  ToDoMVVM
//
//  Created by Enzo Henrique Botelho Romão on 04/11/25.
//

import SwiftUI
import SwiftData

@main
struct ToDoMVVMApp: App {
    
    let container: ModelContainer
    
    init() {
        do {
            container = try ModelContainer(for: TodoItem.self)
        } catch {
            fatalError("Falha ao configurar o ModelContainer: \(error)")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            TodoListView()
        }
        .modelContainer(container)
        .environmentObject(TodoViewModel(context: container.mainContext))
    }
}
