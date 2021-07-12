//
//  OrderInfoDetailsWorker.swift
//  OSA
//
//  Created by HappysanziMac on 09/06/21.
//  Copyright © 2021 Happy Sanz Tech. All rights reserved.
//



import Foundation
import UIKit

typealias OrderInfoDetailsresponseHandler = (_ response:OrderInfoDetailsModel.Fetch.Response) ->()

class OrderInfoDetailsWorker{
    
    var respData = [OrderInfoDetailsModels]()
    
   func fetch(user_id:String,order_id:String, onSuccess successCallback:(OrderInfoDetailsresponseHandler)?,onFailure failureCallback: @escaping(OrderInfoDetailsresponseHandler)) {
       let manager = APIManager()
       manager.callAPIOrderInfoDetails(
        user_id:user_id,order_id:order_id, onSuccess: { (resp)  in
               successCallback?(OrderInfoDetailsModel.Fetch.Response(testObj:resp, isError: false, message:nil))
           },
               onFailure: { (errorMessage) in
                   failureCallback(OrderInfoDetailsModel.Fetch.Response(testObj: self.respData, isError: true, message:nil))
           }
       )
   }
}
