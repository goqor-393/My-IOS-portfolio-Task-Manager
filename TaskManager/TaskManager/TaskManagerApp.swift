//
//  TaskManagerApp.swift
//  TaskManager
//
//  Created by Goqor Khechoyan on 23.06.23.
//

import SwiftUI

@main
struct TaskManagerApp: App {
    let persistenceController = CoreData.shared

    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
