//
//  OrderInfoDetailsModel.swift
//  OSA
//
//  Created by HappysanziMac on 09/06/21.
//  Copyright © 2021 Happy Sanz Tech. All rights reserved.
//

import Foundation
import UIKit

struct OrderInfoDetailsModel{
    struct Fetch {
        
        struct Request
        {
            var user_id : String?
            var order_id : String?
        }
        
        struct Response
        {
            var testObj: [OrderInfoDetailsModels]
            var isError: Bool
            var message: String?
        }

        struct ViewModel
        {
           struct DisplayedOrderInfoDetailsData
           {
            var promo_amount : String?
            var purchase_order_status : String?
            var paid_amount : String?
            var payment_status : String?
            var country_name : String?
            var wallet_amount : String?
            var total_amount : String?
            
            }
              var displayedOrderInfoDetailsData: [DisplayedOrderInfoDetailsData]
    
        }
    }
}
