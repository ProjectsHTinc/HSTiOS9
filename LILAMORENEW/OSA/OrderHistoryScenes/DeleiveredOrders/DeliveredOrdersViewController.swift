//
//  DeliveredOrdersViewController.swift
//  OSA
//
//  Created by Happy Sanz Tech on 22/03/21.
//  Copyright © 2021 Happy Sanz Tech. All rights reserved.
//

import UIKit

protocol DeliveredOrdersDisplayLogic: AnyObject
{
    func successFetchedItems(viewModel: DeliveredOrdersModel.Fetch.ViewModel)
    func errorFetchingItems(viewModel: DeliveredOrdersModel.Fetch.ViewModel)
}

class DeliveredOrdersViewController: UIViewController, DeliveredOrdersDisplayLogic,UITableViewDelegate,UITableViewDataSource {
   
    @IBOutlet weak var deliveredOrderTableView: UITableView!
    @IBOutlet weak var orderCountLbl: UILabel!
    
    var displayedDeliveredOrdersData: [DeliveredOrdersModel.Fetch.ViewModel.DisplayedDeliveredOrdersData] = []
    
    var interactor1: DeliveredOrdersBusinessLogic?
    var ORDER_ID = [String]()
    var order_id = String()
    var selectedIndex = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        interactor1?.fetchItems(request: DeliveredOrdersModel.Fetch.Request(user_id:GlobalVariables.shared.customer_id,status:"Delivered"))
        // Do any additional setup after loading the view.
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
        let interactor1 = DeliveredOrdersInteractor()
        let presenter1 = DeliveredOrdersPresenter()
        viewController1.interactor1 = interactor1
        interactor1.presenter1 = presenter1
        presenter1.viewController1 = viewController1
      
    }
   
    func successFetchedItems(viewModel: DeliveredOrdersModel.Fetch.ViewModel) {
        displayedDeliveredOrdersData = viewModel.displayedDeliveredOrdersData
        self.orderCountLbl.text = String(GlobalVariables.shared.orderCount) + " Order"
        self.ORDER_ID.removeAll()
        
        for data in displayedDeliveredOrdersData {
            
            let order_id = data.order_id
            
            self.ORDER_ID.append(order_id!)
        }
        self.deliveredOrderTableView.reloadData()
    }
    
    func errorFetchingItems(viewModel: DeliveredOrdersModel.Fetch.ViewModel) {
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayedDeliveredOrdersData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DeliveredOrdersTableViewCell
        
        let data = displayedDeliveredOrdersData[indexPath.row]
        cell.orderId.text = "Order Id : \(ORDER_ID[indexPath.row])"
        cell.date.text = data.purchase_date!
        cell.price.text = "₹ \(data.total_amount!)"
        cell.status.text = data.status
        cell.selectionStyle = .none
        if self.selectedIndex == indexPath.row {
              cell.backgroundColor = UIColor.clear  // Highlight color
           }
//        cell.productImage.sd_setImage(with: URL(string: data.order_cover_img!), placeholderImage: UIImage(named: ""))
//        cell.viewProducts.tag = indexPath.row
//        cell.viewProducts.addTarget(self, action: #selector(viewProductsButtonClicked(sender:)), for: .touchUpInside)
//
      return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     
        let orderId = ORDER_ID[indexPath.row]
        self.order_id = orderId
        
//        tableView.cellForRow(at: indexPath)?.accessoryType = .none
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as!
   
        self.performSegue(withIdentifier: "to_deliveredOrderDetails", sender: self)
    }
            
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "to_deliveredOrderDetails")
        {
        let vc = segue.destination as! OrderHistoryDetailsViewController
            vc.order_id = self.order_id
        }
    }
}
