//
//  CategoryViewModel.swift
//  ToDo
//
//  Created by Mollie Whaley on 6/24/23.
//

import Foundation
import CoreData

class CategoryViewModel: ObservableObject {
    private let viewContext = CoreDataManager.shared.viewContext
    @Published var categoriesArray: [Category] = []
    
    init() {
        getCategories()
    }
    
    func getCategories() {
        let request = NSFetchRequest<Category>(entityName: "Category")
        
        do {
            categoriesArray = try viewContext.fetch(request)
        } catch {
            print("Couldn't load categories")
        }
    }
    
    func saveCategory() {
        do {
            try viewContext.save()
        } catch {
            print("Error saving category")
        }
    }
    
    func addCategory(name: String) {
        let fetchRequest: NSFetchRequest<Category> = Category.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)
        
        if !name.isEmpty { // no empty text 
            do {
                let existingEntries = try viewContext.fetch(fetchRequest)
                if existingEntries.isEmpty { // no duplicates 
                    let category = Category(context: viewContext)
                    category.id = UUID()
                    category.name = name
                    
                    saveCategory()
                    getCategories()
                } else {
                    print("Duplicate entry found")
                }
            } catch {
                print("Error fetching existing items")
            }
        } else {
            print("Empty name")
        }
    }
    
    func saveChanges(for currentName: String, newName: String) {
        let fetchRequest: NSFetchRequest<Category> = Category.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", currentName)
        
        if !newName.isEmpty {
            do {
                let fetchedCategory = try viewContext.fetch(fetchRequest)
                for category in fetchedCategory {
                    category.name = newName
                }
                saveCategory()
                getCategories()
            } catch {
                print("Error fetching")
            }
        } else {
            print("Empty name")
        }
    }
    
    func deleteCategory(named category: Category) {
        viewContext.delete(category)
        saveCategory()
        getCategories()
    }
    
}
