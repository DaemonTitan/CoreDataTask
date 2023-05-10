//
//  EnterStepScreen.swift
//  CoreDataTask
//
//  Created by Tony Chen on 9/5/2023.
//

import Foundation
import UIKit

protocol EnterStepDelegate {
    func saveStep(stepTitle: String)
}

class EnterStepScreen: UIViewController, UITextFieldDelegate {
    
    var delegate: EnterStepDelegate?
    
    lazy var stepTitleTextField: UITextField = {
        var stepTitleTextField = UITextField()
        stepTitleTextField.placeholder = "Enter text"
        stepTitleTextField.backgroundColor = .white
        stepTitleTextField.layer.cornerRadius = 5.0
        stepTitleTextField.translatesAutoresizingMaskIntoConstraints = false
        return stepTitleTextField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(stepTitleTextField)
        title = "New Step"
        view.backgroundColor = .systemGray6
        stepTitleTextField.delegate = self
        stepTitleTextField.becomeFirstResponder()
        fieldsLayout()
        navigationBarButton()
    }
    
    private func fieldsLayout() {
        NSLayoutConstraint.activate([
            stepTitleTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stepTitleTextField.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: -320),
            stepTitleTextField.heightAnchor.constraint(equalToConstant: 30),
            stepTitleTextField.widthAnchor.constraint(equalToConstant: 350)
        ])
    }
    
    private func navigationBarButton() {
        // Cancel Button
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel",
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(goBack))
        // Save Button
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(saveStep))
    }
    
    @objc func goBack() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func saveStep() {
        guard let stepText = stepTitleTextField.text, !stepText.isEmpty else {
            return
        }
        delegate?.saveStep(stepTitle: stepText)
        navigationController?.popViewController(animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        saveStep()
        return true
    }
}
