//
//  TaskViewController.swift
//  ToDo
//
//  Created by Amirzhan Armandiyev on 06.11.2022.
//

import UIKit

class TaskViewController: UIViewController {
    
    var taskText: UITextField!
    var addressText: UITextField!
    var descriptionText: UITextField!
    var datePickerView: UIDatePicker!
    var saveButton: UIButton!
    var cancelButton: UIButton!
    
    private let db = SQLiteDatabase.sharedInstance

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
        view.backgroundColor = .white
        navigationItem.hidesBackButton = true
        
        taskText = UITextField()
        taskText.translatesAutoresizingMaskIntoConstraints = false
        taskText.placeholder = "Task"
        taskText.borderStyle = .roundedRect
        view.addSubview(taskText)
        
        addressText = UITextField()
        addressText.translatesAutoresizingMaskIntoConstraints = false
        addressText.placeholder = "Address"
        addressText.borderStyle = .roundedRect
        view.addSubview(addressText)
        
        descriptionText = UITextField()
        descriptionText.translatesAutoresizingMaskIntoConstraints = false
        descriptionText.placeholder = "Description"
        descriptionText.borderStyle = .roundedRect
        view.addSubview(descriptionText)
        
        datePickerView = UIDatePicker()
        datePickerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(datePickerView)
        
        saveButton = UIButton(type: .system)
        saveButton.translatesAutoresizingMaskIntoConstraints = false 
        saveButton.setTitle("Save", for: .normal)
        saveButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        saveButton.addTarget(self, action: #selector(savePressed), for: .touchUpInside)
        view.addSubview(saveButton)
        
        cancelButton = UIButton(type: .system)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.setTitleColor(.red, for: .normal)
        cancelButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        cancelButton.addTarget(self, action: #selector(cancelPressed), for: .touchUpInside)
        view.addSubview(cancelButton)
        
        // MARK: - Setting layout constraints programmatically
        NSLayoutConstraint.activate([taskText.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     taskText.centerYAnchor.constraint(equalTo: view.topAnchor, constant: 150),
                                     taskText.widthAnchor.constraint(equalToConstant: 300),
                                     
                                     addressText.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     addressText.centerYAnchor.constraint(equalTo: taskText.bottomAnchor, constant: 30),
                                     addressText.widthAnchor.constraint(equalToConstant: 300),
                                     
                                     descriptionText.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     descriptionText.centerYAnchor.constraint(equalTo: addressText.bottomAnchor, constant: 30),
                                     descriptionText.widthAnchor.constraint(equalToConstant: 300),
                                     
                                     datePickerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     datePickerView.topAnchor.constraint(equalTo: descriptionText.bottomAnchor, constant: 30),
                        
                                     saveButton.topAnchor.constraint(equalTo: datePickerView.bottomAnchor, constant: 30),
                                     saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 100),
                                     saveButton.heightAnchor.constraint(equalToConstant: 44),
                                     
                                     cancelButton.topAnchor.constraint(equalTo: datePickerView.bottomAnchor, constant: 30),
                                     cancelButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -100),
                                     cancelButton.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        
        taskText.delegate = self
    }
    // MARK: - Save button pressed
    @objc func savePressed() {
        guard let task = taskText.text else {
            return
        }
        guard let address = addressText.text else {
            return
        }
        
        if task.isEmpty || address.isEmpty {
            return
        }
        
        db.insertRow(newTask: Task(id: Task.idCounter, task: task, address: address, date: datePickerView.date.formatted()))
        navigationController?.popViewController(animated: true)
    }
    // MARK: - Cancel button pressed
    @objc func cancelPressed() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - UITextFieldDelegate
extension TaskViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
    }
}
