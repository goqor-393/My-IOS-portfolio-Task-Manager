//
//  CategoryTasksListView.swift
//  TaskManager
//
//  Created by Goqor Khechoyan on 15.06.23.
//

import SwiftUI

struct CategoryTasksListView: View {
    @StateObject var viewModel: CategoryViewModel
    @StateObject var taskViewModel: TaskViewModel
    @State var category: Category
    
    var body: some View {
        let categoryTasks = taskViewModel.tasks.filter { $0.category == category }
        
        ForEach(categoryTasks) {task in
            NavigationLink(destination: TaskDetailsView(viewModel: taskViewModel, task: task, category: task.category!)){
                VStack{
                    VStack(alignment: .leading,spacing: 10){
                        Text(task.title!)
                            .frame(width: 200, height: 30, alignment : .leading)
                            .font(.title2)
                            .truncationMode(.tail)
                        
                        
                        if let subtask =  task.subTasks {
                            Text("\(subtask.count) subtasks")
                                .foregroundColor(.secondary)
                        }
                        
                        if let startDate =  task.startDate, let endDate =  task.endDate {
                            Text(taskViewModel.dateToString(date: startDate) + " - " + taskViewModel.dateToString(date: endDate))
                                .frame(width: 200, height: 30, alignment : .leading)
                                .font(.system(size: 12))
                        }
                    }
                    
                   
                }
            }
        }
    }
}



//struct CategoryTasksListView_Previews: PreviewProvider {
//    static var previews: some View {
//        CategoryTasksListView()
//    }
//}
