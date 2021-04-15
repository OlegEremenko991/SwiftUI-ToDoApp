//
//  AddNewItemView.swift
//  SwiftUI-ToDoApp
//
//  Created by Олег Еременко on 15.04.2021.
//

import SwiftUI

struct AddNewItemView: View {
    @Environment(\.managedObjectContext)
    private var viewContext

    @Binding var isShowingSheet: Bool
    @State private var itemTitle = ""

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Task title", text: $itemTitle)
                    Button {
                        saveItem()
                    } label: {
                        Text("Save")
                            .foregroundColor(itemTitle.isEmpty ?
                                                Color(.systemGray) :
                                                Color(.systemGreen))
                    }
                }
            }
            .navigationTitle("Add a task")
            .navigationBarItems(trailing: Button(action: {
                isShowingSheet = false
            }, label: {
                Image(systemName: "xmark")
                    .foregroundColor(Color(.label))
                    .imageScale(.large)
                    .frame(width: 50, height: 50)
            }))
        }
    }

    private func saveItem() {
        guard !itemTitle.isEmpty else { return }
        let newItem = Item(context: viewContext)
        newItem.title = itemTitle
        newItem.timestamp = Date()
        do {
            try viewContext.save()
            isShowingSheet = false
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}

struct AddNewItemView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewItemView(isShowingSheet: .constant(false))
    }
}
