//
//  ListRowItemview.swift
//  WyyKToDo
//
//  Created by Wykee Njenga on 5/18/22.
//

import SwiftUI

struct ListRowItemview: View {
    
    @Environment(\.managedObjectContext) var viewContext
    @ObservedObject var item: Item
    
    var body: some View {
        Toggle(isOn: $item.completion){
            Text(item.task ?? "")
                .font(.system(.title2, design: .rounded))
                .fontWeight(.heavy)
                .foregroundColor(item.completion ? .pink : .primary )
                .padding(.vertical, 12)
                .animation(.default)
        }// TOGGLE
        .toggleStyle(CheckBoxStyle())
        .onReceive(item.objectWillChange, perform: { _ in
            if self.viewContext.hasChanges{
                try? self.viewContext.save()
            }
            
        })
    }
}
