//
//  TrackingWorker.swift
//  LILAMORENEW
//
//  Created by HappysanziMac on 13/07/21.
//

import Foundation
import UIKit

typealias TrackOrderresponseHandler = (_ response:TrackOrderModel.Fetch.Response) ->()

class TrackOrderWorker{
    
   var respData = [TrackOrderModels]()
    func fetch(user_id:String,order_id:String, onSuccess successCallback:(TrackOrderresponseHandler)?,onFailure failureCallback: @escaping(TrackOrderresponseHandler)) {
       let manager = APIManager()
       manager.callAPITrackOrder(
        user_id:user_id,order_id:order_id, onSuccess: { (resp)  in
               successCallback?(TrackOrderModel.Fetch.Response(testObj:resp, isError: false, message:nil))
           },
               onFailure: { (errorMessage) in
                   failureCallback(TrackOrderModel.Fetch.Response(testObj: self.respData , isError: true, message:nil))
           }
       )
   }
}
