//
//  ListTaskView.swift
//  ToDo
//
//  Created by Ludmila Rezunic on 28.02.2021.
//

import Foundation
import SwiftUI
import CoreData

struct ListTaskView : View {
    
    @StateObject var task = TaskViewModel()
    @Environment(\.managedObjectContext) var context
    @FetchRequest (entity: Task.entity(), sortDescriptors: [NSSortDescriptor(key: "date", ascending: false)], animation: .spring()) var results : FetchedResults<Task>

    
    var body: some View{
        NavigationView{
            ScrollView{
                ForEach(results){ task in
                    TaskView(name: task.name, note: task.note, status: task.status, date: task.date)
                        .contextMenu(ContextMenu(menuItems: {
                            Button(action: {self.task.edit(task: task)}, label: {
                                Text("Edit")
                            })
                            Button(action: {
                                context.delete(task)
                                try! context.save()
                                
                            }, label: {
                                Text("Delete")
                            })
                        }))
                }
                
            }
            .navigationTitle(Text("Tasks"))
            .navigationBarItems(trailing:
                                    Button(action: {task.isNew.toggle()}){
                                        Image(systemName:"plus")
                                    }
                                    .sheet(isPresented: $task.isNew, content: {
                                        AddTaskView(task: task)
                                    }))
            
        }
        
    }
}

struct ListTaskView_Previews: PreviewProvider {
    static var previews: some View {
        ListTaskView()
        
    }
}

