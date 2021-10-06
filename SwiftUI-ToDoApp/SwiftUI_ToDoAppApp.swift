//
//  SwiftUI_ToDoAppApp.swift
//  SwiftUI-ToDoApp
//
//  Created by Олег Еременко on 15.04.2021.
//

import SwiftUI

@main
struct SwiftUI_ToDoAppApp: App {
    let persistenceController = PersistenceController.shared
    var body: some Scene {
        WindowGroup {
            MainContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
