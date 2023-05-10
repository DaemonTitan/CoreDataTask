//
//  taskHomeScreen.swift
//  CoreDataTask
//
//  Created by Tony Chen on 9/5/2023.
//

import UIKit

var tasks = [Task]()

class TaskHomeScreen: UIViewController {
    
    // MARK: UI Element
    lazy var tableView: UITableView = {
        var tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "TaskCell")
        return tableView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        super.viewDidLoad()
        title = "My Tasks"
        navigationItem.backButtonTitle = ""
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        buttonActions()
        tasks = DataManager.shared.fetchTasks()
        tableView.reloadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func buttonActions() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(addTask))
    }
    
    @objc func addTask() {
        let rootEnterTaskScreen = EnterTaskScreen()
        rootEnterTaskScreen.delegate = self
        let enterTaskScreen = UINavigationController(rootViewController: rootEnterTaskScreen)
        //navigationController?.pushViewController(EnterTaskScreen, animated: true)
        present(enterTaskScreen, animated: true)
    }
}
