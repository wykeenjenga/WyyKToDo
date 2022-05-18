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
    
    @AppStorage("isDarkMode") var isDarkMode: Bool = false

    var body: some Scene {
        
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .preferredColorScheme(isDarkMode ? .dark : .light)
        }
        
    }
}
