//
//  NewTaskItemView.swift
//  WyyKToDo
//
//  Created by Wykee Njenga on 5/17/22.
//

import SwiftUI

struct NewTaskItemView: View {
    
    @AppStorage("isDarkMode") var isDarkMode: Bool = false
    @Binding var isShowing: Bool
    @Environment(\.managedObjectContext) private var viewContext
    @State var task: String = ""
    
    private var isButtonDisable: Bool {
        task.isEmpty
    }
    
    //MARK: - functions
    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()
            newItem.task = task
            newItem.completion = false
            newItem.id = UUID()
            
            

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
            
            task = ""
            hideKeyBoard()
            isShowing = false
        }
    }
    
    var body: some View {
        VStack {
            Spacer()
            VStack(alignment: .center, spacing: 16){
                
                TextField("New task", text: $task)
                    .foregroundColor(.pink)
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .padding()
                    .background(
                        isDarkMode ? Color(UIColor.tertiarySystemBackground) : Color(UIColor.secondarySystemBackground)
                    )
                    .cornerRadius(10)
                
                Button(action: {
                    addItem()
                    
                }, label: {
                    Spacer()
                    Text("SAVE")
                        .font(.system(size: 24, weight: .bold, design: .rounded))
                        .padding(12)
                    Spacer()
                })
                .disabled(isButtonDisable)
                .foregroundColor(.white)
                .background(isButtonDisable ? .blue: .pink)
                .cornerRadius(10)
                .padding()
            }
            .padding(.horizontal)
            .padding(.vertical, 20)
            .background(
                isDarkMode ? Color(UIColor.secondarySystemBackground) : .white)
            .cornerRadius(16)
            .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.5), radius: 24)
            .frame(maxWidth: 640)
        } // : VStack
        
        .padding()
    }
}

struct NewTaskItemView_Previews: PreviewProvider {
    static var previews: some View {
        NewTaskItemView(isShowing: .constant(true))
            .background(Color.gray.edgesIgnoringSafeArea(.all))
    }
}
