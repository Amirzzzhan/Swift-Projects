//
//  ViewController.swift
//  ToDo
//
//  Created by Amirzhan Armandiyev on 05.11.2022.
//

import UIKit

final class ViewController: UIViewController {
    
    private var tableView: UITableView?
    
    private let db: SQLiteDatabase
    
    private var dataSource = [Task]()
    
    init(database: SQLiteDatabase) {
        self.db = database
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        
        dataSource = db.getTasksList()
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
        
        safeTableView.register(TaskTableViewCell.self, forCellReuseIdentifier: TaskTableViewCell.className)
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
        let taskVC = TaskViewController(database: db)
        navigationController?.pushViewController(taskVC, animated: true)
    }
    
    // MARK: - Delete table view cell after swipe action
    func handleMoveToTrash(task: Task) {
        db.deleteRow(delTask: task)
        dataSource = db.getTasksList()
        tableView?.reloadData()
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return db.tasksCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TaskTableViewCell.className, for: indexPath) as! TaskTableViewCell
        
        cell.taskLabel.text = dataSource[indexPath.row].task
        cell.addressLabel.text = dataSource[indexPath.row].address
        cell.dateLabel.text = dataSource[indexPath.row].date
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete") {
            [weak self] (action, view, completionHandler) in
            self?.handleMoveToTrash(task: (self?.dataSource[indexPath.row])!)
            completionHandler(true)
        }
        delete.backgroundColor = .systemRed
        
        let configuration = UISwipeActionsConfiguration(actions: [delete])
        
        return configuration
    }
}

