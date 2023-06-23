//
//  CompletedTasksView.swift
//  TaskManager
//
//  Created by Goqor Khechoyan on 15.06.23.
//

import SwiftUI

struct CategoriesView: View {
    @StateObject var viewModel: CategoryViewModel
    @StateObject var taskViewModel: TaskViewModel
    
    @State var deleteCategory = false
    
    var body: some View {
        VStack {
            List {
                ForEach(viewModel.categories) { category in
                    if deleteCategory {
                        deleteCategoryContent(category: category)
                    } else {
                        categoryContent(category: category)
                    }
                }
            }
            .listStyle(SidebarListStyle())
        }
        .navigationBarTitle("Categories")
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            if viewModel.categories.count > 1 {
                Button {
                    withAnimation {
                        deleteCategory.toggle()
                    }
                } label: {
                    Image(systemName: "trash")
                }
            }
        }
    }
    
    private func deleteCategoryContent(category: Category) -> some View {
        HStack {
            Color(
                UIColor(
                    red: CGFloat(category.r),
                    green: CGFloat(category.g),
                    blue: CGFloat(category.b),
                    alpha: CGFloat(category.alpha)
                )
            )
            .frame(width: 20, height: 20)
            .cornerRadius(20)
            
            Text(category.title!)
                .font(.title2)
                .truncationMode(.tail)
            
            Spacer()
            
            if category.title != "Uncategorized" {
                Button {
                    taskViewModel.deleteTaskByCategory(category: category)
                    viewModel.deleteCategory(category: category)
                } label: {
                    Image(systemName: "minus.circle.fill")
                        .foregroundColor(.red)
                }
            }
        }
        .padding(.vertical, 8)
    }
    
    private func categoryContent(category: Category) -> some View {
        Section(header: categoryHeader(category: category)) {
            CategoryTasksListView(viewModel: viewModel, taskViewModel: taskViewModel, category: category)
        }
    }
    
    private func categoryHeader(category: Category) -> some View {
        HStack {
            Color(
                UIColor(
                    red: CGFloat(category.r),
                    green: CGFloat(category.g),
                    blue: CGFloat(category.b),
                    alpha: CGFloat(category.alpha)
                )
            )
            .frame(width: 20, height: 20)
            .cornerRadius(20)
            
            Text(category.title!)
                .font(.title2)
                .truncationMode(.tail)
            
        }
    }
}

//struct CompletedTasksView_Previews: PreviewProvider {
//    static var previews: some View {
//        CompletedTasksView()
//    }
//}
