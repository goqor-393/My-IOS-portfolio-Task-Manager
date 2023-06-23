//
//  AddCategory.swift
//  TaskManager
//
//  Created by Goqor Khechoyan on 15.06.23.
//

import SwiftUI

struct AddCategory: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.colorScheme) var colorScheme
    
    @StateObject var viewModel : CategoryViewModel
    
    @FocusState var focusNameField : Bool
    
    init(viewModel: CategoryViewModel) {
            _viewModel = StateObject(wrappedValue: viewModel)
        }
    
    @State private var categoryName = String()
    @State private var categoryColor = Color.blue
    
    private var colors : [Color] = [Color.red,
                                    Color.teal,
                                    Color.green,
                                    Color.blue,
                                    Color.mint,
                                    Color.orange,
                                    Color.yellow,
                                    Color.pink,
                                    Color.purple,
                                    Color.brown,
                                    Color.cyan,
                                    Color.indigo]
    
    var body: some View {
        NavigationView {
            Form{
                Section {
                    VStack(spacing: 12){
                        Image(systemName: "list.bullet")
                            .font(.system(size: 45))
                            .frame(width: 80, height: 80)
                            .background(categoryColor)
                            .foregroundColor(.white)
                            .cornerRadius(80)
                            .shadow(radius: 8)
                            .padding(.bottom)
                        
                        
                        TextField("Category Name", text: $categoryName)
                            .padding()
                            .multilineTextAlignment(.center)
                            .background(colorScheme == .dark ? Color.init(red: 28/255, green: 28/255, blue: 30/255) : Color.init(red: 243/255, green: 242/255, blue: 247/255))
                            .cornerRadius(12)
                            .focused($focusNameField)
                    }
                    .padding(.top)
                }
                
                Section {
                    ScrollView(.horizontal, showsIndicators: true) {
                        HStack{
                            ForEach(colors, id: \.self) { color in
                                Button(action: {
                                    categoryColor = color
                                }) {
                                    ZStack{
                                        if categoryColor == color {
                                            color
                                                .frame(width: 30, height: 30)
                                                .cornerRadius(100)
                                                .overlay(
                                                    RoundedRectangle(cornerRadius: 100)
                                                        .stroke(Color.secondary, lineWidth: 5)
                                                )
                                        }
                                        else{
                                            color
                                                .frame(width: 30, height: 30)
                                                .cornerRadius(100)
                                        }
                                    }
                                    .padding(.vertical)
                                    .padding(.horizontal, 5)
                                }
                            }
                        }
                    }
                }
                
                
            }
            
            .navigationTitle("New Category")
            .navigationBarTitleDisplayMode(.inline)
            
            .navigationBarItems(
                leading: Button("Close"){
                    presentationMode.wrappedValue.dismiss()
                }.foregroundColor(.red),
                
                trailing: Button("Add"){
                    let color = UIColor(categoryColor)
                    viewModel.addCategory(title: categoryName, r: Float(color.components.red), g: Float(color.components.green), b: Float(color.components.blue), alpha: Float(color.components.alpha))
                                          
                    presentationMode.wrappedValue.dismiss()
                }.disabled({
                    let categoryNameTrimmed = categoryName.trimmingCharacters(in: .whitespaces)
                    
                    if categoryNameTrimmed.isEmpty{
                        return true
                    }
                    
                     return false
                }()))
        }
        .onAppear(){
            focusNameField = true
        }
        .onTapGesture(){
            hideKeyboard()
        }
    }
}
