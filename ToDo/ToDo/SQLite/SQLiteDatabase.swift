//
//  SQLiteDatabase.swift
//  ToDo
//
//  Created by Amirzhan Armandiyev on 07.11.2022.
//

import Foundation
import SQLite

class SQLiteDatabase {
    static var sharedInstance = SQLiteDatabase()
    
    var database: Connection!
    
    let taskTable = Table("tasks")
    let id = Expression<Int>("id")
    let task = Expression<String>("task")
    let address = Expression<String>("address")
    let date = Expression<String>("date")
    
    var tasksArray = [Task]()
    
    private init() {
        do {
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileUrl = documentDirectory.appendingPathComponent("tasks").appendingPathExtension("sqlite3")
            let database = try Connection(fileUrl.path)
            self.database = database
        } catch {
            print(error)
        }
    }
    
    func createTable() {
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
            Task.idCounter += 1
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
    
    func tasksList() {
        tasksArray = [Task]()
        do {
            let tasks = try database.prepare(taskTable)
            for task in tasks {
                tasksArray.append(Task(id: task[id], task: task[self.task], address: task[address], date: task[date]))
            }
        } catch {
            print(error)
        }
    }
    
    func tasksCount() -> Int {
        return tasksArray.count
    }
}
