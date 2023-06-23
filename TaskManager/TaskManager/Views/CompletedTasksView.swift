//
//  CompletedTasksView.swift
//  TaskManager
//
//  Created by Goqor Khechoyan on 15.06.23.
//

import SwiftUI

struct CompletedTasksView: View {
    @StateObject var viewModel : TaskViewModel
    @StateObject var catViewModel : CategoryViewModel
    
    var body: some View {
        VStack{
            if !viewModel.tasks.isEmpty{
                List{
                    ForEach(viewModel.tasks.filter { $0.status }) {task in
                        let category = task.category
                        NavigationLink(destination: TaskDetailsView(viewModel: viewModel, task: task, category: task.category!)){
                            VStack{
                                VStack(alignment: .leading,spacing: 10){
                                    HStack{
                                        Color(
                                            UIColor(
                                                red: CGFloat(category!.r),
                                                green: CGFloat(category!.g),
                                                blue: CGFloat(category!.b),
                                                alpha: CGFloat(category!.alpha)
                                            )
                                        )
                                        .frame(width:20,height:20)
                                        .cornerRadius(20)
                                        
                                        Text(task.title!)
                                            .frame(width: 200, height: 30, alignment : .leading)
                                            .font(.title2)
                                            .truncationMode(.tail)
                                    }
                                    
                                    
                                    if let subtask =  task.subTasks {
                                        Text("\(subtask.count) subtasks")
                                            .foregroundColor(.secondary)
                                    }
                                    
                                    if let startDate =  task.startDate, let endDate =  task.endDate {
                                        Text(viewModel.dateToString(date: startDate) + " - " + viewModel.dateToString(date: endDate))
                                            .frame(width: 200, height: 30, alignment : .leading)
                                            .font(.system(size: 12))
                                    }
                                }
                            }
                        }
                    }
                    .onDelete(perform: viewModel.deleteTask)
                }
            }
        }
        .navigationTitle("Completed")
        .navigationBarTitleDisplayMode(.large)
    }
}

//struct CompletedTasksView_Previews: PreviewProvider {
//    static var previews: some View {
//        CompletedTasksView()
//    }
//}
