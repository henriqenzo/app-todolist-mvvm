//
//  TodoListView.swift
//  ToDoMVVM
//
//  Created by Enzo Henrique Botelho Romão on 04/11/25.
//

import SwiftUI
import SwiftData

struct TodoListView: View {
    
    @EnvironmentObject var viewModel: TodoViewModel

    var body: some View {
        NavigationSplitView {
            List {
                ForEach(viewModel.items) { item in
                    HStack(spacing: 16) {
                        Image(systemName: item.isCompleted ? "checkmark.circle.fill" : "circle")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .onTapGesture {
                                viewModel.toggleCompletion(item: item)
                            }
                            .animation(.linear(duration: 0.2), value: item.isCompleted)
                        
                        Text(item.title)
                    }
                }
                .onDelete(perform: viewModel.deleteItem)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: viewModel.openCreateItemModal) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
        } detail: {
            Text("Select an item")
        }
        .sheet(isPresented: $viewModel.showingCreateModal, onDismiss: viewModel.dismissSheet) {
            CreateItemModalView()
                .presentationDetents([.fraction(0.4)])
        }
    }
}

#Preview {
    struct PreviewWrapper: View {
        var body: some View {
            let config = ModelConfiguration(isStoredInMemoryOnly: true)
            let container = try! ModelContainer(for: TodoItem.self, configurations: config)
            let viewModel = TodoViewModel(context: container.mainContext)

            return TodoListView()
                .modelContainer(container)
                .environmentObject(viewModel)
        }
    }

    return PreviewWrapper()
}
