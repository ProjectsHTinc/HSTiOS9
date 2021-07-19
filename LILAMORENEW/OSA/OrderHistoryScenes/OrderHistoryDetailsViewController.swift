//
//  OrderHistoryDetailsViewController.swift
//  OSA
//
//  Created by Happy Sanz Tech on 24/03/21.
//  Copyright © 2021 Happy Sanz Tech. All rights reserved.
//

import UIKit

protocol OrderCartDetailsDisplayLogic: class
{
    func successFetchedItems(viewModel: OrderCartDetailsModel.Fetch.ViewModel)
    func errorFetchingItems(viewModel: OrderCartDetailsModel.Fetch.ViewModel)
}

protocol OrderInfoDetailsDisplayLogic: class
{
    func successFetchedItems(viewModel: OrderInfoDetailsModel.Fetch.ViewModel)
    func errorFetchingItems(viewModel: OrderInfoDetailsModel.Fetch.ViewModel)
}

class OrderHistoryDetailsViewController: UIViewController, OrderCartDetailsDisplayLogic, DeliveredOrdersDisplayLogic,OrderInfoDetailsDisplayLogic {
   
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var orderIdlbl: UILabel!
    @IBOutlet weak var orderDatelbl: UILabel!
    @IBOutlet weak var orderTotalLbl: UILabel!
    @IBOutlet weak var cusNameLbl: UILabel!
    @IBOutlet weak var phoneNumlbl: UILabel!
    @IBOutlet weak var streetlbl: UILabel!
    @IBOutlet weak var cityLbl: UILabel!
    @IBOutlet weak var pincodelbl: UILabel!
    @IBOutlet weak var itemsLbl: UILabel!
    @IBOutlet weak var walletLbl: UILabel!
    @IBOutlet weak var offerLbl: UILabel!
    @IBOutlet weak var payMethodLbl: UILabel!
    @IBOutlet weak var totalLbl: UILabel!
    
    var displayedOrderCartDetailsData: [OrderCartDetailsModel.Fetch.ViewModel.DisplayedOrderCartDetailsData] = []
    var displayedDeliveredOrdersData: [DeliveredOrdersModel.Fetch.ViewModel.DisplayedDeliveredOrdersData] = []
    var interactor: OrderCartDetailsBusinessLogic?
    var interactor1: DeliveredOrdersBusinessLogic?
    var interactor2: OrderInfoDetailsBusinessLogic?
    var order_id = String()
    var productName = [String]()
    var productImg = [String]()
    var OrderID = [String]()
    var productPrice = [String]()
    
    var selectedProdName = String()
    var selectedProdImg = String()
    var selectedProdPrice = String()
    
    var displayedOrderInfoDetailsData: [OrderInfoDetailsModel.Fetch.ViewModel.DisplayedOrderInfoDetailsData] = []
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(order_id)
        interactor?.fetchItems(request: OrderCartDetailsModel.Fetch.Request(user_id:GlobalVariables.shared.customer_id,order_id:self.order_id))
        interactor2?.fetchItems(request: OrderInfoDetailsModel.Fetch.Request(user_id:GlobalVariables.shared.customer_id,order_id:self.order_id))
        interactor1?.fetchItems(request: DeliveredOrdersModel.Fetch.Request(user_id:GlobalVariables.shared.customer_id,status:"Deliverd"))
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
        let viewController = self
        let interactor = OrderCartDetailsInteractor()
        let presenter = OrderCartDetailsPresenter()
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
        
        let viewController1 = self
        let interactor1 = DeliveredOrdersInteractor()
        let presenter1 = DeliveredOrdersPresenter()
        viewController1.interactor1 = interactor1
        interactor1.presenter1 = presenter1
        presenter1.viewController1 = viewController1
        
        let viewController2 = self
        let interactor2 = OrderInfoDetailsInteractor()
        let presenter2 = OrderInfoDetailsPresenter()
        viewController2.interactor2 = interactor2
        interactor2.presenter2 = presenter2
        presenter2.viewController2 = viewController2
       
    }
    
    @IBAction func trackPakageAction(_ sender: Any) {
        
        self.performSegue(withIdentifier: "toTrack", sender: self)
    }
    
    
    
    func successFetchedItems(viewModel: OrderCartDetailsModel.Fetch.ViewModel) {
  
        displayedOrderCartDetailsData = viewModel.displayedOrderCartDetailsData
        for data in displayedOrderCartDetailsData {
            
            let prodName = data.product_name
            let prodImg = data.product_cover_img
            let prodPrice = data.price
        
            self.productName.append(prodName!)
            self.productImg.append(prodImg!)
            self.productPrice.append(prodPrice!)
        }
            self.tableView.reloadData()
    }
    
    func errorFetchingItems(viewModel: OrderCartDetailsModel.Fetch.ViewModel) {
        
    }
    
    func successFetchedItems(viewModel: DeliveredOrdersModel.Fetch.ViewModel) {
        
        displayedDeliveredOrdersData = viewModel.displayedDeliveredOrdersData
        for data in displayedDeliveredOrdersData {
            let order_Id = data.order_id

                self.orderIdlbl.text = data.order_id
                self.orderDatelbl.text = data.purchase_date
                self.orderTotalLbl.text = data.total_amount
                self.cusNameLbl.text = data.full_name
                self.phoneNumlbl.text = data.mobile_number
                self.streetlbl.text = data.street
                self.cityLbl.text = data.city
                self.pincodelbl.text = data.pincode
                self.order_id = order_Id!
        }
    }
    
    func errorFetchingItems(viewModel: DeliveredOrdersModel.Fetch.ViewModel) {
        
    }
    
    func successFetchedItems(viewModel: OrderInfoDetailsModel.Fetch.ViewModel) {
        
        displayedOrderInfoDetailsData = viewModel.displayedOrderInfoDetailsData
         
        for data in displayedOrderInfoDetailsData {
            
            self.itemsLbl.text = data.paid_amount
            self.walletLbl.text = data.wallet_amount
            self.offerLbl.text = data.promo_amount
            self.totalLbl.text = "₹ \(data.total_amount!)"
            self.payMethodLbl.text = data.payment_status
        }
    }
    
    func errorFetchingItems(viewModel: OrderInfoDetailsModel.Fetch.ViewModel) {
//
    }
}

extension OrderHistoryDetailsViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayedOrderCartDetailsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! OrderCartDetailsTableViewCell
        
        let data = displayedOrderCartDetailsData[indexPath.row]
//        cell.status.text = data.order_id
        cell.productName.text = data.product_name
        cell.MrpPrice.text =  " ₹ \(data.price!)"
        cell.productImage.sd_setImage(with: URL(string: data.product_cover_img!), placeholderImage: UIImage(named: ""))
        cell.returnOrder.tag = indexPath.row
        cell.returnOrder.addTarget(self, action: #selector(returnOrRpeplace(sender:)), for: .touchUpInside)
        
        return cell
    }
    
    @objc func returnOrRpeplace(sender: UIButton){
        
         let buttonClicked = sender.tag
         print(buttonClicked)
         let selectedIndex = Int(buttonClicked)
         print(selectedIndex)
        
        let productImage = self.productImg[selectedIndex]
        let productName = self.productName[selectedIndex]
        let productprice = self.productPrice[selectedIndex]
      
        
        self.selectedProdName = String(productName)
        self.selectedProdImg = String(productImage)
        self.selectedProdPrice = String(productprice)
        
        self.performSegue(withIdentifier: "return_order", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "return_order")
        {
            let vc = segue.destination as! ReturnOrderViewController
            
            vc.productImg = self.selectedProdImg
            vc.productName = self.selectedProdName
            vc.order_id = self.order_id
            vc.productPrice = self.selectedProdPrice
            
        }
        else if (segue.identifier == "toTrack")
        {
            let vc = segue.destination as! TrakingViewController
            vc.order_id = self.order_id
        }
    }
}

