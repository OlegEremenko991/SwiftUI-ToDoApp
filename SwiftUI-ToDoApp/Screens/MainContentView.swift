//
//  MainContentView.swift
//  SwiftUI-ToDoApp
//
//  Created by Олег Еременко on 15.04.2021.
//

import SwiftUI
import CoreData

struct MainContentView: View {

    @Environment(\.managedObjectContext)
    private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.completed, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>

    @State private var isShowingAddItemView = false

    init() {
        UITableView.appearance().backgroundColor = UIColor.systemBackground
    }

    var body: some View {
        NavigationView {
            ZStack {
                List {
                    ForEach(items) { item in
                        ItemListCell(completed: item.completed,
                                     title: item.title!,
                                     timeStamp: itemFormatter.string(from: item.timestamp!))
                            .onTapGesture {
                                changeItemState(item: item)
                            }
                    }
                    .onDelete(perform: deleteItem)
                    .listRowBackground(Color(UIColor.systemBackground))
                }
                .navigationTitle("ToDo list")
                .navigationBarItems(
                    leading: Button {
                        removeAllItems()
                    } label: {
                        Label("Remove all", systemImage: "trash")
                            .foregroundColor(Color(.systemRed))
                    },
                    trailing: Button {
                        isShowingAddItemView = true
                    } label: {
                        Label("Add a task", systemImage: "plus")
                            .foregroundColor(Color(.label))
                    }
                )
                .sheet(isPresented: $isShowingAddItemView) {
                    AddNewItemView(isShowingSheet: $isShowingAddItemView)
                }
                if items.isEmpty {
                    VStack {
                        Image(systemName: "tray")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100, height: 100)
                        Text("Your task list is empty")
                            .fontWeight(.semibold)
                            .font(.title)
                            .multilineTextAlignment(.center)
                    }
                }
            }
        }
    }

    private func changeItemState(item: Item) {
        withAnimation {
            item.completed.toggle()

            do {
                try viewContext.save()
                print("saved item status, title: \(item.title!)")
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func removeAllItems() {
        withAnimation {
            items.forEach { viewContext.delete($0) }

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItem(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
