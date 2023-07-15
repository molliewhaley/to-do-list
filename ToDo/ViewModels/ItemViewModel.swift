//
//  ItemViewModel.swift
//  ToDo
//
//  Created by Mollie Whaley on 6/24/23.
//

import Foundation
import CoreData

class ItemViewModel: ObservableObject {
    
    private let viewContext = CoreDataManager.shared.viewContext
    private var category: Category
    @Published var itemDict: [String: [Item]] = [:]
    
    init(category: Category) {
        self.category = category
        getItems()
    }
    
    func getItems() {
        itemDict = category.itemDict
    }
    
    func saveItem() {
        do {
            try viewContext.save()
        } catch {
            print("Error saving item")
        }
    }
    
    func addItem(name: String, date: Date) {
        let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@ AND category == %@", name, category)
        
        do {
            if !name.isEmpty { // no empty text
                let existingEntries = try viewContext.fetch(fetchRequest)
                if existingEntries.isEmpty { // no duplicates
                    let item = Item(context: viewContext)
                    item.id = UUID()
                    item.name = name
                    item.dueDate = date
                    item.isCompleted = false
                    category.addToItem(item)
                    
                    saveItem()
                    getItems()
                } else {
                    print("Duplicate entry found")
                }
            } else {
                print("Empty name")
            }
        } catch {
            print("Error fetching existing items")
        }
    }
    
    func changeCompletedStatus(for item: Item) {
        item.isCompleted.toggle()
        saveItem()
        getItems()
    }
    
    func saveChanges(for currentName: String, newName: String, newDate: Date) {
        let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", currentName)
        
        do {
            let fetchedItem = try viewContext.fetch(fetchRequest)
            for item in fetchedItem {
                item.name = newName
                item.dueDate = newDate
            }
            
            saveItem()
            getItems()
        } catch {
            print("Error changing category")
        }
    }
    
    func deleteItem(named item: Item) {
        category.removeFromItem(item)
        viewContext.delete(item)
        saveItem()
        getItems()
    }
    
    // functions for progress bar
    func countItems(for category: Category) -> Int {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = Item.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "category == %@", category)
        
        do {
            let count = try viewContext.count(for: fetchRequest)
            return count
        } catch {
            print("Error counting items")
            return 0
        }
    }
    
    func countCompletedItems(for category: Category) -> Int {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = Item.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "isCompleted == %@ AND category == %@", NSNumber(value: true), category)
        
        do {
            let count = try viewContext.count(for: fetchRequest)
            return count
        } catch {
            print("Error counting completed items")
            return 0
        }
    }
}

