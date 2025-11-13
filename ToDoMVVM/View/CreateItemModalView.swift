//
//  CreateItemModalView.swift
//  ToDoMVVM
//
//  Created by Enzo Henrique Botelho Romão on 04/11/25.
//

import SwiftUI
import SwiftData

struct CreateItemModalView: View {
    
    @EnvironmentObject var viewModel: TodoViewModel
    
    var body: some View {
        VStack(spacing: 40) {
            Text("Adicionar Tarefa")
                .font(.headline)
            
            VStack(spacing: 32) {
                TextField(text: $viewModel.itemTitle) {
                    Text("Digite o título da tarefa")
                }
                .frame(width: 240, height: 60)
                .padding(.horizontal)
                .background(.gray.opacity(0.2))
                .cornerRadius(12)
                
                Button("Salvar") {
                    viewModel.addItem()
                }
                .buttonStyle(.borderedProminent)
                .disabled(viewModel.itemTitle.isEmpty)
                .animation(.linear(duration: 0.2), value: viewModel.itemTitle)
            }
            
            Spacer()
        }
        .padding(24)
        .padding(.top, 16)
    }
}

#Preview {
    struct PreviewWrapper: View {
        var body: some View {
            let config = ModelConfiguration(isStoredInMemoryOnly: true)
            let container = try! ModelContainer(for: TodoItem.self, configurations: config)
            let viewModel = TodoViewModel(context: container.mainContext)

            return CreateItemModalView()
                .modelContainer(container)
                .environmentObject(viewModel)
        }
    }

    return PreviewWrapper()
}
