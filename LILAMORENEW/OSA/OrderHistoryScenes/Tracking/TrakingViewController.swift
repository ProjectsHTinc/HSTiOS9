//
//  TrakingViewController.swift
//  LILAMORENEW
//
//  Created by HappysanziMac on 13/07/21.
//

import UIKit

protocol TrackOrderDisplayLogic: class
{
    func successFetchedItems(viewModel: TrackOrderModel.Fetch.ViewModel)
    func errorFetchingItems(viewModel: TrackOrderModel.Fetch.ViewModel)
}

class TrakingViewController: UIViewController,TrackOrderDisplayLogic {
    
    var interactor1: TrackOrderBusinessLogic?
    var order_id = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        interactor1?.fetchItems(request: TrackOrderModel.Fetch.Request(user_id:GlobalVariables.shared.customer_id,order_id:self.order_id))
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup()
    {
        let viewController1 = self
        let interactor1 = TrackOrderInteractor()
        let presenter1 = TrackOrderPresenter()
        viewController1.interactor1 = interactor1
        interactor1.presenter1 = presenter1
        presenter1.viewController1 = viewController1
    }
    
    func successFetchedItems(viewModel: TrackOrderModel.Fetch.ViewModel) {
        
    }
    
    func errorFetchingItems(viewModel: TrackOrderModel.Fetch.ViewModel) {
        
    }
}
