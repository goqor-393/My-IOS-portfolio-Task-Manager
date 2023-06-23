//
//  TaskListViewModel.swift
//  TaskManager
//
//  Created by Goqor Khechoyan on 12.06.23.
//

import Foundation
import CoreData

class TaskViewModel: ObservableObject{
    private let controller : CoreData
    private let container : NSPersistentContainer
    
    @Published var tasks = [Task]()
    
    init(){
        controller = CoreData.shared
        container = controller.container
        
        fetchTasks()
    }
    
    func fetchTasks() {
        let request: NSFetchRequest<Task> = Task.fetchRequest()
        
        let sortByDate = NSSortDescriptor(key: "endDate", ascending: true)
        request.sortDescriptors = [sortByDate]
        
        do {
            let tasks = try container.viewContext.fetch(request)
            self.tasks = tasks
        } catch {
            print("Failed to fetch tasks: \(error)")
        }
    }
    
    func addTask(title: String, desc: String, startDate: Date, endDate: Date, subTasks: [String], complitedSubTasks: [Bool], category: Category) -> Task {
        
        let context = container.viewContext
        let newTask = Task(context: context)
        
        newTask.status = false
        
        newTask.category = category
        
        newTask.title = title
        newTask.desc = desc
        
        newTask.startDate = startDate
        newTask.endDate = endDate
        
        newTask.subTasks = subTasks
        
        newTask.complitedSubTasks = complitedSubTasks
        
        saveContext()
        
        fetchTasks()
        
        return newTask
    }
    
    func saveContext() {
        if container.viewContext.hasChanges {
            do {
                try container.viewContext.save()
            } catch {
                print("Failed to save changes: \(error)")
            }
        }
    }
    
    
    func deleteTask(indexSet: IndexSet) {

        guard let index = indexSet.first else {return}
        let task = tasks[index]
        container.viewContext.delete(task)

        saveContext()
        fetchTasks()
    }
    
    func deleteTaskByCategory(category: Category) {

        tasks.forEach { task in
            if task.category == category {
                container.viewContext.delete(task)
            }
        }

        saveContext()
        fetchTasks()
    }
    
    func dateToString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        
        return formatter.string(from: date)
    }
    
    func completedTasksCounter() -> Int{
        var count = 0
        for task in tasks{
            if task.status {
                count += 1
            }
        }
        
        return count
    }
    
    func completedSubTasksinTaskCounter(completedSubTasks: [Bool]) -> Int{
        var count = 0
        for subtask in completedSubTasks{
            if subtask {
                count += 1
            }
        }
        
        return count
    }
}
