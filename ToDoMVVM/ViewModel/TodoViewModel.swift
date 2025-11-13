//
//  TodoViewModel.swift
//  ToDoMVVM
//
//  Created by Enzo Henrique Botelho Romão on 04/11/25.
//

import SwiftData
import Combine
import SwiftUI

class TodoViewModel: ObservableObject {
    
    private var modelContext: ModelContext
    
    @Published var items: [TodoItem] = []
    @Published var showingCreateModal: Bool = false
    @Published var itemTitle: String = ""
    
    init(context: ModelContext) {
        self.modelContext = context
        fetchItems()
    }
    
    func fetchItems() {
        do {
            let descriptor = FetchDescriptor<TodoItem>(sortBy: [SortDescriptor(\.title)])
            try self.items = modelContext.fetch(descriptor)
        } catch {
            print("Não foi possível carregar os itens do contexto de dados")
        }
    }
    
    func addItem() {
        let newItem = TodoItem(title: itemTitle)
        modelContext.insert(newItem)
        items.append(newItem)
        
        dismissSheet()
    }
    
    func deleteItem(offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(items[index])
        }
        items.remove(atOffsets: offsets)
    }
    
    func toggleCompletion(item: TodoItem) {
        item.isCompleted.toggle()
    }
    
    func openCreateItemModal() {
        showingCreateModal = true
    }
    
    func dismissSheet() {
        itemTitle = ""
        showingCreateModal = false
    }
}
