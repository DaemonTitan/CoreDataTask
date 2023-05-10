//
//  TaskTableView.swift
//  CoreDataTask
//
//  Created by Tony Chen on 9/5/2023.
//

import Foundation
import UIKit

extension TaskHomeScreen: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let rootStepDetailsScreen = StepDetailScreen()
        // put task data to task array in Step detail scren
        let taskList = tasks[indexPath.row]
        rootStepDetailsScreen.task = taskList
        
        tableView.deselectRow(at: indexPath, animated: true)
        let StepDetailScreen = UINavigationController(rootViewController: rootStepDetailsScreen)
        present(StepDetailScreen, animated: true)
    }
}

extension TaskHomeScreen: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath)
        let task = tasks[indexPath.row]
        cell.textLabel?.text = task.title
        return cell
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        // Create swip action
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (action, view, completionHandler) in
            // Select Task to remove
            let taskToRemove = tasks[indexPath.row]
            // Delect select task
            DataManager.shared.deleteTask(task: taskToRemove)
            // Delect task table row
            tasks.remove(at: indexPath.row)
            // Deselect row
            tableView.deselectRow(at: indexPath, animated: true)
            tableView.reloadData()
            completionHandler(true)
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    
}
