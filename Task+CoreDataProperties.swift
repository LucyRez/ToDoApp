//
//  Task+CoreDataProperties.swift
//  ToDo
//
//  Created by Ludmila Rezunic on 04.03.2021.
//
//

import Foundation
import CoreData


/**
 Enum описывающий возможные статусы задачи
 
 # Notes: #
 Варианты статуса:
 1. Новая задача - new
 2. В процессе - inProcess
 3. Завершена - completed
 
 */
enum Status:String{
    case new = "New"
    case inProcess = "In Process"
    case completed = "Completed"
}

extension Task {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }
    
    @NSManaged public var date: Date
    @NSManaged public var name: String
    @NSManaged public var note: String
    @NSManaged public var status: String
    
    var taskStatus:Status{
        set{
            status = newValue.rawValue
        }
        get{    
            Status(rawValue: status) ?? .new
        }
    }
    
}

extension Task : Identifiable {
    
}
