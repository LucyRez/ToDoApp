//
//  AddTaskView.swift
//  ToDo
//
//  Created by Ludmila Rezunic on 02.03.2021.
//

import Foundation
import SwiftUI

struct AddTaskView: View{
    @ObservedObject var task : TaskViewModel
    @State var statusSelected = Status.new
    @Environment(\.managedObjectContext) var context
    
    let statusArray = ["New", "In Process", "Completed"]
    
    init(task:TaskViewModel){
        UITextView.appearance().backgroundColor = .clear
        self.task = task
    }
    var body: some View{
        
        VStack{
            Text("\(task.edited != nil ? "Update" : "Create New") Task")
                .fontWeight(.heavy)
                .foregroundColor(.black)
            
            TextField("Enter the title", text: $task.name)
                .padding()
            
            TextEditor(text:$task.note )
                .background(Color.gray)
                .opacity(0.4)
            
            Picker("Current status:",selection: $statusSelected){
                Text("New").tag(Status.new)
                Text("In Progress").tag(Status.inProcess)
                Text("Completed").tag(Status.completed)
            }
            
            //Spacer(minLength: 160)
            
            Button(action: {
                task.status = statusSelected.rawValue
                task.writeData(context: context)
                
            }){
                Text(task.edited == nil ? "Add Task" : "Edit Task")
                    .bold()
                    .foregroundColor(.white)
            }.padding()
            .disabled(task.name == "" ? true : false)
            .background(Color.purple)
            .clipShape(RoundedRectangle(cornerRadius: 25))
            .opacity(task.name == "" ? 0.5 : 1)
            
            
        }
        .padding()
        .onDisappear(perform: {task.edited = nil
            task.note = ""
            task.name = ""
        })
        
    }
}

struct AddTaskView_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskView(task: TaskViewModel())
        
    }
    
}
