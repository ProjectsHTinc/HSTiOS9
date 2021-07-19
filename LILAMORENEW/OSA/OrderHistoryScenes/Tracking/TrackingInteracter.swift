//
//  TrackingInteracter.swift
//  LILAMORENEW
//
//  Created by HappysanziMac on 13/07/21.
//



import Foundation
import UIKit

protocol TrackOrderBusinessLogic
{
    func fetchItems(request: TrackOrderModel.Fetch.Request)
}
protocol TrackOrderDataStore
{
  
}

class TrackOrderInteractor: TrackOrderBusinessLogic, TrackOrderDataStore
{
    var presenter1: TrackOrderPresentationLogic?
    var worker: TrackOrderWorker?
    var respData = [TrackOrderModels]()
    func fetchItems(request: TrackOrderModel.Fetch.Request) {
//        if request.user_id == nil {
//           self.presenter?.presentFetchResults(resp: DashBoardModel.Fetch.Response(testObj: respData, isError:true, message: "emptyy" ))
//        }
        worker = TrackOrderWorker()
        worker!.fetch(user_id:request.user_id!,order_id:request.order_id!, onSuccess: { (resp) in
            self.presenter1?.presentFetchResults(resp: TrackOrderModel.Fetch.Response(testObj: resp.testObj, isError: false, message: nil))
        }) { (errorMessage) in
            self.presenter1?.presentFetchResults(resp: TrackOrderModel.Fetch.Response(testObj: errorMessage.testObj, isError: true, message: "An error Occured"))
        }
    }
}

