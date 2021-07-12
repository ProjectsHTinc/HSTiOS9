//
//  WalletApplyModel.swift
//  OSA
//
//  Created by Happy Sanz Tech on 22/03/21.
//  Copyright © 2021 Happy Sanz Tech. All rights reserved.
//

import Foundation
import UIKit

struct WalletApplyModel{
    struct Fetch {
        
        struct Request
        {
            
            var purchse_order_id : String?
            var user_id : String?
           
        }
        
        struct Response
        {
            var testObj: WalletApllyModels?
            var isError: Bool
            var message: String?
        }
        
        struct ViewModel
        {
            var msg : String?
            var status : String?
            var isError: Bool
            var message: String?
        }
    }
}
