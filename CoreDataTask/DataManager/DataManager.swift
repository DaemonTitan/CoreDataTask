//
//  DataManager.swift
//  CoreDataTask
//
//  Created by Tony Chen on 9/5/2023.
//

import Foundation
import CoreData

class DataManager {
    static let shared = DataManager()
    
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "CoreDataTask")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func task(title: String) -> Task {
        let task = Task(context: persistentContainer.viewContext)
        task.title = title
        task.createDate = Date()
        return task
    }
    
    func step(name: String, stepNum: Int16, task: Task) -> Step {
        let step = Step(context: persistentContainer.viewContext)
        step.name = name
        step.stepNum = stepNum
        task.addToSteps(step)
        return step
    }
    
    func fetchTasks() -> [Task] {
        let request: NSFetchRequest<Task> = Task.fetchRequest()
        var fetchedTasks: [Task] = []
        
        do {
            fetchedTasks = try persistentContainer.viewContext.fetch(request)
        } catch {
            print(error.localizedDescription)
        }
        return fetchedTasks
    }
    
    func fetchSteps(task: Task) -> [Step] {
        let request: NSFetchRequest<Step> = Step.fetchRequest()
        // Filter out Steps base on task
        request.predicate = NSPredicate(format: "task = %@", task)
        // Sort list
        //request.sortDescriptors = [NSSortDescriptor(key: "id", ascending: false)]
        var fetchedSteps: [Step] = []
        
        do {
            fetchedSteps = try persistentContainer.viewContext.fetch(request)
        } catch {
            print(error.localizedDescription)
        }
        return fetchedSteps
    }
    
    func deleteTask(task: Task) {
        let context = persistentContainer.viewContext
        context.delete(task)
        saveContext()
    }
    
    func deleteStep(step: Step) {
        let context = persistentContainer.viewContext
        context.delete(step)
        saveContext()
    }
    
}
