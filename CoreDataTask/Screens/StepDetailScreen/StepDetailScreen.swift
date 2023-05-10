//
//  TaskDetailScreen.swift
//  CoreDataTask
//
//  Created by Tony Chen on 9/5/2023.
//

import Foundation
import UIKit

var steps = [Step]()

class StepDetailScreen: UIViewController {
    
    var task: Task?
    
    lazy var tableView: UITableView = {
        var tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "StepCell")
        return tableView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.largeTitleDisplayMode = .never
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        title = "Steps"
        
        tableView.delegate = self
        tableView.dataSource = self
        buttonActions()
        view.backgroundColor = .white
        
        if let task = task {
            steps = DataManager.shared.fetchSteps(task: task)
        }
        
        tableView.reloadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func buttonActions() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(cancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(addStep))
    }
    
    @objc func cancel() {
        dismiss(animated: true)
    }
    
    @objc func addStep() {
        let enterStepScreen = EnterStepScreen()
        enterStepScreen.delegate = self
        navigationController?.pushViewController(enterStepScreen, animated: true)
    }
    

}
