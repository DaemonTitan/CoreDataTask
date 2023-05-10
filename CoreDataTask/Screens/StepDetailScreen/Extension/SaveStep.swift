//
//  Protocol.swift
//  CoreDataTask
//
//  Created by Tony Chen on 10/5/2023.
//

import Foundation
import UIKit

extension StepDetailScreen: EnterStepDelegate {
    
    func saveStep(stepTitle: String) {
        guard let taskTemp = task else {
            return
        }
        
        let step = DataManager.shared.step(name: stepTitle, stepNum: 0, task: taskTemp )
        steps.append(step)
        DataManager.shared.saveContext()
        tableView.reloadData()
    }
}
