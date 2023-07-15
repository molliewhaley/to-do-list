//
//  Category+CoreDataProperties.swift
//  ToDo
//
//  Created by Mollie Whaley on 6/24/23.
//
//

import Foundation
import CoreData
import SwiftUI


extension Category {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Category> {
        return NSFetchRequest<Category>(entityName: "Category")
    }

    @NSManaged public var name: String?
    @NSManaged public var id: UUID?
    @NSManaged public var item: NSSet?
}

// MARK: Generated accessors for item
extension Category {

    @objc(addItemObject:)
    @NSManaged public func addToItem(_ value: Item)

    @objc(removeItemObject:)
    @NSManaged public func removeFromItem(_ value: Item)

    @objc(addItem:)
    @NSManaged public func addToItem(_ values: NSSet)

    @objc(removeItem:)
    @NSManaged public func removeFromItem(_ values: NSSet)

}

extension Category {
    
    public var unwrappedName: String {
        return name ?? ""
    }
    
    // create date sections in item view
    public var itemDict: [String: [Item]] {
        let convertedSet = Array(item as? Set<Item> ?? [])
        let groupedDict = Dictionary(grouping: convertedSet, by: {$0.convertedDate})
        
        var sortedDict: [String: [Item]] = [:]
        for (key, value) in groupedDict {
            let sortedItems = value.sorted { (item1, item2) in
                return !item1.isCompleted
            }
            sortedDict[key] = sortedItems
        }
        return sortedDict
    }
}

extension Category : Identifiable {

}
