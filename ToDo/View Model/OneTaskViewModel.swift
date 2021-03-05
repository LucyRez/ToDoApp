//
//  OneTaskViewModel.swift
//  ToDo
//
//  Created by Ludmila Rezunic on 02.03.2021.
//

import Foundation
import CoreData

/**
 Модель задачи.
 
 # Notes: #
 Модель задачи содержит:
 1. Заголовок - name
 2. Дата создания - date
 3. Заметка к задаче - note
 4. Статус выполнения задачи - status
 
 */
class TaskViewModel: ObservableObject{
    
    @Published var name : String = ""
    @Published var date : Date = Date()
    @Published var note : String = ""
    @Published var status : String = "";
    @Published var isNew : Bool = false
    @Published var task:Task!
    @Published var edited:Task!
    
    
    func writeData(context: NSManagedObjectContext){
        
        if edited != nil {
            edited.date = date
            edited.note = note
            edited.name = name
            edited.status = status
            
            try! context.save()
            
            edited = nil
            isNew.toggle()
            date = Date()
            status = ""
            note = ""
            name = ""
            return
        }
        
        let newTask = Task(context: context)
        newTask.name = name
        newTask.note = note
        newTask.date = date
        newTask.status = status
        
        do{
            try context.save()
            
            isNew.toggle()
            date = Date()
            status = ""
            note = ""
            name = ""
        }
        catch{
            print(error.localizedDescription)
        }
    }
    
    func edit(task: Task){
        edited = task
        self.name = task.name
        self.note = task.note
        self.status = task.status
        self.date = task.date
        
        isNew.toggle()
        
    }
}
