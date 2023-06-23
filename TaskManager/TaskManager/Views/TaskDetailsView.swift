//
//  TaskDetailsView.swift
//  TaskManager
//
//  Created by Goqor Khechoyan on 13.06.23.
//

import SwiftUI

struct TaskDetailsView: View {
    @State var viewModel : TaskViewModel
    @Environment(\.scenePhase) private var scenePhase
    @Environment(\.dismiss) private var dismiss
    
    @State var task : Task
    @State var category : Category
    
    @State var title = String()
    @State var desc = String()
    @State var subTasks = [String]()
    @State var complitedSubTasks = [Bool]()
    
    @State var startDate = Date()
    @State var endDate = Date()
    
    @State var showHideDatsEdit = false
    
    
    @FocusState private var newSubtask : Int?
    
    
           
    
    
    var body: some View {
            VStack{
                HStack{
                    VStack(alignment: .leading,spacing: 8){
                        Text(title)
                               .font(.largeTitle)
                               .fontWeight(.semibold)
                        
                        Text(desc)
                        
                        
                        Text(viewModel.dateToString(date: startDate) + " - " + viewModel.dateToString(date: endDate))
                            .font(.system(size: 12))
                            .fontWeight(.semibold)
                            .foregroundColor(.secondary)
                            .onTapGesture {
                                showHideDatsEdit.toggle()
                            }
                        
                        if viewModel.completedSubTasksinTaskCounter(completedSubTasks: complitedSubTasks) == 0 {
                            ProgressView("0 %", value: Float(viewModel.completedSubTasksinTaskCounter(completedSubTasks: complitedSubTasks)), total: Float(complitedSubTasks.count))
                        }
                        else{
                            let percent : Float = {
                                
                                let calc = Float(viewModel.completedSubTasksinTaskCounter(completedSubTasks: complitedSubTasks)) / Float(complitedSubTasks.count) * 100
                                
                                if calc == 100 {
                                    task.status = true
                                }
                                else{
                                    task.status = false
                                }
                                
                                viewModel.saveContext()
                                
                                return calc
                            }()
                            ProgressView("\(Int(percent)) %", value: Float(viewModel.completedSubTasksinTaskCounter(completedSubTasks: complitedSubTasks)), total: Float(complitedSubTasks.count))
                            
                            
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                
                List {
                    ForEach(subTasks.indices, id: \.self) { index in
                        HStack(spacing: 12){
                            Image(systemName: complitedSubTasks[index] ? "checkmark.circle" : "circle")
                                .font(.title2)
                                .foregroundColor(Color(UIColor(red: CGFloat(category.r), green: CGFloat(category.g), blue: CGFloat(category.b), alpha: CGFloat(category.alpha) ) ))
                                .onTapGesture {
                                    withAnimation {
                                        complitedSubTasks[index].toggle()
                                        task.complitedSubTasks = complitedSubTasks
                                        viewModel.saveContext()
                                    }
                                }
                            
                            
                                TextField("", text: $subTasks[index])
                                .font(.title2)
                                .focused($newSubtask, equals: index)
                                .onSubmit{
                                    withAnimation{
                                        task.subTasks![index] = subTasks[index]
                                        
                                        let indexesToRemove = subTasks.indices.filter { subTasks[$0] == "" }
                                        subTasks = subTasks.filter { $0 != "" }
                                        
                                        for index in indexesToRemove.reversed() {
                                            complitedSubTasks.remove(at: index)
                                        }
                                        
                                        task.subTasks = subTasks
                                        task.complitedSubTasks = complitedSubTasks
                                        
                                        viewModel.saveContext()
                                    }
                                }
                                .onChange(of: scenePhase) { phase in
                                    withAnimation{
                                        task.subTasks![index] = subTasks[index]
                                        
                                        let indexesToRemove = subTasks.indices.filter { subTasks[$0] == "" }
                                        subTasks = subTasks.filter { $0 != "" }
                                        
                                        for index in indexesToRemove.reversed() {
                                            complitedSubTasks.remove(at: index)
                                        }
                                        
                                        task.subTasks = subTasks
                                        task.complitedSubTasks = complitedSubTasks
                                        
                                        viewModel.saveContext()
                                    }
                                }
                        }
                        .padding(.vertical, 8)
                        .transition(.opacity)
                    }
                    .onDelete { indices in
                        withAnimation {
                            if subTasks.count == 1 {
                                viewModel.deleteTask(indexSet: IndexSet(integer: viewModel.tasks.firstIndex(of: task)!))
                                dismiss()
                            } else {
                                subTasks.remove(atOffsets: indices)
                                complitedSubTasks.remove(atOffsets: indices)
                                
                                task.subTasks = subTasks
                                task.complitedSubTasks = complitedSubTasks
                                viewModel.saveContext()
                            }
                        }
                    }
                }
            }
        .onAppear(){
            if let taskTitle = task.title, let taskSubTask = task.subTasks{
                title = taskTitle
                desc = task.desc!
                
                subTasks = taskSubTask
                complitedSubTasks = task.complitedSubTasks!
                
                startDate = task.startDate!
                endDate = task.endDate!
            }
        }
        .onDisappear(){
            let indexesToRemove = subTasks.indices.filter { subTasks[$0] == "" }
            subTasks = subTasks.filter { $0 != "" }
            
            for index in indexesToRemove.reversed() {
                complitedSubTasks.remove(at: index)
            }
            
            task.title = title
            task.desc = desc
            
            task.subTasks = subTasks
            task.complitedSubTasks = complitedSubTasks
            
            viewModel.saveContext()
            
            viewModel.fetchTasks()
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true) // Hide the default back button
        .navigationBarItems(leading:
                                Button(action: {
                                    dismiss()
                                }) {
                                    Image(systemName: "chevron.backward")
                                        .foregroundColor(Color(UIColor(red: CGFloat(category.r), green: CGFloat(category.g), blue: CGFloat(category.b), alpha: CGFloat(category.alpha) ) ))
                                        .imageScale(.large)
                                }
        )
        .accentColor(Color(UIColor(red: CGFloat(category.r), green: CGFloat(category.g), blue: CGFloat(category.b), alpha: CGFloat(category.alpha) ) ))
        .toolbar{
            if newSubtask == 0 {
                Button(action: {
                    withAnimation {
                        let indexesToRemove = subTasks.indices.filter { subTasks[$0] == "" }
                        subTasks = subTasks.filter { $0 != "" }
                        
                        for index in indexesToRemove.reversed() {
                            complitedSubTasks.remove(at: index)
                        }
                        
                        task.subTasks = subTasks
                        task.complitedSubTasks = complitedSubTasks
                        
                        viewModel.saveContext()
                        
                        newSubtask = nil
                        viewModel.saveContext()
                    }
                }) {
                    HStack {
                        Text("Done")
                    }
                    .foregroundColor(Color(UIColor(red: CGFloat(category.r), green: CGFloat(category.g), blue: CGFloat(category.b), alpha: CGFloat(category.alpha) ) ))
                }
            }
            else{
                Button(action: {
                    withAnimation {
                        subTasks.insert("", at: 0)
                        complitedSubTasks.insert(false, at: 0)
                        
                        task.subTasks!.insert("", at: 0)
                        task.complitedSubTasks!.insert(false, at: 0)
                        
                        newSubtask = 0
                    }
                    
                }) {
                    HStack{
                        Image(systemName: "plus.circle.fill")
                        Text("New subTask")
                    }
                    .foregroundColor(Color(UIColor(red: CGFloat(category.r), green: CGFloat(category.g), blue: CGFloat(category.b), alpha: CGFloat(category.alpha) ) ))
                }
            }
        }
        .sheet(isPresented: $showHideDatsEdit) {
            NavigationView {
                Form{
                    Section(header: Text("Starting Date").font(.title3).fontWeight(.semibold)){
                        DatePicker("Starting date", selection: $startDate, in: Date.now...,  displayedComponents: .date)
                            .datePickerStyle(.graphical)
                    }
                    
                    Section(header: Text("End Date").font(.title3).fontWeight(.semibold)){
                        Text("Finish date")
                        DatePicker("Finish date", selection: $endDate, in: startDate...,  displayedComponents: .date)
                            .datePickerStyle(.graphical)
                    }
                }
                
                
                .navigationTitle("Dates")
                .navigationBarTitleDisplayMode(.inline)
                
                .navigationBarItems(
                    leading: Button("Close"){
                        showHideDatsEdit.toggle()
                    }.foregroundColor(.red),
                    
                    trailing: Button("Done"){
                        task.startDate = startDate
                        task.endDate = endDate
                        viewModel.saveContext()
                        showHideDatsEdit.toggle()
                    }
                )
            }
            .accentColor(Color(UIColor(red: CGFloat(task.category!.r), green: CGFloat(task.category!.g), blue: CGFloat(task.category!.b), alpha: CGFloat(task.category!.alpha) ) ))
        }
        .onTapGesture {
            withAnimation{
                let indexesToRemove = subTasks.indices.filter { subTasks[$0] == "" }
                subTasks = subTasks.filter { $0 != "" }
                
                for index in indexesToRemove.reversed() {
                    complitedSubTasks.remove(at: index)
                }
                
                newSubtask = nil
                
                viewModel.saveContext()
                hideKeyboard()
            }
        }
    }
}

//struct TaskDetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        //        TaskDetailsView(viewModel: TaskViewModel(), title: "Test", desc: "Fuck", startDate: Date(), endDate: Date(), subTasks: ["1","2","3","4"], complitedSubTasks: [false,false,true,false])
//        TaskDetailsView(task: Task())
//    }
//}
