//
//  EnterTaskScreen.swift
//  CoreDataTask
//
//  Created by Tony Chen on 9/5/2023.
//

import UIKit

protocol enterTaskDelegate {
    func saveTask(taskTitle: String)
}

class EnterTaskScreen: UIViewController, UITextFieldDelegate {
    
    var delegate: enterTaskDelegate?
    
    // MARK: UI element
    lazy var taskTitleTextField: UITextField = {
        var taskTitleTextField = UITextField()
        taskTitleTextField.placeholder = "Enter task name"
        taskTitleTextField.backgroundColor = .white
        //taskTitleTextField.borderStyle = UITextField.BorderStyle.roundedRect
        taskTitleTextField.layer.cornerRadius = 5.0
        taskTitleTextField.translatesAutoresizingMaskIntoConstraints = false
        return taskTitleTextField
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.largeTitleDisplayMode = .never
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(taskTitleTextField)
        title = "New Task"
        view.backgroundColor = .systemGray6
        taskTitleTextField.delegate = self
        taskTitleTextField.becomeFirstResponder()
        addPadding()
        fieldsLayout()
        navigationBarButton()
    }
    
    // Add padding to textField
    func addPadding() {
        // Create a UIView to use as padding: You can create a new UIView to use as padding at the beginning of the text field. The width of this view will determine the amount of space you want to create.
           let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
            
           // Set the leftView property of the text field: You can set the leftView property of the text field to the padding view you created in step 2. This will ensure that the padding view is displayed at the beginning of the text field.
        taskTitleTextField.leftView = paddingView
            
           // Set the leftViewMode property of the text field: You also need to set the leftViewMode property of the text field to .always. This will ensure that the padding view is always visible, even when there is no text in the text field.
        taskTitleTextField.leftViewMode = .always
    }
    
    private func fieldsLayout() {
        NSLayoutConstraint.activate([
            taskTitleTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            taskTitleTextField.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: -320),
            taskTitleTextField.heightAnchor.constraint(equalToConstant: 35),
            taskTitleTextField.widthAnchor.constraint(equalToConstant: 350)
        ])
    }
    
    private func navigationBarButton() {
        // Cancel Button
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel",
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(cancel))
        // Save Button
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(saveTask))
    }
    
    @objc func cancel() {
        dismiss(animated: true)
    }
    
    @objc func saveTask() {
        guard let titleText = taskTitleTextField.text, !titleText.isEmpty else {
            return
        }
        delegate?.saveTask(taskTitle: titleText)
        dismiss(animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        saveTask()
        return true
    }
}
