//
//  OrderInfoDetailsInteracter.swift
//  OSA
//
//  Created by HappysanziMac on 09/06/21.
//  Copyright © 2021 Happy Sanz Tech. All rights reserved.
//

import Foundation


protocol OrderInfoDetailsBusinessLogic
{
    func fetchItems(request:OrderInfoDetailsModel.Fetch.Request)
}
protocol OrderInfoDetailsDataStore
{
  
}

class OrderInfoDetailsInteractor: OrderInfoDetailsBusinessLogic,OrderInfoDetailsDataStore
{

    var presenter2: OrderInfoDetailsPresentationLogic?
    var worker: OrderInfoDetailsWorker?
    var respData = [OrderInfoDetailsModels]()
    func fetchItems(request: OrderInfoDetailsModel.Fetch.Request) {
        if request.user_id == nil {
           self.presenter2?.presentFetchResults(resp: OrderInfoDetailsModel.Fetch.Response(testObj: respData, isError:true, message: "emptyyy" ))
        }
        worker = OrderInfoDetailsWorker()
        worker!.fetch(user_id:request.user_id!,order_id:request.order_id!, onSuccess: { (resp) in
            self.presenter2?.presentFetchResults(resp: OrderInfoDetailsModel.Fetch.Response(testObj: resp.testObj, isError: false, message: nil))
        }) { (errorMessage) in
            self.presenter2?.presentFetchResults(resp: OrderInfoDetailsModel.Fetch.Response(testObj: errorMessage.testObj, isError: true, message: "An error Occured"))
        }
    }
}

