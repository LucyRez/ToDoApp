//
//  OneTaskView.swift
//  ToDo
//
//  Created by Ludmila Rezunic on 28.02.2021.
//

import SwiftUI

struct TaskView : View{
    var name: String
    var note : String
    var status : String
    var date : Date
    
    init(name: String, note: String, status: String, date: Date) {
        self.name = name
        self.note = note
        self.status = status
        self.date = date
    }
    
    var body: some View{
        
        ZStack{
            RoundedRectangle(cornerRadius: 15).foregroundColor(.purple)
            VStack{
                Text(name)
                    .bold()
                    .padding(.top, 10)
                    .font(.system(size: 25))
                Spacer(minLength: 5)
                Text(date , style: .date)
                    .font(.system(size:14))
                Text("Status: \(status)")
                    .padding(.bottom, 10)
                    .font(.system(size:14))
                Spacer(minLength: 30)
                
            }
            
        }
        .fixedSize(horizontal: false, vertical: true)
        .padding()
        
    }
    
}


struct OneTaskView_Previews: PreviewProvider {
    static var previews: some View {
        TaskView(name: "New Task" , note: "Some note", status: "New",  date: Date())
    }
}

