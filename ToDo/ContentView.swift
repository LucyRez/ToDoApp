//
//  ContentView.swift
//  ToDo
//
//  Created by Ludmila Rezunic on 28.02.2021.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State var filterString:String = ""
    var body: some View {
        VStack{
            HStack{
                Button(action: {filterString = ""}, label: {
                    Text("All")
                })
                .padding()
                .background(Color(.systemTeal))
                .opacity(0.6)
                .clipShape(RoundedRectangle(cornerRadius: 25))
                
                Button(action: {filterString = "New"}, label: {
                    Text("New")
                })
                .padding()
                .background(Color(.systemTeal))
                .opacity(0.6)
                .clipShape(RoundedRectangle(cornerRadius: 25))
                
                Button(action: {filterString = "In Progress"}, label: {
                    Text("In Progress")
                })
                .padding()
                .background(Color(.systemTeal))
                .opacity(0.6)
                .clipShape(RoundedRectangle(cornerRadius: 25))
                
                Button(action: {filterString = "Completed"
                    
                }, label: {
                    Text("Completed")
                })
                .padding()
                .background(Color(.systemTeal))
                .opacity(0.6)
                .clipShape(RoundedRectangle(cornerRadius: 25))
            }
            
            .padding(.top, 18)
            
            
            
            ListTaskView(filter: filterString)
            
        }
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
