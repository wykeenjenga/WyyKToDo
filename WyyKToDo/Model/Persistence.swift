//
//  Persistence.swift
//  WyyKToDo
//
//  Created by Wykee Njenga on 5/2/22.
//

import CoreData

struct PersistenceController {
    
    //MARK: - properties
    //controller
    static let shared = PersistenceController()
    //container
    let container: NSPersistentCloudKitContainer

    //MARK: - Initialization
    init(inMemory: Bool = false) {
        container = NSPersistentCloudKitContainer(name: "WyyKToDo")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    
    //MARK: - preview
    static var preview: PersistenceController = {
        
        let result = PersistenceController(inMemory: true)
        
        let viewContext = result.container.viewContext
        for i in 0..<5 {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()
            newItem.task = "Sample task No\(i)"
            newItem.completion = true
            newItem.id = UUID()
        }
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()
}
