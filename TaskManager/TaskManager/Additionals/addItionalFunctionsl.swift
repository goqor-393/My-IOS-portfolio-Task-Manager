//
//  addItional.swift
//  TaskManager
//
//  Created by Goqor Khechoyan on 15.06.23.
//

import Foundation
import SwiftUI
import UserNotifications

func hideKeyboard() {
    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
}

extension UIColor{
    var coreImageColor: CIColor{
        return CIColor(color: self)
    }
    
    var components : (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat){
        let coreImageColor = self.coreImageColor
        return (coreImageColor.red, coreImageColor.green, coreImageColor.blue, coreImageColor.alpha)
    }
}
