//
//  GlobalVariables.swift
//  OPS
//
//  Created by Happy Sanz Tech on 20/01/21.
//

import UIKit

class GlobalVariables: NSObject {
    
    static let shared: GlobalVariables = GlobalVariables()
    
       var user_loginType = String()
       var Institute_Code = String()
       var leave_days = Int()
       var absent_days = Int()
       var od_days = Int()
       var total_working_days = Int()
       var present_days = Int()
  
}



