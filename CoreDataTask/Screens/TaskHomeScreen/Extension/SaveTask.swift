//
//  ProtocolExtension.swift
//  CoreDataTask
//
//  Created by Tony Chen on 9/5/2023.
//

import Foundation

extension TaskHomeScreen: enterTaskDelegate {
    func saveTask(taskTitle: String) {
        let task = DataManager.shared.task(title: taskTitle)
        tasks.append(task)
        DataManager.shared.saveContext()
        tableView.reloadData()
    }
}
