//
//  ToDoApp.swift
//  ToDo
//
//  Created by Mollie Whaley on 6/24/23.
//

import SwiftUI

@main
struct CoreToDoAppApp: App {
    let persistenceController = CoreDataManager.shared

    init() { // for constraints on date picker
        UserDefaults.standard.set(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
    }
    
    var body: some Scene {
        WindowGroup {
            CategoryView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
