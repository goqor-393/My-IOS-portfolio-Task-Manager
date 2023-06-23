//
//  CategoryViewModel.swift
//  TaskManager
//
//  Created by Goqor Khechoyan on 15.06.23.
//
import Foundation
import CoreData
import SwiftUI

class CategoryViewModel: ObservableObject {
    private let controller : CoreData
    private let container : NSPersistentContainer
    
    @Published var categories = [Category]()
    
    init() {
        controller = CoreData.shared
        container = controller.container
        
        fetchCategories()
    }
    
    func fetchCategories() {
        let request: NSFetchRequest<Category> = Category.fetchRequest()
        
        do {
            let categories = try container.viewContext.fetch(request)
            self.categories = categories
        } catch {
            print("Failed to fetch categories: \(error)")
        }
        
        if categories.isEmpty {
            addCategory(title: "Uncategorized", r: 28/255, g: 135/255, b: 251/255, alpha: 1.0)
        }
    }
    func addCategory(title: String, r: Float, g: Float, b: Float, alpha: Float){
        let context = container.viewContext
        let newCategory = Category(context: context)
        
        newCategory.title = title
        newCategory.r = r
        newCategory.g = g
        newCategory.b = b
        newCategory.alpha = alpha
        
        
        saveContext()
        
        fetchCategories()
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
    
    func deleteCategory(category: Category) {
      
        
        container.viewContext.delete(category)
        
        saveContext()
        
        fetchCategories()
    }
}
