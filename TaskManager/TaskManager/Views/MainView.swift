//
//  ContentView.swift
//  TaskManager
//
//  Created by Goqor Khechoyan on 12.06.23.
//

import Foundation
import SwiftUI
import CoreData

struct MainView: View {
    @Environment(\.colorScheme) var colorScheme
    
    @StateObject private var viewModel = TaskViewModel()
    @StateObject private var catViewModel = CategoryViewModel()
    
    @FetchRequest(sortDescriptors: []) var Tasks : FetchedResults<Task>
    @State private var showHideAddView = false
    @State private var showHideCategoryAddView = false
    
    @State private var navigationBarColor: Color = .white
    
    var body: some View {
        NavigationView{
            VStack{
                List {
                    Section{
                        let color = colorScheme == .dark ? Color.init(red: 28/255, green: 28/255, blue: 30/255) : Color.white
                        NavigationLink(destination: CategoriesView(viewModel: catViewModel, taskViewModel: viewModel)){
                            
                            HStack{
                                VStack(alignment: .leading){
                                    Image(systemName: "list.bullet.circle.fill")
                                        .resizable()
                                        .frame(width: 30,height: 30)
                                    
                                    Text("Categories")
                                        .fontWeight(.semibold)
                                }
                                
                                Spacer()
                                
                                
                                Text("\(catViewModel.categories.count)")
                                    .font(.title3)
                                    .fontWeight(.semibold)
                            }
                            
                        }
                        .padding(4)
                        
                        NavigationLink(destination: CompletedTasksView(viewModel: viewModel, catViewModel: catViewModel)){
                            HStack{
                                VStack(alignment: .leading){
                                    Image(systemName: "checkmark.circle.fill")
                                        .resizable()
                                        .frame(width: 30,height: 30)
                                    
                                    Text("Completed")
                                        .fontWeight(.semibold)
                                }
                                
                                Spacer()
                                
                                if viewModel.tasks.count > 0{
                                    Text("\(viewModel.completedTasksCounter())/\(viewModel.tasks.count)")
                                        .font(.title3)
                                        .fontWeight(.semibold)
                                }
                                
                            }
                        }
                        .padding(4)
                        
                    }
                    .foregroundColor(.blue)
                    
                    TasksListView(viewModel: viewModel,catViewModel: catViewModel)
                    
                    
                }
                .listStyle(.insetGrouped)
                
                .toolbar{
                    Button(action: {
                        showHideCategoryAddView.toggle()
                    }) {
                        HStack{
                            Image(systemName: "plus.circle.fill")
                            Text("New Category")
                        }
                    }
                    
                    Button(action: {
                        showHideAddView.toggle()
                    }) {
                        HStack{
                            Image(systemName: "plus.circle.fill")
                            Text("New Task")
                        }
                    }
                }
            }
            .sheet(isPresented: $showHideAddView) {
                AddTaskView(viewModel: viewModel, catViewModel: catViewModel)
            }
            .sheet(isPresented: $showHideCategoryAddView) {
                AddCategory(viewModel: catViewModel)
            }
        }
    }
}


//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainView()
//    }
//}
