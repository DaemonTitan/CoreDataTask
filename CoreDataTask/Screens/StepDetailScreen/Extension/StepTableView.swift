//
//  StepTableView.swift
//  CoreDataTask
//
//  Created by Tony Chen on 9/5/2023.
//

import Foundation
import UIKit

extension StepDetailScreen: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension StepDetailScreen: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return steps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StepCell", for: indexPath)
        let step = steps[indexPath.row]
        cell.textLabel?.text = step.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        // Create swip action
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (action, view, completionHandler) in
            // Step to remove
            let stepToRemove = steps[indexPath.row]
            // Remove step
            DataManager.shared.deleteStep(step: stepToRemove)
            // Remove step row
            steps.remove(at: indexPath.row)
            // Deselect row
            tableView.deselectRow(at: indexPath, animated: true)
            // Reload data
            tableView.reloadData()
            completionHandler(true)
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}
