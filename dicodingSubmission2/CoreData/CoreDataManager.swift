//
//  CoreDataManagement.swift
//  dicodingSubmission2
//
//  Created by Maitri Vira on 08/09/21.
//

import Foundation
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    let container: NSPersistentContainer
    let context: NSManagedObjectContext
    init() {
        container = NSPersistentContainer(name: "Game")
        container.loadPersistentStores { (_, error) in
            if let error = error as NSError? {
                fatalError("error coredatamanager \(error)")
            }
        }
        context = container.viewContext
    }
    func save(completion: @escaping (Error?) -> Void = {_ in}) {
        let context = container.viewContext
        do {
            try context.save()
            completion(nil)
        } catch let error {
            completion(error)
            print("Error \(error.localizedDescription)")
        }
    }
    func delete(_ object: NSManagedObject, completion: @escaping (Error?) -> Void = {_ in}) {
        let context = container.viewContext
        context.delete(object)
        save(completion: completion)
    }
}
