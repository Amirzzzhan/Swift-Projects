//
//  SQLiteDatabase.swift
//  ToDo
//
//  Created by Amirzhan Armandiyev on 07.11.2022.
//

import Foundation
import SQLite

final class SQLiteDatabase {
    
    private var database: Connection!
    
    private let taskTable = Table("tasks")
    private let id = Expression<Int>("id")
    private let task = Expression<String>("task")
    private let address = Expression<String>("address")
    private let date = Expression<String>("date")
    
    private var tasksArray = [Task]()
    
    init() {
        do {
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileUrl = documentDirectory.appendingPathComponent("tasks").appendingPathExtension("sqlite3")
            let database = try Connection(fileUrl.path)
            self.database = database
        } catch {
            print(error)
        }
    }
    
    func isTableExists() -> Bool {
        do {
            let _ = try database.scalar(taskTable.count)
            return true
        } catch {
            return false
        }
    }
    
    func createTable() {
        if isTableExists() { return }
        
        let createTable = taskTable.create { table in
            table.column(id, primaryKey: true)
            table.column(task)
            table.column(address)
            table.column(date)
        }
        
        do {
            try database.run(createTable)
        } catch {
            print(error)
        }
    }
    
    func insertRow(newTask: Task) {
        let insertRow = taskTable.insert(id <- newTask.id, task <- newTask.task, address <- newTask.address, date <- newTask.date)
        
        do {
            try database.run(insertRow)
        } catch {
            print(error)
        }
    }
    
    func deleteRow(delTask: Task) {
        let deleteRow = taskTable.filter(delTask.id == self.id)
        
        do {
            try database.run(deleteRow.delete())
        } catch {
            print(error)
        }
    }
    
    func getTasksList() -> [Task] {
        tasksArray = [Task]()
        do {
            let tasks = try database.prepare(taskTable)
            for task in tasks {
                tasksArray.append(Task(id: task[id], task: task[self.task], address: task[address], date: task[date]))
            }
        } catch {
            print(error)
        }
        return tasksArray
    }
    
    func tasksCount() -> Int {
        return tasksArray.count
    }
}
