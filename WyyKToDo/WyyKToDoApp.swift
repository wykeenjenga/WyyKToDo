//
//  WyyKToDoApp.swift
//  WyyKToDo
//
//  Created by Wykee Njenga on 5/2/22.
//

import SwiftUI

@main
struct WyyKToDoApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
