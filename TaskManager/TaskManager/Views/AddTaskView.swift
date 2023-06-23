//
//  AddTaskView.swift
//  TaskManager
//
//  Created by Goqor Khechoyan on 13.06.23.
//

import SwiftUI

struct AddTaskView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject var viewModel : TaskViewModel
    @StateObject var catViewModel : CategoryViewModel
    
    @State private var title = ""
    @State private var desc = ""
    
    @State private var startDate = Date()
    @State private var endDate = Date()
    
    @State private var subTaskTitle = String()
    @State private var subTasks = [String]()
    @State private var complitedSubTasks = [Bool]()
    
    @State private var categoryIndex = 0
    
    var body: some View {
        NavigationView {
            Form{
                Section("Category"){
                    NavigationLink {
                        CategorySelecterView(catViewModel: catViewModel, categoryIndex: $categoryIndex)
                    } label: {
                        HStack{
                            Text("Category")
                            
                            Spacer()
                            
                            Image(systemName: "list.bullet")
                                .frame(width: 25, height: 25)
                                .background(Color(UIColor(red: CGFloat(catViewModel.categories[categoryIndex].r), green: CGFloat(catViewModel.categories[categoryIndex].g), blue: CGFloat(catViewModel.categories[categoryIndex].b), alpha: CGFloat(catViewModel.categories[categoryIndex].alpha) ) ))
                                .foregroundColor(.white)
                                .cornerRadius(25)
                            
                            Text(catViewModel.categories[categoryIndex].title!)
                                .truncationMode(.tail)
                        }
                    }

                }
                
                
                Section("About task"){
                    TextField("Task title", text: $title)
                    TextField("Description", text: $desc)
                }
                
                Section("Dates"){
                    DatePicker("Starting date", selection: $startDate, in: Date.now...,  displayedComponents: .date)
                    DatePicker("Finish date", selection: $endDate, in: startDate...,  displayedComponents: .date)
                }
                
                Section("Add subtask"){
                    HStack{
                        TextField("Subtask title", text: $subTaskTitle)
                            .onSubmit {
                                let trimmedString = subTaskTitle.trimmingCharacters(in: .whitespaces)
                                if !subTaskTitle.isEmpty, !trimmedString.isEmpty {
                                    subTasks.append(subTaskTitle)
                                    complitedSubTasks.append(false)
                                    subTaskTitle = ""
                                }
                            }
                        Spacer()
                        
                        Button("Add"){
                            subTasks.append(subTaskTitle)
                            complitedSubTasks.append(false)
                            subTaskTitle = ""
                        }.disabled({
                            let trimmedString = subTaskTitle.trimmingCharacters(in: .whitespaces)
                            
                            if subTaskTitle.isEmpty, trimmedString.isEmpty {
                                return true;
                            }
                            
                            return false
                        }())
                    }
                }
                Section(subTasks.isEmpty ? "Here's no subtasks" : "Subtasks"){
                    List{
                        ForEach(subTasks, id: \.self){subTask in
                            Text(subTask)
                                .transition(.scale)
                        }
                        .onDelete { indices in
                            subTasks.remove(atOffsets: indices)
                            complitedSubTasks.remove(atOffsets: indices)
                        }
                    }
                }
            }
            
            .navigationTitle("New Task")
            .navigationBarTitleDisplayMode(.inline)
            
            .navigationBarItems(
                leading: Button("Close"){
                    presentationMode.wrappedValue.dismiss()
                }.foregroundColor(.red),
                
                trailing: Button("Add"){
                    let newTask = viewModel.addTask(title: title, desc: desc, startDate: startDate, endDate: endDate, subTasks: subTasks, complitedSubTasks: complitedSubTasks, category: catViewModel.categories[categoryIndex])
                    
                    presentationMode.wrappedValue.dismiss()
                }.disabled({
                    let trimmedTitle = title.trimmingCharacters(in: .whitespaces)
                    let trimmedDesc = desc.trimmingCharacters(in: .whitespaces)
                    let subtasksCount = subTasks.count
                    
                    if !trimmedTitle.isEmpty, !trimmedDesc.isEmpty, subtasksCount > 0 {
                        return false
                    }
                    
                    return true
                }())
            )
        }
        
    }
}

//struct AddTaskView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddTaskView()
//    }
//}
