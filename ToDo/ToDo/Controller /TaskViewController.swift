//
//  TaskViewController.swift
//  ToDo
//
//  Created by Amirzhan Armandiyev on 06.11.2022.
//

import UIKit

final class TaskViewController: UIViewController {
    
    private let db: SQLiteDatabase
    
    var taskText: UITextField = {
        let textField = UITextField()
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Task"
        textField.borderStyle = .roundedRect
        
        return textField
    }()
    
    var addressText: UITextField = {
        let textField = UITextField()
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Address"
        textField.borderStyle = .roundedRect
        
        return textField
    }()
    
    var descriptionText: UITextField = {
        let textField = UITextField()
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Description"
        textField.borderStyle = .roundedRect
        
        return textField
    }()
    
    var datePickerView: UIDatePicker = {
        let datePickerView = UIDatePicker()
        
        datePickerView.translatesAutoresizingMaskIntoConstraints = false
        
        return datePickerView
    }()
    
    var saveButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Save", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        
        return button
    }()
    
    var cancelButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        
        return button
    }()
    
    init(database: SQLiteDatabase) {
        db = database
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
        view.backgroundColor = .white
        navigationItem.hidesBackButton = true
      
        addSubviews()
        configureConstraints()
        
        taskText.delegate = self
        
        saveButton.addTarget(self, action: #selector(savePressed), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(cancelPressed), for: .touchUpInside)
    }
    
    // MARK: - Adding all subviews
    private func addSubviews() {
        view.addSubview(taskText)
        view.addSubview(addressText)
        view.addSubview(descriptionText)
        view.addSubview(datePickerView)
        view.addSubview(saveButton)
        view.addSubview(cancelButton)
    }
    
    // MARK: - Setting layout constraints programmatically
    private func configureConstraints() {
        NSLayoutConstraint.activate(
            [taskText.centerXAnchor.constraint(equalTo: view.centerXAnchor),
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
            ]
        )
    }
    
    // MARK: - Save button pressed
    @objc private func savePressed() {
        guard let task = taskText.text else {
            return
        }
        guard let address = addressText.text else {
            return
        }
        
        if task.isEmpty || address.isEmpty {
            return
        }
        
        db.insertRow(newTask: Task(id: db.tasksCount(), task: task, address: address, date: datePickerView.date.formatted()))
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Cancel button pressed
    @objc private func cancelPressed() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - UITextFieldDelegate
extension TaskViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
    }
}
