//
//  ContentView.swift
//  WyyKToDo
//
//  Created by Wykee Njenga on 5/2/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    //MARK: - property
    @AppStorage("isDarkMode") var isDarkMode: Bool = false
    @State var task: String = ""
    @State var showNewTaskItem: Bool = false
    
    
    //MARK: - fetch data
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(//load data result
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    
    //MARK: - Body
    
    var body: some View {
        
        NavigationView {
            
            ZStack {
                //MARK: - MainView
                
                VStack{
                    //some views  here
                    //MARK: - Header
                    HStack(spacing: 10){
                        //title
                        Text("WyyK Task")
                            .font(.system(.largeTitle, design: .rounded))
                            .fontWeight(.heavy)
                            .padding(.leading, 4)
                        
                        Spacer()
                        
                        //Edit button
                        EditButton()
                            .font(.system(size: 16, weight: .semibold, design: .rounded))
                            .padding(.horizontal, 10)
                            .frame(minWidth: 70, minHeight: 24)
                            .background(
                                Capsule().stroke(.white, lineWidth: 2)
                            )
                        
                        //Theme
                        
                        Button(action: {
                            //change theme here
                            isDarkMode.toggle()
                            
                        }, label: {
                            Image(systemName: isDarkMode ? "moon.circle.fill": "moon.circle")
                                .resizable()
                                .frame(width: 24, height: 24)
                                .font(.system(.title, design: .rounded))
                        })
                        
                    }
                    .padding()
                    .foregroundColor(.white)
                    
                    Spacer(minLength: 80)
                    
                    //MARK: - NEW TASK button
                    
                    Button(action: {
                        showNewTaskItem = true
                    }, label: {
                        Image(systemName: "plus.circle")
                            .font(.system(size: 30, weight: .semibold, design: .rounded))
                        Text("New Task")
                            .font(.system(size: 24, weight: .bold, design: .rounded))
                    })
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 8)
                    .background(
                        LinearGradient(gradient: Gradient(colors: [.pink, .blue]), startPoint: .leading, endPoint: .trailing)
                            .clipShape(Capsule())
                    )
                    .shadow(color: .gray, radius: 12, x: 0, y: 4.0)
                    
                    //MARK: - TASKs
                    
                    List {
                        ForEach(items) { item in
                            NavigationLink {
                                VStack(alignment: .leading) {

                                    Text(item.task ?? "")
                                        .font(.headline)
                                        .foregroundColor(.gray)

                                    Text("Item at \(item.timestamp!, formatter: itemFormatter)")
                                        .font(.footnote)
                                        .foregroundColor(.gray)

                                } // : VStack
                            } label: {
                                
                                VStack(alignment: .leading) {
                                    
                                    ListRowItemview(item: item)
                                    
//                                    Text(item.task ?? "")
//                                        .font(.headline)
//                                        .fontWeight(.bold)
//                                        .foregroundColor(.pink)
//
//                                    Text("Item at \(item.timestamp!, formatter: itemFormatter)")
//                                        .font(.footnote)
//                                        .foregroundColor(.gray)
//
//                                    //Text(item.timestamp!, formatter: itemFormatter)
                                }
                            }
                        }
                        .onDelete(perform: deleteItems)
                    }//End list
                    .listStyle(InsetGroupedListStyle())
                    .shadow(color: Color(red: 0, green: 0, blue: 0), radius: 12)
                    .padding(.vertical, 0)
                    .frame(maxWidth: 640)
                }// : VStack
                .blur(radius: showNewTaskItem ? 8.0 : 0, opaque: false)
                .transition(.move(edge: .bottom))
                .animation(.easeInOut(duration: 0.5))
                

                //MARK: - NEW TASK ITEM
                if showNewTaskItem{
                    BlankView(
                        backgroundColor: isDarkMode ? .black : .gray,
                        backgroundOpacity: isDarkMode ? 0.3: 0.5)
                        .onTapGesture{
                            withAnimation(){
                                showNewTaskItem = false
                            }
                            
                        }
                    NewTaskItemView(isShowing: $showNewTaskItem)
                }
            }
            .onAppear(){
                UITableView.appearance().backgroundColor = UIColor.clear
            }
            .navigationBarHidden(true)
            .background(
                BackgroundImageView()
                    .blur(radius: showNewTaskItem ? 8.0 : 0, opaque: false)
            )
            .background{
                backgroundGradient.ignoresSafeArea(.all)
            }
            
        }// Navigation
        .navigationViewStyle(StackNavigationViewStyle())
    }
}


//MARK: - preview

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
