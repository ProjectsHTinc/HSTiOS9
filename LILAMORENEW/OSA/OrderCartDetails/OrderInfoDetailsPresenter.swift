//
//  OrderInfoDetailsPresenter.swift
//  OSA
//
//  Created by HappysanziMac on 09/06/21.
//  Copyright © 2021 Happy Sanz Tech. All rights reserved.
//

protocol OrderInfoDetailsPresentationLogic
{
  func presentFetchResults(resp: OrderInfoDetailsModel.Fetch.Response)
}

class OrderInfoDetailsPresenter: OrderInfoDetailsPresentationLogic
{
  weak var viewController2: OrderInfoDetailsDisplayLogic?
    
    // MARK: - Presentation logic
    func presentFetchResults(resp:OrderInfoDetailsModel.Fetch.Response) {
        // NOTE: Format the response from the Interactor and pass the result back to the View Controller
        var displayedOrderInfoDetailsData: [OrderInfoDetailsModel.Fetch.ViewModel.DisplayedOrderInfoDetailsData] = []
       
        for data in resp.testObj {
            let displayedOrderInfoDetailsDatas = OrderInfoDetailsModel.Fetch.ViewModel.DisplayedOrderInfoDetailsData(promo_amount: data.promo_amount!,purchase_order_status: data.purchase_order_status!, paid_amount: data.paid_amount!, payment_status: data.payment_status!, country_name: data.country_name!, wallet_amount: data.wallet_amount!,total_amount: data.total_amount!)
            displayedOrderInfoDetailsData.append(displayedOrderInfoDetailsDatas)
        }
        let viewModel = OrderInfoDetailsModel.Fetch.ViewModel(displayedOrderInfoDetailsData: displayedOrderInfoDetailsData)
        viewController2?.successFetchedItems(viewModel: viewModel)
    }
}
//,promo_amount: data.promo_amount!,paid_amount: data.paid_amount!,payment_status: data.payment_status!,wallet_amount: data.wallet_amount!
//var promo_amount : String?
//var purchase_order_status : String?
//var paid_amount : String?
//var payment_status : String?
//var country_name : String?
//var wallet_amount : String?
//var total_amount : String?
