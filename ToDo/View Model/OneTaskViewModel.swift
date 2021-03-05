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
    
    /**
      Функция для записи данных в базу
     
     - parameter context: Текущий контекст.
     */
    func writeData(context: NSManagedObjectContext){
        
        // Если редактируем, а не создаём новую задачу.
        if edited != nil {
            // Редактируемая задача получает значения полей модели
            edited.date = date
            edited.note = note
            edited.name = name
            edited.status = status
            
            try! context.save() // Пытаемся сохранить контекст.
            
            // Присваиваем назад дефолтные значения
            edited = nil
            isNew.toggle()
            date = Date()
            status = ""
            note = ""
            name = ""
            return
        }
        
        // Если создаётся новая задача, получаем все данные из контекста
        let newTask = Task(context: context)
        newTask.name = name
        newTask.note = note
        newTask.date = date
        newTask.status = status
        
        do{
            try context.save()
            
            // После попытки сохраниться возвращаем дефолтные значения
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
    
    /**
     Функция инициализирует редактирование задачи.
     
     - parameter task: Редактируемая задача.
     */
    func edit(task: Task){
        edited = task
        self.name = task.name
        self.note = task.note
        self.status = task.status
        self.date = task.date
        
        isNew.toggle()
        
    }
}
