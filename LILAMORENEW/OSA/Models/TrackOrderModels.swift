//
//  TrackOrderModels.swift
//  LILAMORENEW
//
//  Created by HappysanziMac on 13/07/21.
//

import Foundation

class TrackOrderModels : NSObject {
    
    var id : String?
    var updated_at : String?
    var purchase_order_id : String?
    var old_status : String?
    var order_id : String?
    var sent_msg : String?
    var status : String?
    var updated_by : String?
    
    
     // MARK: Instance Method
     func loadFromDictionary(_ dict: [String: AnyObject])
     {
        if let data = dict["id"] as? String {
             self.id = data
        }
        if let data = dict["updated_at"] as? String {
            self.updated_at = data
        }
        if let data = dict["purchase_order_id"] as? String {
            self.purchase_order_id = data
        }
        if let data = dict["old_status"] as? String {
            self.old_status = data
        }
        if let data = dict["order_id"] as? String {
            self.order_id = data
        }
        if let data = dict["sent_msg"] as? String {
            self.sent_msg = data
        }
        if let data = dict["status"] as? String {
           self.status = data
        }
        if let data = dict["updated_by"] as? String {
           self.updated_by = data
        }
    }
     // MARK: Class Method
     class func build(_ dict: [String: AnyObject]) -> TrackOrderModels {
         let model = TrackOrderModels()
         model.loadFromDictionary(dict)
         return model
     }
}
