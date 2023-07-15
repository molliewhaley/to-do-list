//
//  Item+CoreDataProperties.swift
//  ToDo
//
//  Created by Mollie Whaley on 6/24/23.
//
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var name: String?
    @NSManaged public var isCompleted: Bool
    @NSManaged public var id: UUID?
    @NSManaged public var category: Category?
    @NSManaged public var dueDate: Date?
}

extension Item {
    var unwrappedName: String {
        return name ?? ""
    }

    var convertedDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yy"
        if let date = dueDate {
            let formattedDate = dateFormatter.string(from: date)
            return formattedDate
        }
        return ""
    }
}

extension Item : Identifiable {

}
