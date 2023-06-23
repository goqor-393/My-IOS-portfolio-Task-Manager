//
//  CategorySelecterView.swift
//  TaskManager
//
//  Created by Goqor Khechoyan on 16.06.23.
//

import SwiftUI

struct CategorySelecterView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject var catViewModel : CategoryViewModel
    @Binding var categoryIndex : Int
    
    var body: some View {
        VStack{
            List{
                ForEach(catViewModel.categories.indices){index in
                    Button {
                            categoryIndex = index
                            presentationMode.wrappedValue.dismiss()
                    } label: {
                        HStack{
                            Image(systemName: "list.bullet")
                                .frame(width: 30, height: 30)
                                .background(Color(UIColor(red: CGFloat(catViewModel.categories[index].r), green: CGFloat(catViewModel.categories[index].g), blue: CGFloat(catViewModel.categories[index].b), alpha: CGFloat(catViewModel.categories[index].alpha) ) ))
                                .foregroundColor(.white)
                                .cornerRadius(30)
                            
                            Text(catViewModel.categories[index].title!)
                                .font(.title2)
                                .truncationMode(.tail)
                            
                            Spacer()
                            
                            if categoryIndex == index {
                                Image(systemName: "checkmark")
                            }
                            
                        }
                        .padding(.vertical, 8)
                    }
                    .foregroundColor(.primary)
                }
            }
        }
        
        .navigationBarTitle("Categories")
        .navigationBarTitleDisplayMode(.inline)
    }
}

//struct CategorySelecterView_Previews: PreviewProvider {
//    static var previews: some View {
//        CategorySelecterView()
//    }
//}
