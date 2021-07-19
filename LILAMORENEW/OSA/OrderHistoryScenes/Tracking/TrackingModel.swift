//
//  TrackingModel.swift
//  LILAMORENEW
//
//  Created by HappysanziMac on 13/07/21.
//

import Foundation
import UIKit

struct TrackOrderModel{
    struct Fetch {
        
        struct Request
        {
            var user_id : String?
            var order_id : String?
        }
        
        struct Response
        {
            var testObj: [TrackOrderModels]
            var isError: Bool
            var message: String?
        }

        struct ViewModel
        {
           struct DisplayedTrackOrderData
           {
            var id : String?
            var updated_at : String?
            var purchase_order_id : String?
            var old_status : String?
            var order_id : String?
            var sent_msg : String?
            var status : String?
            var updated_by : String?

            
            }
              var displayedTrackOrderData: [DisplayedTrackOrderData]
    
        }
    }
}
