//
//  TrackingPresenter.swift
//  LILAMORENEW
//
//  Created by HappysanziMac on 13/07/21.
//


import Foundation

protocol TrackOrderPresentationLogic
{
  func presentFetchResults(resp: TrackOrderModel.Fetch.Response)
}

class TrackOrderPresenter: TrackOrderPresentationLogic
{
  weak var viewController1: TrackOrderDisplayLogic?
    
    // MARK: - Presentation logic
    func presentFetchResults(resp:TrackOrderModel.Fetch.Response) {
        // NOTE: Format the response from the Interactor and pass the result back to the View Controller
        var displayedTrackOrderData: [TrackOrderModel.Fetch.ViewModel.DisplayedTrackOrderData] = []
       
        for data in resp.testObj {
            let displayedTrackOrderDatas = TrackOrderModel.Fetch.ViewModel.DisplayedTrackOrderData(id: data.id!,updated_at: data.updated_at!,purchase_order_id: data.purchase_order_id!,old_status: data.old_status!,order_id: data.order_id!, sent_msg: data.sent_msg!, status: data.status!, updated_by: data.updated_by!)
            displayedTrackOrderData.append(displayedTrackOrderDatas)
        }
        let viewModel = TrackOrderModel.Fetch.ViewModel(displayedTrackOrderData: displayedTrackOrderData)
        viewController1?.successFetchedItems(viewModel: viewModel)
    }
}
