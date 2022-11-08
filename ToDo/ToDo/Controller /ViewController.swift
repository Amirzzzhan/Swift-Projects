//
//  ViewController.swift
//  ToDo
//
//  Created by Amirzhan Armandiyev on 05.11.2022.
//

import UIKit

class ViewController: UIViewController {
    
    private var tableView: UITableView?
    
    private let db = SQLiteDatabase.sharedInstance
    
    override func viewWillAppear(_ animated: Bool) {
        db.tasksList()
        Task.idCounter = db.tasksArray.last?.id ?? -1
        Task.idCounter += 1
        tableView?.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        db.createTable()
        setupNavigationBar()
        setupTableView()
    }
    
    // MARK: - TableViewSetup
    private func setupTableView() {
        tableView = UITableView(frame: view.frame, style: .plain)
        tableView?.separatorInset.left = 0
        
        guard let safeTableView = tableView else {
            return
        }
        
        view.addSubview(safeTableView)
        
        safeTableView.register(TaskTableViewCell.self, forCellReuseIdentifier: TaskTableViewCell.identifier)
        safeTableView.dataSource = self
        safeTableView.delegate = self
    }
    
    // MARK: - NavigationBarSetup
    private func setupNavigationBar() {
        let addTaskButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addPressed))
        navigationItem.rightBarButtonItem = addTaskButton
    }
    
    // MARK: - Add a new task
    @objc func addPressed() {
        let taskVC = TaskViewController()
        navigationController?.pushViewController(taskVC, animated: true)
    }
    
    // MARK: - Delete table view cell after swipe action
    func handleMoveToTrash(task: Task) {
        db.deleteRow(delTask: task)
        db.tasksList()
        tableView?.reloadData()
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return db.tasksCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TaskTableViewCell.identifier, for: indexPath) as! TaskTableViewCell
        
        cell.taskLabel.text = db.tasksArray[indexPath.row].task
        cell.addressLabel.text = db.tasksArray[indexPath.row].address
        cell.dateLabel.text = db.tasksArray[indexPath.row].date
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete") {
            [weak self] (action, view, completionHandler) in
            self?.handleMoveToTrash(task: (self?.db.tasksArray[indexPath.row])!)
            completionHandler(true)
        }
        delete.backgroundColor = .systemRed
        
        let configuration = UISwipeActionsConfiguration(actions: [delete])
        
        return configuration
    }
}

